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
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.chat.domain.repository.RagChatTurnMetadataRepository;
import com.gaji.content.application.ContentReadFacade;
import com.gaji.scenario.application.ScenarioFacade;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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
    private final WebClient.Builder webClientBuilder;
    private final RedisTemplate<String, String> redisTemplate;
    private final ScenarioFacade scenarioFacade;
    private final ContentReadFacade contentReadFacade;
    private final AiChatProxyService aiChatProxyService;
    private final TransactionTemplate transactionTemplate;
    private final RagChatTurnMetadataRepository ragChatTurnMetadataRepository;

    @Value("${fastapi.base-url:http://localhost:8000}")
    private String fastApiUrl;

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

        log.info("User message saved: conversationId={}, messageId={}", conversationId, userMessage.getId());

        // Get conversation history for AI context
        List<Message> messages = messageRepository.findByConversationId(conversationId);
        List<FastAPIGenerationRequest.MessageHistory> history = messages.stream()
                .filter(msg -> !msg.getId().equals(userMessage.getId())) // Exclude the just-saved message
                .map(msg -> FastAPIGenerationRequest.MessageHistory.builder()
                        .role(msg.getRole())
                        .content(msg.getContent())
                        .build())
                .collect(Collectors.toList());

        // Build scenario context (system prompt)
        String scenarioContext = buildScenarioContext(conversation);

        // Fetch scenario, character, and book data to send to FastAPI
        UUID scenarioId = conversation.getScenarioId();
        String characterVectordbId = conversation.getCharacterVectordbId();
        
        ScenarioResponse scenario = null;
        NovelCharacterResponse character = null;
        NovelResponse novel = null;
        
        try {
            // Get scenario data
            scenario = scenarioFacade.getScenario(scenarioId);
            
            // Get character data from vectordbId (직접 DB 조회)
            if (characterVectordbId != null) {
                character = contentReadFacade.getCharacterByVectordbId(characterVectordbId);
                
                if (character == null) {
                    log.warn("Character not found for vectordbId: {}", characterVectordbId);
                }
            }
            
            // Get book data if available
            if (scenario.getNovelId() != null) {
                novel = contentReadFacade.getNovel(scenario.getNovelId());
            }
        } catch (Exception e) {
            log.warn("Failed to fetch scenario/character/novel data: {}", e.getMessage());
            // Continue with null values - FastAPI will use fallback
        }

        // Call FastAPI to trigger AI generation
        FastAPIGenerationRequest.FastAPIGenerationRequestBuilder requestBuilder = FastAPIGenerationRequest.builder()
                .conversationId(conversationId.toString())
                .scenarioId(scenarioId.toString())
                .scenarioContext(scenarioContext)
                .userMessage(request.getContent())
                .history(history);
        
        // Add scenario details if available
        if (scenario != null) {
            requestBuilder
                    .whatIfQuestion(scenario.getWhatIfQuestion())
                    .characterChanges(scenario.getCharacterChanges())
                    .eventAlterations(scenario.getEventAlterations())
                    .settingModifications(scenario.getSettingModifications());
        }
        
        // Add character details if available
        if (character != null) {
            requestBuilder
                    .characterName(character.getCommonName())
                    .characterPersona(character.getPersona())
                    .characterSpeakingStyle(character.getSpeakingStyle());
        }
        
        // Add book details if available
        if (novel != null) {
            requestBuilder
                    .bookTitle(novel.getTitle())
                    .bookAuthor(novel.getAuthor());
        }
        
        FastAPIGenerationRequest fastApiRequest = requestBuilder.build();

        log.info("Triggering AI generation: conversationId={}, scenarioId={}", conversationId, scenarioId);

        try {
            webClientBuilder.build()
                    .post()
                    .uri(fastApiUrl + "/api/ai/generate")
                    .bodyValue(fastApiRequest)
                    .retrieve()
                    .toBodilessEntity()
                    .block();
            
            log.info("AI generation triggered successfully: conversationId={}", conversationId);

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
                1024,
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

        List<Message> messages = messageRepository.findByConversationId(conversation.getId());
        int fromIndex = Math.max(0, messages.size() - 7);
        List<Message> recentMessages = messages.subList(fromIndex, messages.size()).stream()
                .filter(message -> !"system".equals(message.getRole()))
                .filter(message -> !java.util.Objects.equals(message.getId(), userMessage.getId()))
                .toList();
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
