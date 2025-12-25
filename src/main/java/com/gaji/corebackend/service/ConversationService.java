package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.Message;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.mapper.ConversationMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

    private final ConversationMapper conversationMapper;
    private final ScenarioService scenarioService;
    
    private static final String CONVERSATION_NOT_FOUND = "Conversation not found: ";

    /**
     * Create a new conversation
     * Leaf 시나리오의 경우 기준 대화(reference conversation)가 있으면 메시지를 복사
     */
    @Transactional
    public ConversationResponse createConversation(UUID userId, CreateConversationRequest request) {
        log.info("Creating conversation for user: {}, scenario: {}", userId, request.getScenarioId());

        // Get scenario to create system message with whatIfQuestion
        ScenarioResponse scenario = scenarioService.getScenario(request.getScenarioId());

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
        UUID referenceConversationId = scenario.getReferenceConversationId();
        List<Message> referenceMessages = null;
        if (referenceConversationId != null) {
            referenceMessages = conversationMapper.findMessagesByConversationId(referenceConversationId);
            log.info("Found reference conversation with {} messages", referenceMessages.size());
        }

        // Create conversation entity
        UUID conversationId = UUID.randomUUID();
        int initialMessageCount = (referenceMessages != null && !referenceMessages.isEmpty()) 
                ? referenceMessages.size() 
                : 1;
        
        Conversation conversation = Conversation.builder()
                .id(conversationId)
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

        conversationMapper.insert(conversation);

        // 기준 대화가 있으면 메시지 복사, 없으면 기본 시스템 메시지 생성
        if (referenceMessages != null && !referenceMessages.isEmpty()) {
            // 기준 대화의 모든 메시지 복사 (순서 유지를 위해 원본 createdAt 사용)
            for (Message msg : referenceMessages) {
                Message copied = Message.builder()
                        .id(UUID.randomUUID())
                        .conversationId(conversationId)
                        .senderId(msg.getSenderId())
                        .role(msg.getRole())
                        .content(msg.getContent())
                        .createdAt(msg.getCreatedAt()) // 원본 시간 유지하여 순서 보장
                        .build();
                conversationMapper.insertMessage(copied);
            }
            log.info("Copied {} messages from reference conversation to new conversation", 
                    referenceMessages.size());
        } else {
            // Create initial system message with scenario's whatIfQuestion
            Message systemMessage = Message.builder()
                    .id(UUID.randomUUID())
                    .conversationId(conversationId)
                    .role("system")
                    .content(scenario.getWhatIfQuestion())
                    .build();
            
            conversationMapper.insertMessage(systemMessage);
        }

        return ConversationResponse.from(conversation);
    }

    /**
     * Get conversation by ID with messages
     */
    @Transactional(readOnly = true)
    public ConversationResponse getConversationWithMessages(UUID conversationId) {
        log.debug("Getting conversation with messages: {}", conversationId);

        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        // Get messages
        List<Message> messages = conversationMapper.findMessagesByConversationId(conversationId);
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

        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        return ConversationResponse.from(conversation);
    }

    /**
     * List conversations for a user
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listUserConversations(UUID userId, int page, int size) {
        log.debug("Listing conversations for user: {}, page: {}, size: {}", userId, page, size);

        int offset = page * size;
        List<Conversation> conversations = conversationMapper.findByUserId(userId, size, offset);

        return conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * List user's public conversations
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listUserPublicConversations(UUID userId, int page, int size) {
        log.debug("Listing public conversations for user: {}, page: {}, size: {}", userId, page, size);

        int offset = page * size;
        List<Conversation> conversations = conversationMapper.findPublicByUserId(userId, size, offset);

        return conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * List conversations liked by user
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listLikedConversations(UUID userId, boolean includePrivate, int page, int size) {
        log.debug("Listing liked conversations for user: {}, includePrivate: {}, page: {}, size: {}", userId, includePrivate, page, size);

        int offset = page * size;
        List<Conversation> conversations = conversationMapper.findLikedByUserId(userId, includePrivate, size, offset);

        return conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * List all public conversations with filters
     */
    @Transactional(readOnly = true)
    public List<ConversationResponse> listPublicConversations(String search, String genre, String sort, int page, int size) {
        log.debug("Listing all public conversations, search: {}, genre: {}, sort: {}, page: {}, size: {}", search, genre, sort, page, size);

        int offset = page * size;
        List<Conversation> conversations = conversationMapper.findPublicAllWithFilters(search, genre, sort, size, offset);

        return conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
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

        int offset = page * size;
        List<Conversation> conversations = conversationMapper.findAll(size, offset);

        return conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Update conversation metadata
     */
    @Transactional
    public ConversationResponse updateConversation(UUID conversationId, UpdateConversationRequest request) {
        log.info("Updating conversation: {}", conversationId);

        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        if (request.getTitle() != null) {
            conversation.setTitle(request.getTitle());
        }
        if (request.getIsPrivate() != null) {
            conversation.setIsPrivate(request.getIsPrivate());
        }

        conversationMapper.update(conversation);

        return ConversationResponse.from(conversation);
    }

    /**
     * Delete conversation
     */
    @Transactional
    public void deleteConversation(UUID conversationId) {
        log.info("Deleting conversation: {}", conversationId);

        conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        conversationMapper.delete(conversationId);
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
        Conversation original = conversationMapper.findById(conversationId)
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
        List<Message> allMessages = conversationMapper.findMessagesByConversationId(conversationId);
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

        conversationMapper.insert(forked);

        // Copy messages with new IDs and timestamps
        for (Message msg : messagesToCopy) {
            Message copied = Message.builder()
                    .id(UUID.randomUUID())
                    .conversationId(forked.getId())
                    .senderId(msg.getSenderId())
                    .role(msg.getRole())
                    .content(msg.getContent())
                    .build();

            conversationMapper.insertMessage(copied);
        }

        // Update forked conversation's message count
        conversationMapper.updateMessageCount(forked.getId());

        // Update parent's has_been_forked flag (CRITICAL: atomic transaction)
        conversationMapper.updateHasBeenForked(conversationId, true);

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

        Conversation conversation = conversationMapper.findById(conversationId)
                .orElseThrow(() -> new ResourceNotFoundException(CONVERSATION_NOT_FOUND + conversationId));

        ForkRelationshipResponse.ForkRelationshipResponseBuilder builder = ForkRelationshipResponse.builder()
                .conversationId(conversationId)
                .isRoot(conversation.getIsRoot())
                .depth(Boolean.TRUE.equals(conversation.getIsRoot()) ? 0 : 1);

        // If this is a forked conversation, get parent info
        if (conversation.getParentConversationId() != null) {
            Conversation parent = conversationMapper.findById(conversation.getParentConversationId())
                    .orElse(null);
            if (parent != null) {
                builder.parentConversationId(parent.getId())
                        .parentTitle(parent.getTitle());
            }
        }

        return builder.build();
    }
}
