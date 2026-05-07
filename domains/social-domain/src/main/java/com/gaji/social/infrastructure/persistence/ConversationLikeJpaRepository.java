package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.ConversationLike;
import com.gaji.social.domain.model.ConversationLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface ConversationLikeJpaRepository extends JpaRepository<ConversationLike, ConversationLikeId>, QuerydslPredicateExecutor<ConversationLike> {
    long countByConversationId(UUID conversationId);
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);
    Page<ConversationLike> findByUserId(UUID userId, Pageable pageable);
}
