package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.ConversationMemo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ConversationMemoRepository extends JpaRepository<ConversationMemo, UUID> {

    /**
     * Find memo by user and conversation (unique constraint)
     */
    Optional<ConversationMemo> findByUserIdAndConversationId(UUID userId, UUID conversationId);

    /**
     * Check if memo exists for user and conversation
     */
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);

    /**
     * Delete memo by user and conversation
     */
    void deleteByUserIdAndConversationId(UUID userId, UUID conversationId);
}
