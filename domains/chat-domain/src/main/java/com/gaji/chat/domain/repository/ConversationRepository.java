package com.gaji.chat.domain.repository;

import com.gaji.chat.domain.model.Conversation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ConversationRepository {
    
    Conversation save(Conversation conversation);
    
    Optional<Conversation> findById(UUID id);

    boolean existsById(UUID id);
    
    List<Conversation> findAllById(Iterable<UUID> ids);
    
    Page<Conversation> findAll(Pageable pageable);
    
    void deleteById(UUID id);

    Optional<Conversation> findByIdWithMessages(UUID id);

    Page<Conversation> findByUserId(UUID userId, Pageable pageable);

    Page<Conversation> findPublicByUserId(UUID userId, Pageable pageable);
    
    Page<Conversation> findPublicAll(Pageable pageable);

    Page<Conversation> findPublicAllWithFilters(String search, String genre, Pageable pageable);

    void incrementMessageCount(UUID id);

    void updateMessageCount(UUID id, int count);

    void updateHasBeenForked(UUID id, boolean hasBeenForked);

    void incrementLikeCount(UUID id);

    void decrementLikeCount(UUID id);

    Optional<Conversation> findFirstByScenarioIdOrderByCreatedAtAsc(UUID scenarioId);
    
    Page<Conversation> findLikedByUserId(UUID userId, boolean includePrivate, Pageable pageable);
}
