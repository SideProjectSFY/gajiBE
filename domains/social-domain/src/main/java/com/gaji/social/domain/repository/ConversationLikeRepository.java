package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.ConversationLike;
import com.gaji.social.domain.model.ConversationLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface ConversationLikeRepository {
    
    ConversationLike save(ConversationLike conversationLike);
    
    Optional<ConversationLike> findById(ConversationLikeId id);
    
    void deleteById(ConversationLikeId id);

    long countByConversationId(UUID conversationId);
    
    boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId);
    
    Page<ConversationLike> findByUserId(UUID userId, Pageable pageable);
}

