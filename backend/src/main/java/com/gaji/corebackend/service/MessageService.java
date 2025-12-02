package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.Message;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.repository.ConversationMapper;
import com.gaji.corebackend.repository.MessageMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * 메시지 서비스
 * 
 * 메시지 생성, AI 응답 처리, 폴링 로직
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MessageService {

    private final ConversationMapper conversationMapper;
    private final MessageMapper messageMapper;
    private final WebClient.Builder webClientBuilder;
    private final RedisTemplate<String, String> redisTemplate;

    @Value("${fastapi.url:http://localhost:8000}")
    private String fastApiUrl;

    private static final String CONVERSATION_NOT_FOUND = "Conversation not found: ";
    private static final String TASK_PREFIX = "task:";
    private static final String STATUS_COMPLETED = "completed";
    private static final String STATUS_FAILED = "failed";
    private static final String STATUS_PROCESSING = "processing";
    private static final String STATUS_QUEUED = "queued";
    private static final int LONG_POLL_TIMEOUT_MS = 2000; // 2 seconds

    /**
     * Submit user message and trigger AI generation
     */
    @Transactional
    public MessageResponse submitMessage(UUID conversationId, UUID userId, CreateMessageRequest request) {
        // Verify conversation exists
        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        // Save user message to DB
        Message userMessage = new Message();
        userMessage.setId(UUID.randomUUID());
        userMessage.setConversation(conversation);
        userMessage.setRole("user");
        userMessage.setContent(request.getContent());

        conversationMapper.insertMessage(userMessage);
        conversationMapper.updateMessageCount(conversationId);

        log.info("User message saved: conversationId={}, messageId={}", conversationId, userMessage.getId());

        // Get conversation history for AI context
        List<Message> messages = conversationMapper.findMessagesByConversationId(conversationId);
        List<FastAPIGenerationRequest.MessageHistory> history = messages.stream()
                .filter(msg -> !msg.getId().equals(userMessage.getId())) // Exclude the just-saved message
                .map(msg -> FastAPIGenerationRequest.MessageHistory.builder()
                        .role(msg.getRole())
                        .content(msg.getContent())
                        .build())
                .collect(Collectors.toList());

        // Build scenario context (system prompt)
        String scenarioContext = buildScenarioContext(conversation);

        // Call FastAPI to trigger AI generation
        FastAPIGenerationRequest fastApiRequest = FastAPIGenerationRequest.builder()
                .conversationId(conversationId.toString())
                .scenarioContext(scenarioContext)
                .userMessage(request.getContent())
                .history(history)
                .build();

        try {
            webClientBuilder.build()
                    .post()
                    .uri(fastApiUrl + "/api/ai/generate")
                    .bodyValue(fastApiRequest)
                    .retrieve()
                    .toBodilessEntity()
                    .block();

            log.info("AI generation triggered: conversationId={}", conversationId);

        } catch (Exception e) {
            log.error("Failed to trigger AI generation: conversationId={}", conversationId, e);
            // Continue - polling will handle timeout/fallback
        }

        return MessageResponse.builder()
                .id(userMessage.getId())
                .conversationId(conversationId)
                .role("user")
                .content(userMessage.getContent())
                .createdAt(userMessage.getCreatedAt())
                .build();
    }

    /**
     * Poll for AI response
     */
    public PollResponse pollResponse(UUID conversationId) {
        // Check Redis for task status
        String statusKey = TASK_PREFIX + conversationId + ":status";
        String contentKey = TASK_PREFIX + conversationId + ":content";
        String errorKey = TASK_PREFIX + conversationId + ":error";

        String status = redisTemplate.opsForValue().get(statusKey);

        if (status == null) {
            // No Redis key - check if AI message already in DB
            List<Message> messages = conversationMapper.findMessagesByConversationId(conversationId);
            Message lastAssistantMessage = messages.stream()
                    .filter(msg -> "assistant".equals(msg.getRole()))
                    .reduce((first, second) -> second) // Get last
                    .orElse(null);

            if (lastAssistantMessage != null) {
                return PollResponse.builder()
                        .status(STATUS_COMPLETED)
                        .content(lastAssistantMessage.getContent())
                        .messageId(lastAssistantMessage.getId())
                        .build();
            }

            return PollResponse.builder()
                    .status("unknown")
                    .error("Task status not found in Redis")
                    .build();
        }

        // Handle different statuses
        switch (status) {
            case STATUS_COMPLETED:
                String content = redisTemplate.opsForValue().get(contentKey);
                if (content != null) {
                    // Save AI message to DB
                    UUID messageId = saveAIMessage(conversationId, content);

                    // Clear Redis keys
                    redisTemplate.delete(statusKey);
                    redisTemplate.delete(contentKey);

                    log.info("AI message saved and Redis cleared: conversationId={}, messageId={}", conversationId, messageId);

                    return PollResponse.builder()
                            .status(STATUS_COMPLETED)
                            .content(content)
                            .messageId(messageId)
                            .build();
                }
                break;

            case STATUS_FAILED:
                String error = redisTemplate.opsForValue().get(errorKey);
                return PollResponse.builder()
                        .status(STATUS_FAILED)
                        .error(error != null ? error : "Unknown error")
                        .build();

            case STATUS_PROCESSING:
                // Long polling: hold for up to 2s if still processing
                return longPollForCompletion(conversationId, statusKey, contentKey);

            case STATUS_QUEUED:
                return PollResponse.builder()
                        .status(STATUS_QUEUED)
                        .build();
                        
            default:
                return PollResponse.builder()
                        .status(status)
                        .build();
        }

        return PollResponse.builder()
                .status(status)
                .build();
    }

    /**
     * Long polling: wait for completion or timeout
     */
    private PollResponse longPollForCompletion(UUID conversationId, String statusKey, String contentKey) {
        long startTime = System.currentTimeMillis();
        long timeout = startTime + LONG_POLL_TIMEOUT_MS;
        
        String errorKey = TASK_PREFIX + conversationId + ":error";

        while (System.currentTimeMillis() < timeout) {
            String currentStatus = redisTemplate.opsForValue().get(statusKey);

            if (STATUS_COMPLETED.equals(currentStatus)) {
                String content = redisTemplate.opsForValue().get(contentKey);
                if (content != null) {
                    UUID messageId = this.saveAIMessageInternal(conversationId, content);

                    redisTemplate.delete(statusKey);
                    redisTemplate.delete(contentKey);

                    return PollResponse.builder()
                            .status(STATUS_COMPLETED)
                            .content(content)
                            .messageId(messageId)
                            .build();
                }
            } else if (STATUS_FAILED.equals(currentStatus)) {
                String error = redisTemplate.opsForValue().get(errorKey);
                return PollResponse.builder()
                        .status(STATUS_FAILED)
                        .error(error)
                        .build();
            }

            // Sleep for 100ms before next check
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }
        }

        // Timeout - still processing
        return PollResponse.builder()
                .status(STATUS_PROCESSING)
                .build();
    }

    /**
     * Save AI message to DB (internal method for transactional proxy)
     */
    @Transactional
    public UUID saveAIMessageInternal(UUID conversationId, String content) {
        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));
        
        Message aiMessage = new Message();
        aiMessage.setId(UUID.randomUUID());
        aiMessage.setConversation(conversation);
        aiMessage.setRole("assistant");
        aiMessage.setContent(content);

        conversationMapper.insertMessage(aiMessage);
        conversationMapper.updateMessageCount(conversationId);

        return aiMessage.getId();
    }
    
    /**
     * Save AI message to DB (wrapper)
     */
    private UUID saveAIMessage(UUID conversationId, String content) {
        return this.saveAIMessageInternal(conversationId, content);
    }

    /**
     * Build scenario context for AI
     */
    private String buildScenarioContext(Conversation conversation) {
        // TODO: Fetch actual scenario data and build rich context
        // For now, return basic context
        return String.format(
                "You are participating in a conversation for scenario ID: %s. " +
                "Scenario type: %s. Character: %s. " +
                "Respond naturally and stay in character.",
                conversation.getScenarioId(),
                conversation.getScenarioType(),
                conversation.getCharacterVectordbId()
        );
    }
}
