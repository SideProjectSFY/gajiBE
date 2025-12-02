package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationLike;
import com.gaji.corebackend.entity.ConversationLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ConversationLikeRepository extends JpaRepository<ConversationLike, ConversationLikeId> {

    /**
     * Check if user has liked a conversation
     */
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);

    /**
     * Get paginated list of conversations liked by user
     */
    @Query("""
        SELECT c FROM Conversation c
        JOIN ConversationLike cl ON cl.conversationId = c.id
        WHERE cl.userId = :userId
        ORDER BY cl.createdAt DESC
    """)
    Page<Conversation> findLikedConversationsByUserId(@Param("userId") UUID userId, Pageable pageable);

    /**
     * Count likes for a conversation
     */
    long countByConversationId(UUID conversationId);
}
