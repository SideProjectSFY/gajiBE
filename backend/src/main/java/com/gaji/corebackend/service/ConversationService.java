package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.Message;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.repository.ConversationMapper;
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
    
    private static final String CONVERSATION_NOT_FOUND = "Conversation not found: ";

    /**
     * Create a new conversation
     */
    @Transactional
    public ConversationResponse createConversation(UUID userId, CreateConversationRequest request) {
        log.info("Creating conversation for user: {}, scenario: {}", userId, request.getScenarioId());

        // Create conversation entity
        User user = new User();
        user.setId(userId);

        Conversation conversation = Conversation.builder()
                .id(UUID.randomUUID())
                .user(user)
                .scenarioId(request.getScenarioId())
                .scenarioType(request.getScenarioType())
                .characterVectordbId(request.getCharacterVectordbId())
                .title(request.getTitle())
                .isRoot(true)
                .messageCount(0)
                .likeCount(0)
                .isPrivate(Boolean.TRUE.equals(request.getIsPrivate()))
                .build();

        conversationMapper.insert(conversation);

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
        if (!original.getUser().getId().equals(userId)) {
            throw new BadRequestException("User does not own this conversation");
        }

        // Validate: Only ROOT conversations can be forked (is_root=TRUE, parent_conversation_id IS NULL)
        if (original.getParentConversation() != null || !Boolean.TRUE.equals(original.getIsRoot())) {
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

        // Create forked conversation
        User user = new User();
        user.setId(userId);

        Conversation forked = Conversation.builder()
                .id(UUID.randomUUID())
                .user(user)
                .scenarioId(original.getScenarioId())
                .scenarioType(original.getScenarioType())
                .characterVectordbId(original.getCharacterVectordbId())
                .parentConversation(original)
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
                    .conversation(forked)
                    .sender(msg.getSender())
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
                .build();
    }
}
