package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.ConversationMemo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface ConversationMemoRepository {
    
    ConversationMemo save(ConversationMemo conversationMemo);
    
    Optional<ConversationMemo> findById(UUID id);
    
    void deleteById(UUID id);

    Page<ConversationMemo> findByUserIdOrderByUpdatedAtDesc(UUID userId, Pageable pageable);
    
    Optional<ConversationMemo> findByUserIdAndConversationId(UUID userId, UUID conversationId);
    
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);
    
    void deleteByUserIdAndConversationId(UUID userId, UUID conversationId);
}

