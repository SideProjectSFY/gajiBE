package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.Message;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * MyBatis Mapper for Conversation CRUD operations
 */
@Mapper
public interface ConversationMapper {

    /**
     * Create a new conversation
     */
    void insert(Conversation conversation);

    /**
     * Find conversation by ID
     */
    Optional<Conversation> findById(@Param("id") UUID id);

    /**
     * Find conversation by ID with messages
     */
    Optional<Conversation> findByIdWithMessages(@Param("id") UUID id);

    /**
     * Find all conversations for a user
     */
    List<Conversation> findByUserId(
            @Param("userId") UUID userId,
            @Param("limit") int limit,
            @Param("offset") int offset
    );

    /**
     * Find all conversations (admin/public view)
     */
    List<Conversation> findAll(
            @Param("limit") int limit,
            @Param("offset") int offset
    );

    /**
     * Update conversation metadata
     */
    int update(Conversation conversation);

    /**
     * Soft delete conversation
     */
    int delete(@Param("id") UUID id);

    /**
     * Find messages for a conversation
     */
    List<Message> findMessagesByConversationId(@Param("conversationId") UUID conversationId);

    /**
     * Insert a message
     */
    void insertMessage(Message message);

    /**
     * Update message count
     */
    void updateMessageCount(@Param("conversationId") UUID conversationId);

    /**
     * Count total conversations for a user
     */
    int countByUserId(@Param("userId") UUID userId);

    /**
     * Update has_been_forked flag
     */
    void updateHasBeenForked(@Param("conversationId") UUID conversationId, @Param("hasBeenForked") boolean hasBeenForked);
}
