package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.ConversationMemo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.Optional;
import java.util.UUID;

public interface ConversationMemoJpaRepository extends JpaRepository<ConversationMemo, UUID>, QuerydslPredicateExecutor<ConversationMemo> {
    Page<ConversationMemo> findByUserIdOrderByUpdatedAtDesc(UUID userId, Pageable pageable);
    
    Optional<ConversationMemo> findByUserIdAndConversationId(UUID userId, UUID conversationId);
    
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);
    
    void deleteByUserIdAndConversationId(UUID userId, UUID conversationId);
}
