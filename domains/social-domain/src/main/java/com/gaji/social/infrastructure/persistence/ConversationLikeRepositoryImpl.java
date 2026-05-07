package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.ConversationLike;
import com.gaji.social.domain.model.ConversationLikeId;
import com.gaji.social.domain.repository.ConversationLikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ConversationLikeRepositoryImpl implements ConversationLikeRepository {

    private final ConversationLikeJpaRepository jpaRepository;

    @Override
    public ConversationLike save(ConversationLike conversationLike) {
        return jpaRepository.save(conversationLike);
    }

    @Override
    public Optional<ConversationLike> findById(ConversationLikeId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(ConversationLikeId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public long countByConversationId(UUID conversationId) {
        return jpaRepository.countByConversationId(conversationId);
    }

    @Override
    public boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId) {
        return jpaRepository.existsByUserIdAndConversationId(userId, conversationId);
    }

    @Override
    public Page<ConversationLike> findByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserId(userId, pageable);
    }
}
