package com.gaji.chat.application;

import com.fasterxml.jackson.databind.JsonNode;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.ai.application.AiChatProxyService;
import com.gaji.shared.contract.dto.*;
import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.model.RagChatTurnCitation;
import com.gaji.chat.domain.model.RagChatTurnMetadata;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.exception.ResourceNotFoundException;
import com.gaji.common.security.UserPrincipal;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndex;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndexHit;
import com.gaji.chat.domain.repository.ConversationMessageSearchResult;
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.chat.domain.repository.MessageSearchResult;
import com.gaji.chat.domain.repository.RagChatTurnMetadataRepository;
import com.gaji.content.application.ContentReadFacade;
import com.gaji.scenario.application.ScenarioFacade;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.http.codec.ServerSentEvent;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.function.Consumer;
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

    private final ConversationRepository conversationRepository;
    private final MessageRepository messageRepository;
    private final ConversationFacade conversationFacade;
    private final RedisTemplate<String, String> redisTemplate;
    private final ScenarioFacade scenarioFacade;
    private final ContentReadFacade contentReadFacade;
    private final AiChatProxyService aiChatProxyService;
    private final TransactionTemplate transactionTemplate;
    private final RagChatTurnMetadataRepository ragChatTurnMetadataRepository;
    private final ConversationMessageSearchIndex conversationMessageSearchIndex;

    @Value("${gaji.ai.chat.recent-history-message-limit:7}")
    private int recentHistoryMessageLimit;

    @Value("${gaji.ai.chat.max-output-tokens:768}")
    private int chatMaxOutputTokens;

    private static final String CONVERSATION_NOT_FOUND = "Conversation not found: ";
    private static final String TASK_PREFIX = "task:";
    private static final String STATUS_COMPLETED = "completed";
    private static final String STATUS_FAILED = "failed";
    private static final String STATUS_PROCESSING = "processing";
    private static final String STATUS_QUEUED = "queued";
    private static final int LONG_POLL_TIMEOUT_MS = 2000; // 2 seconds
    private static final String PRIDE_AND_PREJUDICE_CANONICAL_NOVEL_ID = "00000000-0000-0000-0000-000000001342";

    /**
     * Get messages for a conversation
     */
    @Transactional(readOnly = true)
    public List<MessageResponse> getMessages(UUID conversationId) {
        // Verify conversation exists
        conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        List<Message> messages = messageRepository.findByConversationId(conversationId);
        
        return messages.stream()
                .map(msg -> MessageResponse.builder()
                        .id(msg.getId())
                        .conversationId(msg.getConversationId())
                        .role(msg.getRole())
                        .content(msg.getContent())
                        .createdAt(msg.getCreatedAt())
                        .build())
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<MessageSearchResponse> searchOwnedMessages(
            UserPrincipal currentUser,
            String query,
            int page,
            int size
    ) {
        requireAuthenticated(currentUser);
        String normalizedQuery = normalizeMessageSearchQuery(query);
        List<MessageSearchResult> results = messageRepository.searchOwnedMessages(
                currentUser.getUserId(),
                normalizedQuery,
                messageSearchPageRequest(page, size)
        );
        return toMessageSearchResponses(results, normalizedQuery);
    }

    @Transactional(readOnly = true)
    public List<ConversationMessageSearchResponse> searchOwnedConversationMessageCards(
            UserPrincipal currentUser,
            String query,
            int size
    ) {
        requireAuthenticated(currentUser);
        String normalizedQuery = normalizeMessageSearchQuery(query);
        int limit = Math.max(1, Math.min(size, 20));
        List<ConversationMessageSearchResult> results = null;
        if (conversationMessageSearchIndex.isEnabled()) {
            try {
                results = toConversationMessageSearchResults(
                        conversationMessageSearchIndex.searchOwnedConversationMessageCards(
                                currentUser.getUserId(),
                                normalizedQuery,
                                limit
                        )
                );
            } catch (Exception exc) {
                log.warn("conversation_message_elasticsearch_search_failed_fallback_to_postgres", exc);
            }
        }
        if (results == null) {
            results = messageRepository.searchOwnedConversationMessageCards(
                    currentUser.getUserId(),
                    normalizedQuery,
                    limit
            );
        }
        return toConversationMessageSearchResponses(results, normalizedQuery);
    }

    @Transactional(readOnly = true)
    public List<MessageSearchResponse> searchOwnedMessagesInConversation(
            UUID conversationId,
            UserPrincipal currentUser,
            String query,
            int page,
            int size
    ) {
        requireAuthenticated(currentUser);
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));
        if (!conversation.getUserId().equals(currentUser.getUserId()) && !isOperator(currentUser)) {
            throw new ForbiddenException("Only the conversation owner can search messages");
        }

        String normalizedQuery = normalizeMessageSearchQuery(query);
        List<MessageSearchResult> results = messageRepository.searchOwnedMessagesInConversation(
                conversation.getUserId(),
                conversationId,
                normalizedQuery,
                messageSearchPageRequest(page, size)
        );
        return toMessageSearchResponses(results, normalizedQuery);
    }

    @Transactional
    public void deleteMessage(UUID conversationId, UUID messageId, UserPrincipal currentUser) {
        requireAuthenticated(currentUser);
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));
        if (!conversation.getUserId().equals(currentUser.getUserId()) && !isOperator(currentUser)) {
            throw new ForbiddenException("Only the conversation owner can delete messages");
        }

        Message message = messageRepository.findById(messageId)
                .orElseThrow(() -> new ResourceNotFoundException("Message not found: " + messageId));
        if (!conversationId.equals(message.getConversationId())) {
            throw new BadRequestException("Message does not belong to the conversation");
        }

        messageRepository.deleteById(messageId);
        int currentCount = conversation.getMessageCount() == null ? 0 : conversation.getMessageCount();
        conversationRepository.updateMessageCount(conversationId, Math.max(0, currentCount - 1));
        conversationMessageSearchIndex.deleteMessage(messageId);
    }

    /**
     * Submit user message and trigger AI generation
     */
    @Transactional
    public MessageResponse submitMessage(UUID conversationId, UUID userId, CreateMessageRequest request) {
        // Verify conversation exists
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        // Save user message to DB
        Message userMessage = new Message();
        userMessage.setConversationId(conversationId);
        userMessage.setRole("user");
        userMessage.setContent(request.getContent());

        messageRepository.save(userMessage);
        conversationRepository.incrementMessageCount(conversationId);
        indexMessageForSearch(conversation, userMessage);

        log.info("User message saved: conversationId={}, messageId={}", conversationId, userMessage.getId());
        log.info(
                "Legacy async AI generation is retired; use /chat-completion for Spring pgvector/Elasticsearch RAG. conversationId={}",
                conversationId
        );

        return MessageResponse.builder()
                .id(userMessage.getId())
                .conversationId(conversationId)
                .role("user")
                .content(userMessage.getContent())
                .createdAt(userMessage.getCreatedAt())
                .build();
    }

    /**
     * Submit user message and complete the assistant turn through the canonical RAG chat endpoint.
     */
    public ConversationChatCompletionResponse submitMessageWithChatCompletion(
            UUID conversationId,
            UserPrincipal currentUser,
            CreateMessageRequest request
    ) {
        if (request == null || request.getContent() == null || request.getContent().isBlank()) {
            throw new BadRequestException("Message content is required");
        }

        ChatCompletionPreparation preparation = java.util.Objects.requireNonNull(
                transactionTemplate.execute(status -> prepareChatCompletion(conversationId, currentUser, request)),
                "chat completion preparation must not be null"
        );

        long providerStartedAt = System.nanoTime();
        JsonNode completion = aiChatProxyService.completeConversationChat(currentUser, preparation.request());
        double providerElapsedMs = (System.nanoTime() - providerStartedAt) / 1_000_000.0;
        String answer = completion.path("answer").asText(null);
        if (answer == null || answer.isBlank()) {
            throw new BadRequestException("AI completion returned an empty answer");
        }

        AssistantTurnPersistence assistantTurn = java.util.Objects.requireNonNull(
                transactionTemplate.execute(status -> saveAssistantMessageAndMetadata(
                        conversationId,
                        preparation.userMessage().getId(),
                        answer,
                        completion,
                        providerElapsedMs
                )),
                "assistant turn persistence must not be null"
        );

        return ConversationChatCompletionResponse.builder()
                .userMessage(preparation.userMessage())
                .assistantMessage(assistantTurn.assistantMessage())
                .rag(completion.get("rag"))
                .ragMetadataId(assistantTurn.ragMetadataId())
                .provider(completion.path("provider").asText(null))
                .model(completion.path("model").asText(null))
                .tokenUsage(completion.hasNonNull("token_usage") ? completion.get("token_usage").asInt() : null)
                .providerElapsedMs(providerElapsedMs)
                .build();
    }

    public void submitMessageWithChatCompletionStream(
            UUID conversationId,
            UserPrincipal currentUser,
            CreateMessageRequest request,
            Consumer<ChatCompletionStreamEvent> eventConsumer
    ) {
        if (request == null || request.getContent() == null || request.getContent().isBlank()) {
            throw new BadRequestException("Message content is required");
        }

        ChatCompletionPreparation preparation = java.util.Objects.requireNonNull(
                transactionTemplate.execute(status -> prepareChatCompletion(conversationId, currentUser, request)),
                "chat completion preparation must not be null"
        );
        eventConsumer.accept(new ChatCompletionStreamEvent("user_message", preparation.userMessage()));

        long providerStartedAt = System.nanoTime();
        boolean completed = false;
        for (ServerSentEvent<JsonNode> event : aiChatProxyService.streamConversationChat(
                currentUser,
                preparation.request()
        ).toIterable()) {
            String eventName = firstNonBlank(event.event(), "message");
            JsonNode data = event.data();
            if ("delta".equals(eventName) || "context_ready".equals(eventName)) {
                eventConsumer.accept(new ChatCompletionStreamEvent(eventName, data));
                continue;
            }
            if ("error".equals(eventName)) {
                eventConsumer.accept(new ChatCompletionStreamEvent("error", data));
                return;
            }
            if (!"completed".equals(eventName) || data == null || data.isNull()) {
                continue;
            }

            double providerElapsedMs = (System.nanoTime() - providerStartedAt) / 1_000_000.0;
            String answer = data.path("answer").asText(null);
            if (answer == null || answer.isBlank()) {
                throw new BadRequestException("AI completion returned an empty answer");
            }

            AssistantTurnPersistence assistantTurn = java.util.Objects.requireNonNull(
                    transactionTemplate.execute(status -> saveAssistantMessageAndMetadata(
                            conversationId,
                            preparation.userMessage().getId(),
                            answer,
                            data,
                            providerElapsedMs
                    )),
                    "assistant turn persistence must not be null"
            );

            ConversationChatCompletionResponse response = ConversationChatCompletionResponse.builder()
                    .userMessage(preparation.userMessage())
                    .assistantMessage(assistantTurn.assistantMessage())
                    .rag(data.get("rag"))
                    .ragMetadataId(assistantTurn.ragMetadataId())
                    .provider(data.path("provider").asText(null))
                    .model(data.path("model").asText(null))
                    .tokenUsage(data.hasNonNull("token_usage") ? data.get("token_usage").asInt() : null)
                    .providerElapsedMs(providerElapsedMs)
                    .build();
            eventConsumer.accept(new ChatCompletionStreamEvent("completed", response));
            completed = true;
        }

        if (!completed) {
            throw new BadRequestException("AI streaming completion ended before a completed event");
        }
    }

    public RagChatSourceResponse getRagSources(
            UUID conversationId,
            UUID assistantMessageId,
            UserPrincipal currentUser
    ) {
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));
        if (!conversation.getUserId().equals(currentUser.getUserId()) && !isOperator(currentUser)) {
            throw new ForbiddenException("Only the conversation owner can inspect RAG sources");
        }

        RagChatTurnMetadata metadata = ragChatTurnMetadataRepository.findByAssistantMessageId(assistantMessageId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "RAG metadata not found for assistant message: " + assistantMessageId
                ));
        if (!conversationId.equals(metadata.getConversationId())) {
            throw new ResourceNotFoundException("RAG metadata not found for this conversation");
        }

        List<String> passageIds = metadata.getCitations().stream()
                .map(RagChatTurnCitation::getPassageId)
                .filter(passageId -> passageId != null && !passageId.isBlank())
                .distinct()
                .toList();
        Map<String, JsonNode> sourcesByPassageId = lookupSourcesByPassageId(currentUser, metadata, passageIds);
        List<String> missingPassageIds = new ArrayList<>();

        List<RagChatSourceResponse.CitationSource> citations = metadata.getCitations().stream()
                .map(citation -> {
                    JsonNode source = sourcesByPassageId.get(citation.getPassageId());
                    if (source == null) {
                        missingPassageIds.add(citation.getPassageId());
                    }
                    return RagChatSourceResponse.CitationSource.builder()
                            .citationId(citation.getId())
                            .passageId(citation.getPassageId())
                            .finalRank(citation.getFinalRank())
                            .vectorRank(citation.getVectorRank())
                            .bm25Rank(citation.getBm25Rank())
                            .manifestId(citation.getManifestId())
                            .chapter(citation.getChapter())
                            .sourceAvailable(source != null)
                            .text(source == null ? null : textOrNull(source.get("text")))
                            .metadata(source == null ? null : source.get("metadata"))
                            .build();
                })
                .toList();

        return RagChatSourceResponse.builder()
                .conversationId(conversationId)
                .assistantMessageId(assistantMessageId)
                .ragMetadataId(metadata.getId())
                .novelId(metadata.getNovelId())
                .groundingStatus(metadata.getGroundingStatus())
                .fallbackUsed(metadata.getFallbackUsed())
                .fallbackReason(metadata.getFallbackReason())
                .citations(citations)
                .missingPassageIds(missingPassageIds)
                .build();
    }

    private Map<String, JsonNode> lookupSourcesByPassageId(
            UserPrincipal currentUser,
            RagChatTurnMetadata metadata,
            List<String> passageIds
    ) {
        Map<String, JsonNode> sourcesByPassageId = new LinkedHashMap<>();
        if (metadata.getNovelId() == null || passageIds.isEmpty()) {
            return sourcesByPassageId;
        }

        JsonNode sourceResponse = aiChatProxyService.lookupPassageSources(
                currentUser,
                metadata.getNovelId(),
                passageIds
        );
        JsonNode passages = sourceResponse == null ? null : sourceResponse.get("passages");
        if (passages != null && passages.isArray()) {
            for (JsonNode passage : passages) {
                String passageId = textOrNull(passage.get("passage_id"));
                if (passageId != null) {
                    sourcesByPassageId.put(passageId, passage);
                }
            }
        }
        return sourcesByPassageId;
    }

    private ChatCompletionPreparation prepareChatCompletion(
            UUID conversationId,
            UserPrincipal currentUser,
            CreateMessageRequest request
    ) {
        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        if (!conversation.getUserId().equals(currentUser.getUserId()) && !isOperator(currentUser)) {
            throw new ForbiddenException("Only the conversation owner can send messages");
        }

        Message userMessage = new Message();
        userMessage.setConversationId(conversationId);
        userMessage.setSenderId(currentUser.getUserId());
        userMessage.setRole("user");
        userMessage.setContent(request.getContent().trim());
        messageRepository.save(userMessage);
        conversationRepository.incrementMessageCount(conversationId);
        indexMessageForSearch(conversation, userMessage);

        ChatCompletionContext context = loadChatCompletionContext(conversation);
        AiChatCompletionRequest completionRequest = buildAiChatCompletionRequest(
                conversation,
                userMessage,
                context
        );
        return new ChatCompletionPreparation(toMessageResponse(userMessage), completionRequest);
    }

    private AssistantTurnPersistence saveAssistantMessageAndMetadata(
            UUID conversationId,
            UUID userMessageId,
            String answer,
            JsonNode completion,
            double providerElapsedMs
    ) {
        Message assistantMessage = new Message();
        assistantMessage.setConversationId(conversationId);
        assistantMessage.setRole("assistant");
        assistantMessage.setContent(answer.trim());
        messageRepository.save(assistantMessage);
        conversationRepository.incrementMessageCount(conversationId);
        indexMessageForSearch(conversationId, assistantMessage);

        UUID metadataId = persistRagMetadata(
                conversationId,
                userMessageId,
                assistantMessage.getId(),
                completion,
                providerElapsedMs
        );
        return new AssistantTurnPersistence(toMessageResponse(assistantMessage), metadataId);
    }

    private UUID persistRagMetadata(
            UUID conversationId,
            UUID userMessageId,
            UUID assistantMessageId,
            JsonNode completion,
            double providerElapsedMs
    ) {
        JsonNode rag = completion == null ? null : completion.get("rag");
        if (rag == null || rag.isNull() || !rag.path("enabled").asBoolean(false)) {
            return null;
        }

        RagChatTurnMetadata metadata = RagChatTurnMetadata.builder()
                .conversationId(conversationId)
                .userMessageId(userMessageId)
                .assistantMessageId(assistantMessageId)
                .novelId(uuidOrNull(textOrNull(rag.get("novel_id"))))
                .provider(textOrNull(completion.get("provider")))
                .model(textOrNull(completion.get("model")))
                .mode(textOrNull(rag.get("mode")))
                .groundingStatus(textOrNull(rag.get("grounding_status")))
                .fallbackUsed(rag.path("fallback_used").asBoolean(false))
                .fallbackReason(textOrNull(rag.get("fallback_reason")))
                .rankingPolicy(textOrNull(rag.get("ranking_policy")))
                .querySource(textOrNull(rag.get("query_source")))
                .passageCount(intOrDefault(rag.get("passage_count"), 0))
                .tokenUsage(completion.hasNonNull("token_usage") ? completion.get("token_usage").asInt() : null)
                .providerElapsedMs(providerElapsedMs)
                .totalMs(doubleOrNull(rag.path("timing_ms").get("total_ms")))
                .embeddingMs(doubleOrNull(rag.path("timing_ms").get("embedding_ms")))
                .vectorSearchMs(doubleOrNull(rag.path("timing_ms").get("vector_search_ms")))
                .bm25SearchMs(doubleOrNull(rag.path("timing_ms").get("bm25_search_ms")))
                .fusionMs(doubleOrNull(rag.path("timing_ms").get("fusion_ms")))
                .build();

        JsonNode citations = rag.get("citations");
        if (citations != null && citations.isArray()) {
            for (JsonNode citation : citations) {
                String passageId = textOrNull(citation.get("passage_id"));
                if (passageId == null || passageId.isBlank()) {
                    continue;
                }
                JsonNode citationMetadata = citation.path("metadata");
                metadata.addCitation(RagChatTurnCitation.builder()
                        .passageId(passageId)
                        .finalRank(intOrNull(citation.get("final_rank")))
                        .vectorRank(intOrNull(citation.get("vector_rank")))
                        .bm25Rank(intOrNull(citation.get("bm25_rank")))
                        .manifestId(firstNonBlank(
                                textOrNull(citationMetadata.get("manifest_id")),
                                textOrNull(citationMetadata.get("passage_manifest_id"))
                        ))
                        .chapter(textOrNull(citationMetadata.get("chapter")))
                        .build());
            }
        }
        metadata.setCitationCount(metadata.getCitations().size());
        RagChatTurnMetadata saved = ragChatTurnMetadataRepository.save(metadata);
        return saved.getId();
    }

    private String textOrNull(JsonNode node) {
        if (node == null || node.isNull() || node.isMissingNode()) {
            return null;
        }
        String value = node.asText(null);
        return value == null || value.isBlank() ? null : value.trim();
    }

    private Integer intOrNull(JsonNode node) {
        if (node == null || node.isNull() || node.isMissingNode()) {
            return null;
        }
        return node.canConvertToInt() ? node.asInt() : null;
    }

    private Integer intOrDefault(JsonNode node, int defaultValue) {
        Integer value = intOrNull(node);
        return value == null ? defaultValue : value;
    }

    private Double doubleOrNull(JsonNode node) {
        if (node == null || node.isNull() || node.isMissingNode() || !node.isNumber()) {
            return null;
        }
        return node.asDouble();
    }

    private UUID uuidOrNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return UUID.fromString(value.trim());
        } catch (IllegalArgumentException ignored) {
            return null;
        }
    }

    /**
     * Poll for AI response
     */
    public PollResponse pollResponse(UUID conversationId) {
        // Check Redis for task status
        String statusKey = TASK_PREFIX + conversationId + ":status";
        String contentKey = TASK_PREFIX + conversationId + ":content";
        String errorKey = TASK_PREFIX + conversationId + ":error";
        String turnCountKey = TASK_PREFIX + conversationId + ":turn_count";
        String maxTurnsKey = TASK_PREFIX + conversationId + ":max_turns";

        String status = redisTemplate.opsForValue().get(statusKey);
        
        // 턴 정보 가져오기
        String turnCountStr = redisTemplate.opsForValue().get(turnCountKey);
        String maxTurnsStr = redisTemplate.opsForValue().get(maxTurnsKey);
        Integer turnCount = turnCountStr != null ? Integer.parseInt(turnCountStr) : null;
        Integer maxTurns = maxTurnsStr != null ? Integer.parseInt(maxTurnsStr) : 5;

        if (status == null) {
            // No Redis key - check if AI message already in DB
            List<Message> messages = messageRepository.findByConversationId(conversationId);
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
                    UUID messageId = conversationFacade.saveAIMessage(conversationId, content);

                    // Clear Redis keys (턴 정보 포함)
                    redisTemplate.delete(statusKey);
                    redisTemplate.delete(contentKey);
                    redisTemplate.delete(turnCountKey);
                    redisTemplate.delete(maxTurnsKey);

                    log.info("AI message saved and Redis cleared: conversationId={}, messageId={}, turnCount={}/{}", 
                            conversationId, messageId, turnCount, maxTurns);

                    return PollResponse.builder()
                            .status(STATUS_COMPLETED)
                            .content(content)
                            .messageId(messageId)
                            .turnCount(turnCount)
                            .maxTurns(maxTurns)
                            .build();
                }
                break;

            case STATUS_FAILED:
                String error = redisTemplate.opsForValue().get(errorKey);
                return PollResponse.builder()
                        .status(STATUS_FAILED)
                        .error(error != null ? error : "Unknown error")
                        .turnCount(turnCount)
                        .maxTurns(maxTurns)
                        .build();

            case STATUS_PROCESSING:
                // Long polling: hold for up to 2s if still processing
                return longPollForCompletionWithTurns(conversationId, statusKey, contentKey, turnCount, maxTurns);

            case STATUS_QUEUED:
                return PollResponse.builder()
                        .status(STATUS_QUEUED)
                        .turnCount(turnCount)
                        .maxTurns(maxTurns)
                        .build();
                        
            default:
                return PollResponse.builder()
                        .status(status)
                        .turnCount(turnCount)
                        .maxTurns(maxTurns)
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
                    UUID messageId = conversationFacade.saveAIMessage(conversationId, content);

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
     * Long polling with turn info: wait for completion or timeout
     */
    private PollResponse longPollForCompletionWithTurns(UUID conversationId, String statusKey, String contentKey, 
                                                         Integer turnCount, Integer maxTurns) {
        long startTime = System.currentTimeMillis();
        long timeout = startTime + LONG_POLL_TIMEOUT_MS;
        
        String errorKey = TASK_PREFIX + conversationId + ":error";
        String turnCountKey = TASK_PREFIX + conversationId + ":turn_count";
        String maxTurnsKey = TASK_PREFIX + conversationId + ":max_turns";

        while (System.currentTimeMillis() < timeout) {
            String currentStatus = redisTemplate.opsForValue().get(statusKey);

            if (STATUS_COMPLETED.equals(currentStatus)) {
                String content = redisTemplate.opsForValue().get(contentKey);
                if (content != null) {
                    UUID messageId = conversationFacade.saveAIMessage(conversationId, content);

                    // Clear Redis keys (턴 정보 포함)
                    redisTemplate.delete(statusKey);
                    redisTemplate.delete(contentKey);
                    redisTemplate.delete(turnCountKey);
                    redisTemplate.delete(maxTurnsKey);

                    return PollResponse.builder()
                            .status(STATUS_COMPLETED)
                            .content(content)
                            .messageId(messageId)
                            .turnCount(turnCount)
                            .maxTurns(maxTurns)
                            .build();
                }
            } else if (STATUS_FAILED.equals(currentStatus)) {
                String error = redisTemplate.opsForValue().get(errorKey);
                return PollResponse.builder()
                        .status(STATUS_FAILED)
                        .error(error)
                        .turnCount(turnCount)
                        .maxTurns(maxTurns)
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
                .turnCount(turnCount)
                .maxTurns(maxTurns)
                .build();
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

    private ChatCompletionContext loadChatCompletionContext(Conversation conversation) {
        ScenarioResponse scenario = null;
        NovelCharacterResponse character = null;
        NovelResponse novel = null;

        try {
            scenario = scenarioFacade.getScenario(conversation.getScenarioId());
            if (conversation.getCharacterVectordbId() != null) {
                character = contentReadFacade.getCharacterByVectordbId(conversation.getCharacterVectordbId());
            }
            if (scenario != null && scenario.getNovelId() != null) {
                novel = contentReadFacade.getNovel(scenario.getNovelId());
            }
        } catch (Exception e) {
            log.warn("Failed to load RAG chat context metadata: conversationId={}, error={}",
                    conversation.getId(), e.getMessage());
        }

        return new ChatCompletionContext(scenario, character, novel);
    }

    private AiChatCompletionRequest buildAiChatCompletionRequest(
            Conversation conversation,
            Message userMessage,
            ChatCompletionContext context
    ) {
        String userContent = userMessage.getContent();
        String prompt = buildGenerationPrompt(conversation, userMessage, context);
        String retrievalQuery = truncateRetrievalQuery(userContent);
        String novelId = resolveRagNovelId(conversation, context);

        AiChatCompletionRequest.RagOptions ragOptions = novelId == null
                ? null
                : new AiChatCompletionRequest.RagOptions(
                        true,
                        novelId,
                        retrievalQuery,
                        "hybrid",
                        6,
                        4,
                        null,
                        null,
                        null,
                        true
                );

        return new AiChatCompletionRequest(
                prompt,
                "gemini-2.5-flash",
                0.7,
                boundedChatMaxOutputTokens(),
                0,
                ragOptions
        );
    }

    private String buildGenerationPrompt(
            Conversation conversation,
            Message userMessage,
            ChatCompletionContext context
    ) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("Conversation context\n");
        prompt.append("- Conversation ID: ").append(conversation.getId()).append('\n');

        if (context.novel() != null) {
            prompt.append("- Novel: ")
                    .append(nullToEmpty(context.novel().getTitle()))
                    .append(" by ")
                    .append(nullToEmpty(context.novel().getAuthor()))
                    .append('\n');
        }
        if (context.scenario() != null) {
            appendIfPresent(prompt, "- Scenario: ", context.scenario().getTitle());
            appendIfPresent(prompt, "- What-if: ", context.scenario().getWhatIfQuestion());
            appendIfPresent(prompt, "- Character changes: ", context.scenario().getCharacterChanges());
            appendIfPresent(prompt, "- Event alterations: ", context.scenario().getEventAlterations());
            appendIfPresent(prompt, "- Setting modifications: ", context.scenario().getSettingModifications());
        }
        if (context.character() != null) {
            appendIfPresent(prompt, "- Character: ", context.character().getCommonName());
            appendIfPresent(prompt, "- Persona: ", firstNonBlank(
                    context.character().getPersonaKo(),
                    context.character().getPersona(),
                    context.character().getPersonaEn()
            ));
            appendIfPresent(prompt, "- Speaking style: ", firstNonBlank(
                    context.character().getSpeakingStyleKo(),
                    context.character().getSpeakingStyle(),
                    context.character().getSpeakingStyleEn()
            ));
        }

        List<Message> recentMessagesDescending = messageRepository.findRecentByConversationId(
                conversation.getId(),
                PageRequest.of(
                        0,
                        Math.max(1, boundedRecentHistoryMessageLimit() + 1),
                        Sort.by(Sort.Direction.DESC, "createdAt")
                )
        );
        List<Message> recentMessages = new ArrayList<>(recentMessagesDescending);
        java.util.Collections.reverse(recentMessages);
        recentMessages = recentMessages.stream()
                .filter(message -> !"system".equals(message.getRole()))
                .filter(message -> !java.util.Objects.equals(message.getId(), userMessage.getId()))
                .toList();
        if (recentMessages.size() > boundedRecentHistoryMessageLimit()) {
            recentMessages = recentMessages.subList(
                    recentMessages.size() - boundedRecentHistoryMessageLimit(),
                    recentMessages.size()
            );
        }
        if (!recentMessages.isEmpty()) {
            prompt.append("\nRecent conversation\n");
            for (Message message : recentMessages) {
                prompt.append(message.getRole())
                        .append(": ")
                        .append(truncateInline(message.getContent(), 500))
                        .append('\n');
            }
        }

        prompt.append("\nUser message\n").append(userMessage.getContent().trim());
        return truncateForChatRequest(prompt.toString(), userMessage.getContent());
    }

    private int boundedRecentHistoryMessageLimit() {
        return Math.max(1, Math.min(recentHistoryMessageLimit, 20));
    }

    private int boundedChatMaxOutputTokens() {
        return Math.max(256, Math.min(chatMaxOutputTokens, 2048));
    }

    private String resolveRagNovelId(Conversation conversation, ChatCompletionContext context) {
        String characterVectordbId = conversation.getCharacterVectordbId();
        if (characterVectordbId != null && characterVectordbId.endsWith("_1342")) {
            return PRIDE_AND_PREJUDICE_CANONICAL_NOVEL_ID;
        }
        if (context.novel() != null && Integer.valueOf(1342).equals(context.novel().getGutenbergId())) {
            return context.novel().getId().toString();
        }
        if (context.scenario() != null && context.scenario().getNovelId() != null) {
            return context.scenario().getNovelId().toString();
        }
        return null;
    }

    private void appendIfPresent(StringBuilder prompt, String label, String value) {
        if (value != null && !value.isBlank()) {
            prompt.append(label).append(value.trim()).append('\n');
        }
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value.trim();
            }
        }
        return null;
    }

    private String truncateRetrievalQuery(String value) {
        String trimmed = value == null ? "" : value.trim();
        int maxLength = 1000;
        if (trimmed.length() <= maxLength) {
            return trimmed;
        }
        return trimmed.substring(0, maxLength);
    }

    private String truncateInline(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        String normalized = value.replaceAll("\\s+", " ").trim();
        if (normalized.length() <= maxLength) {
            return normalized;
        }
        return normalized.substring(0, maxLength) + "...";
    }

    private String truncateForChatRequest(String prompt, String userContent) {
        int maxLength = 3900;
        if (prompt.length() <= maxLength) {
            return prompt;
        }
        String suffix = "\nUser message\n" + (userContent == null ? "" : userContent.trim());
        if (suffix.length() >= maxLength) {
            return suffix.substring(suffix.length() - maxLength);
        }
        int prefixLength = Math.max(0, maxLength - suffix.length() - 16);
        return prompt.substring(0, Math.min(prefixLength, prompt.length())) + "\n...\n" + suffix;
    }

    private String nullToEmpty(String value) {
        return value == null ? "" : value;
    }

    private void requireAuthenticated(UserPrincipal currentUser) {
        if (currentUser == null || currentUser.getUserId() == null) {
            throw new com.gaji.common.exception.UnauthorizedException("Authentication required");
        }
    }

    private String normalizeMessageSearchQuery(String query) {
        if (query == null || query.isBlank()) {
            throw new BadRequestException("Search query is required");
        }
        String normalized = query.trim().replaceAll("\\s+", " ");
        normalized = normalized.replace("%", "").replace("_", "");
        if (normalized.length() < 2) {
            throw new BadRequestException("Search query must be at least 2 characters");
        }
        if (normalized.length() > 100) {
            return normalized.substring(0, 100);
        }
        return normalized;
    }

    private void indexMessageForSearch(Conversation conversation, Message message) {
        try {
            conversationMessageSearchIndex.indexMessage(conversation, message);
        } catch (Exception exc) {
            log.warn("conversation_message_search_index_enqueue_failed", exc);
        }
    }

    private void indexMessageForSearch(UUID conversationId, Message message) {
        conversationRepository.findById(conversationId)
                .ifPresent(conversation -> indexMessageForSearch(conversation, message));
    }

    private PageRequest messageSearchPageRequest(int page, int size) {
        return PageRequest.of(Math.max(0, page), Math.max(1, Math.min(size, 50)));
    }

    private List<MessageSearchResponse> toMessageSearchResponses(
            List<MessageSearchResult> results,
            String query
    ) {
        return results.stream()
                .map(result -> MessageSearchResponse.builder()
                        .messageId(result.messageId())
                        .conversationId(result.conversationId())
                        .conversationTitle(result.conversationTitle())
                        .role(result.role())
                        .snippet(buildMessageSearchSnippet(result.content(), query, 180))
                        .createdAt(result.createdAt())
                        .build())
                .toList();
    }

    private List<ConversationMessageSearchResult> toConversationMessageSearchResults(
            List<ConversationMessageSearchIndexHit> hits
    ) {
        return hits.stream()
                .map(hit -> new ConversationMessageSearchResult(
                        hit.conversationId(),
                        hit.conversationTitle(),
                        hit.messageHitCount(),
                        hit.lastHitAt(),
                        hit.matchedContent(),
                        loadRecentMessagesForSearchCard(hit.conversationId())
                ))
                .toList();
    }

    private List<ConversationMessageSearchResult.RecentMessage> loadRecentMessagesForSearchCard(UUID conversationId) {
        return messageRepository.findRecentByConversationId(
                        conversationId,
                        PageRequest.of(0, 3, Sort.by(Sort.Direction.DESC, "createdAt"))
                )
                .stream()
                .map(message -> new ConversationMessageSearchResult.RecentMessage(
                        message.getId(),
                        message.getRole(),
                        message.getContent(),
                        message.getCreatedAt()
                ))
                .toList();
    }

    private List<ConversationMessageSearchResponse> toConversationMessageSearchResponses(
            List<ConversationMessageSearchResult> results,
            String query
    ) {
        return results.stream()
                .map(result -> {
                    List<ConversationMessageSearchResponse.RecentMessagePreview> recentMessages =
                            result.recentMessages().stream()
                                    .map(recentMessage -> ConversationMessageSearchResponse.RecentMessagePreview.builder()
                                            .messageId(recentMessage.messageId())
                                            .role(recentMessage.role())
                                            .snippet(truncateInline(recentMessage.snippet(), 80))
                                            .createdAt(recentMessage.createdAt())
                                            .build())
                                    .toList();
                    String snippet = result.matchedContent() == null
                            ? recentMessages.stream()
                                    .findFirst()
                                    .map(ConversationMessageSearchResponse.RecentMessagePreview::getSnippet)
                                    .orElse("")
                            : buildMessageSearchSnippet(result.matchedContent(), query, 180);

                    return ConversationMessageSearchResponse.builder()
                            .conversationId(result.conversationId())
                            .conversationTitle(result.conversationTitle())
                            .messageHitCount(result.messageHitCount())
                            .lastHitAt(result.lastHitAt())
                            .snippet(snippet)
                            .recentMessages(recentMessages)
                            .build();
                })
                .toList();
    }

    private String buildMessageSearchSnippet(String content, String query, int maxLength) {
        if (content == null || content.isBlank()) {
            return "";
        }
        String normalizedContent = content.replaceAll("\\s+", " ").trim();
        if (normalizedContent.length() <= maxLength) {
            return normalizedContent;
        }

        String lowerContent = normalizedContent.toLowerCase(Locale.ROOT);
        String lowerQuery = query.toLowerCase(Locale.ROOT);
        int matchIndex = lowerContent.indexOf(lowerQuery);
        if (matchIndex < 0) {
            return truncateInline(normalizedContent, maxLength);
        }

        int halfWindow = maxLength / 2;
        int start = Math.max(0, matchIndex - halfWindow);
        int end = Math.min(normalizedContent.length(), start + maxLength);
        start = Math.max(0, end - maxLength);

        String prefix = start > 0 ? "..." : "";
        String suffix = end < normalizedContent.length() ? "..." : "";
        return prefix + normalizedContent.substring(start, end) + suffix;
    }

    private MessageResponse toMessageResponse(Message message) {
        return MessageResponse.builder()
                .id(message.getId())
                .conversationId(message.getConversationId())
                .senderId(message.getSenderId())
                .role(message.getRole())
                .content(message.getContent())
                .createdAt(message.getCreatedAt())
                .build();
    }

    private boolean isOperator(UserPrincipal user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        String role = user.getRole().trim().toUpperCase();
        return "ADMIN".equals(role) || "DEVELOPER".equals(role);
    }

    private record ChatCompletionContext(
            ScenarioResponse scenario,
            NovelCharacterResponse character,
            NovelResponse novel
    ) {
    }

    private record ChatCompletionPreparation(
            MessageResponse userMessage,
            AiChatCompletionRequest request
    ) {
    }

    private record AssistantTurnPersistence(
            MessageResponse assistantMessage,
            UUID ragMetadataId
    ) {
    }

    public record ChatCompletionStreamEvent(
            String eventName,
            Object data
    ) {
    }
}
