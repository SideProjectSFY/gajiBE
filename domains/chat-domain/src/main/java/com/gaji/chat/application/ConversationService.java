package com.gaji.chat.application;

import com.gaji.shared.contract.dto.*;
import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ResourceNotFoundException;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.scenario.application.ScenarioFacade;
import com.gaji.content.application.ContentFacade;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for conversation business logic
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ConversationService {

    private final ConversationRepository conversationRepository;
    private final MessageRepository messageRepository;
    private final ScenarioFacade scenarioFacade;
    private final ContentFacade contentFacade;
    
    private static final String CONVERSATION_NOT_FOUND = "Conversation not found: ";

    /**
     * Create a new conversation
     * Leaf 시나리오의 경우 기준 대화(reference conversation)가 있으면 메시지를 복사
     */
    @Transactional
    public ConversationResponse createConversation(UUID userId, CreateConversationRequest request) {
        log.info("Creating conversation for user: {}, scenario: {}", userId, request.getScenarioId());

        // Get scenario to create system message with whatIfQuestion
        ScenarioResponse scenario = scenarioFacade.getScenario(request.getScenarioId());

        // Set default values if not provided
        String scenarioType = request.getScenarioType();
        if (scenarioType == null || scenarioType.isEmpty()) {
            scenarioType = "root_user"; // Default to root_user
        }

        String characterVectordbId = request.getCharacterVectordbId();
        if (characterVectordbId == null || characterVectordbId.isEmpty()) {
            // 시나리오에서 캐릭터 정보가 제공되면 사용
            if (scenario.getCharacterVectordbId() != null) {
                characterVectordbId = scenario.getCharacterVectordbId();
            } else {
                characterVectordbId = "default-character"; // Default character
            }
        }

        // 기준 대화가 있는지 확인 (Leaf 시나리오의 경우)
        // [Policy] Copy max 20 messages (or min(total, 20)) for context continuity & performance
        UUID referenceConversationId = scenario.getReferenceConversationId();
        List<Message> referenceMessages = null;
        if (referenceConversationId != null) {
            // Fetch recent 20 messages (descending order) to get the latest context
            referenceMessages = messageRepository.findRecentByConversationId(
                    referenceConversationId, 
                    PageRequest.of(0, 20, Sort.by("createdAt").descending()));
            
            // Re-sort to chronological order for processing
            referenceMessages.sort((m1, m2) -> m1.getCreatedAt().compareTo(m2.getCreatedAt()));
            
            log.info("Found reference conversation with {} recent messages (max 20)", referenceMessages.size());
        }

        int initialMessageCount = (referenceMessages != null && !referenceMessages.isEmpty()) 
                ? referenceMessages.size() 
                : 1;
        
        Conversation conversation = Conversation.builder()
                .userId(userId)
                .scenarioId(request.getScenarioId())
                .scenarioType(scenarioType)
                .characterVectordbId(characterVectordbId)
                .title(request.getTitle())
                .isRoot(true)
                .messageCount(initialMessageCount)
                .likeCount(0)
                .isPrivate(Boolean.TRUE.equals(request.getIsPrivate()))
                .build();

        conversationRepository.save(conversation);
        UUID conversationId = conversation.getId();

        // 기준 대화가 있으면 메시지 복사, 없으면 기본 시스템 메시지 생성
        if (referenceMessages != null && !referenceMessages.isEmpty()) {
            // 기준 대화의 메시지 복사 (순서 유지를 위해 원본 createdAt 사용)
            // Use stream to transform and collect, avoiding 'new ArrayList' explicit instantiation if possible, 
            // though list collection still uses new internally. Main point is using Builder for entities.
            List<Message> messagesToSave = referenceMessages.stream()
                .map(msg -> Message.builder()
                        .conversationId(conversationId)
                        .senderId(msg.getSenderId())
                        .role(msg.getRole())
                        .content(msg.getContent())
                        .createdAt(msg.getCreatedAt()) // 원본 시간 유지
                        .build())
                .collect(Collectors.toList());

            // [Performance Fix] Bulk insert
            messageRepository.saveAll(messagesToSave);
            log.info("Copied {} messages from reference conversation to new conversation", 
                    messagesToSave.size());
        } else {
            // Create initial system message with scenario's whatIfQuestion
            Message systemMessage = Message.builder()
                    .conversationId(conversationId)
                    .role("system")
                    .content(scenario.getWhatIfQuestion())
                    .build();
            
            messageRepository.save(systemMessage);
        }

        return ConversationResponse.from(conversation);
    }

    /**
     * Get conversation by ID with messages
     */
    @Transactional(readOnly = true)
    public ConversationResponse getConversationWithMessages(UUID conversationId) {
        log.debug("Getting conversation with messages: {}", conversationId);

        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        // Get messages
        List<Message> messages = messageRepository.findByConversationId(conversationId);
        List<MessageResponse> messageResponses = messages.stream()
                .map(MessageResponse::from)
                .collect(Collectors.toList());

        ConversationResponse response = ConversationResponse.from(conversation);
        response.setMessages(messageResponses);

        return response;
    }

    /**
     * Get conversation by ID without messages
     */
    @Transactional(readOnly = true)
    public ConversationResponse getConversation(UUID conversationId) {
        log.debug("Getting conversation: {}", conversationId);

        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        return ConversationResponse.from(conversation);
    }

    /**
     * List conversations for a user
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listUserConversations(UUID userId, int page, int size) {
        log.debug("Listing conversations for user: {}, page: {}, size: {}", userId, page, size);

        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        List<ConversationResponse> responses = conversationRepository.findByUserId(userId, pageable)
                .map(ConversationResponse::from)
                .getContent();
        return populateExtendedInfo(responses);
    }

    /**
     * List user's public conversations
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listUserPublicConversations(UUID userId, int page, int size) {
        log.debug("Listing public conversations for user: {}, page: {}, size: {}", userId, page, size);

        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        List<ConversationResponse> responses = conversationRepository.findPublicByUserId(userId, pageable)
                .map(ConversationResponse::from)
                .getContent();
        return populateExtendedInfo(responses);
    }

    /**
     * List conversations liked by user
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listLikedConversations(UUID userId, boolean includePrivate, int page, int size) {
        log.debug("Listing liked conversations for user: {}, includePrivate: {}, page: {}, size: {}", userId, includePrivate, page, size);
        
        Pageable pageable = PageRequest.of(page, size); 
        List<ConversationResponse> responses = conversationRepository.findLikedByUserId(userId, includePrivate, pageable)
                .map(ConversationResponse::from)
                .getContent();
        return populateExtendedInfo(responses);
    }

    /**
     * List all public conversations with filters
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listPublicConversations(String search, String genre, String sort, int page, int size) {
        log.debug("Listing all public conversations, search: {}, genre: {}, sort: {}, page: {}, size: {}", search, genre, sort, page, size);

        Sort sortBy = Sort.by("createdAt").descending();
        if (sort != null && !sort.isEmpty()) {
            if ("likes".equalsIgnoreCase(sort)) {
                sortBy = Sort.by("likeCount").descending();
            } else if ("updated".equalsIgnoreCase(sort)) {
                sortBy = Sort.by("updatedAt").descending();
            }
        }
        Pageable pageable = PageRequest.of(page, size, sortBy);

        List<ConversationResponse> responses = conversationRepository.findPublicAllWithFilters(search, genre, pageable)
                .map(ConversationResponse::from)
                .getContent();
        return populateExtendedInfo(responses);
    }

    /**
     * List all public conversations (legacy)
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listPublicConversations(int page, int size) {
        return listPublicConversations(null, null, null, page, size);
    }

    /**
     * List all conversations (public/admin view)
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listAllConversations(int page, int size) {
        log.debug("Listing all conversations, page: {}, size: {}", page, size);

        Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        return conversationRepository.findAll(pageable)
                .map(ConversationResponse::from)
                .getContent();
    }

    /**
     * Update conversation metadata
     */
    @Transactional
    public ConversationResponse updateConversation(UUID conversationId, UpdateConversationRequest request) {
        log.info("Updating conversation: {}", conversationId);

        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        if (request.getTitle() != null) {
            conversation.setTitle(request.getTitle());
        }
        if (request.getIsPrivate() != null) {
            conversation.setIsPrivate(request.getIsPrivate());
        }

        conversationRepository.save(conversation);

        return ConversationResponse.from(conversation);
    }

    /**
     * Delete conversation
     */
    @Transactional
    public void deleteConversation(UUID conversationId) {
        log.info("Deleting conversation: {}", conversationId);

        conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        conversationRepository.deleteById(conversationId);
    }

    /**
     * Fork a ROOT conversation (copy min(6, total) messages)
     * Story 4.4 Requirements:
     * - Only ROOT conversations (is_root=TRUE, parent_conversation_id IS NULL) can be forked
     * - Conversation must NOT have been forked already (has_been_forked=FALSE)
     * - Copy min(6, total_message_count) most recent messages
     * - Update parent's has_been_forked flag to TRUE
     * - All operations in single transaction
     */
    @Transactional
    public ForkConversationResponse forkConversation(UUID conversationId, UUID userId) {
        log.info("Forking conversation: {} by user: {}", conversationId, userId);

        // Get original conversation
        Conversation original = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        // Validate: User must own the conversation
        if (original.getUserId().equals(userId)) {
            throw new BadRequestException("You cannot fork your own conversation.");
        }

        // Validate: Only ROOT conversations can be forked (is_root=TRUE, parent_conversation_id IS NULL)
        if (original.getParentConversationId() != null || !Boolean.TRUE.equals(original.getIsRoot())) {
            throw new BadRequestException("Cannot fork a forked conversation. Only root conversations can be forked.");
        }

        // Validate: Conversation must NOT have been forked already
        if (Boolean.TRUE.equals(original.getHasBeenForked())) {
            throw new BadRequestException("This conversation has already been forked. Each root conversation can only be forked once.");
        }

        // Get all messages and calculate copy count: min(6, total)
        List<Message> allMessages = messageRepository.findByConversationId(conversationId);
        int totalCount = allMessages.size();
        int copyCount = Math.min(6, totalCount);

        // Get messages to copy (most recent copyCount messages)
        List<Message> messagesToCopy = allMessages.subList(
                Math.max(0, totalCount - copyCount),
                totalCount
        );

        Conversation forked = Conversation.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .scenarioId(original.getScenarioId())
                .scenarioType(original.getScenarioType())
                .characterVectordbId(original.getCharacterVectordbId())
                .parentConversationId(original.getId())
                .title(original.getTitle() != null ? original.getTitle() + " (Fork)" : "Forked Conversation")
                .isRoot(false)
                .hasBeenForked(false)
                .messageCount(copyCount)
                .likeCount(0)
                .isPrivate(original.getIsPrivate())
                .build();

        conversationRepository.save(forked);

        // Copy messages with new IDs and timestamps
        for (Message msg : messagesToCopy) {
            Message copied = Message.builder()
                    .id(UUID.randomUUID())
                    .conversationId(forked.getId())
                    .senderId(msg.getSenderId())
                    .role(msg.getRole())
                    .content(msg.getContent())
                    .build();

            messageRepository.save(copied);
        }

        // Update forked conversation's message count - Entity already has count, but let's persist if needed explicitly via update query
        // Actually save() handles it. But maybe original code wanted explicit separate update?
        // Let's use save() since we built the object. 
        // conversationRepository.save(forked); // Already called above.
        // If we want to ensure DB persistence of count:
        // conversationRepository.updateMessageCount(forked.getId(), copyCount); // My new repo method takes count.
        
        // Update parent's has_been_forked flag (CRITICAL: atomic transaction)
        conversationRepository.updateHasBeenForked(conversationId, true);

        log.info("Forked conversation {} -> {} with {} messages", conversationId, forked.getId(), copyCount);

        return ForkConversationResponse.builder()
                .id(forked.getId())
                .parentConversationId(conversationId)
                .copiedMessageCount(copyCount)
                .messageCount(copyCount)
                .isRoot(false)
                .depth(1)
                .build();
    }

    /**
     * Get fork relationship for a conversation
     */
    public ForkRelationshipResponse getForkRelationship(UUID conversationId) {
        log.debug("Getting fork relationship: conversationId={}", conversationId);

        Conversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        ForkRelationshipResponse.ForkRelationshipResponseBuilder builder = ForkRelationshipResponse.builder()
                .conversationId(conversationId)
                .isRoot(conversation.getIsRoot())
                .depth(Boolean.TRUE.equals(conversation.getIsRoot()) ? 0 : 1);

        // If this is a forked conversation, get parent info
        if (conversation.getParentConversationId() != null) {
            Conversation parent = conversationRepository.findById(conversation.getParentConversationId())
                    .orElse(null);
            if (parent != null) {
                builder.parentConversationId(parent.getId())
                        .parentTitle(parent.getTitle());
            }
        }

        return builder.build();
    }

    @Transactional(readOnly = true)
    public List<Conversation> findAllById(List<UUID> ids) {
        return conversationRepository.findAllById(ids);
    }

    /**
     * Helper to populate extended info (book title, correct scenario desc, etc.)
     * efficiently using bulk fetching to avoid N+1 queries.
     */
    private List<ConversationResponse> populateExtendedInfo(List<ConversationResponse> responses) {
        if (responses == null || responses.isEmpty()) {
            return responses;
        }

        // 1. Bulk fetch scenarios to get Novel IDs
        // Extract all unique scenario IDs
        List<UUID> scenarioIds = responses.stream()
                .map(ConversationResponse::getScenarioId)
                .filter(java.util.Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        
        if (scenarioIds.isEmpty()) {
            return responses;
        }

        // Fetch scenarios
        // Use a map for O(1) lookup
        java.util.Map<UUID, ScenarioResponse> scenarioMap = scenarioFacade.findAllScenariosByIds(scenarioIds).stream()
                .collect(Collectors.toMap(ScenarioResponse::getId, s -> s));

        // 2. Bulk fetch novels using Novel IDs from scenarios
        // Extract all unique novel IDs
        List<UUID> novelIds = scenarioMap.values().stream()
                .map(ScenarioResponse::getNovelId)
                .filter(java.util.Objects::nonNull)
                .distinct()
                .collect(Collectors.toList());
        
        java.util.Map<UUID, com.gaji.shared.contract.dto.NovelResponse> novelMap = new java.util.HashMap<>();
        if (!novelIds.isEmpty()) {
            novelMap = contentFacade.findAllNovelResponsesByIds(novelIds).stream()
                    .collect(Collectors.toMap(com.gaji.shared.contract.dto.NovelResponse::getId, n -> n));
        }

        // 3. Populate fields in responses
        for (ConversationResponse response : responses) {
            UUID scenarioId = response.getScenarioId();
            if (scenarioId != null) {
                ScenarioResponse scenario = scenarioMap.get(scenarioId);
                if (scenario != null) {
                    // Set scenario description if available and not already set
                    if (response.getScenarioDescription() == null) {
                        response.setScenarioDescription(scenario.getDescription());
                    }
                    
                    // Finds Novel info
                    UUID novelId = scenario.getNovelId();
                    if (novelId != null) {
                        response.setBookId(novelId);
                        com.gaji.shared.contract.dto.NovelResponse novel = novelMap.get(novelId);
                        if (novel != null) {
                            response.setBookTitle(novel.getTitle());
                            response.setBookAuthor(novel.getAuthor());
                            response.setBookCoverUrl(novel.getCoverImageUrl());
                        }
                    }
                }
            }
        }

        return responses;
    }
}
