package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.ConversationMemo;
import com.gaji.social.domain.repository.ConversationMemoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ConversationMemoRepositoryImpl implements ConversationMemoRepository {

    private final ConversationMemoJpaRepository jpaRepository;

    @Override
    public ConversationMemo save(ConversationMemo conversationMemo) {
        return jpaRepository.save(conversationMemo);
    }

    @Override
    public Optional<ConversationMemo> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Page<ConversationMemo> findByUserIdOrderByUpdatedAtDesc(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserIdOrderByUpdatedAtDesc(userId, pageable);
    }

    @Override
    public Optional<ConversationMemo> findByUserIdAndConversationId(UUID userId, UUID conversationId) {
        return jpaRepository.findByUserIdAndConversationId(userId, conversationId);
    }

    @Override
    public boolean existsByUserIdAndConversationId(UUID userId, UUID conversationId) {
        return jpaRepository.existsByUserIdAndConversationId(userId, conversationId);
    }

    @Override
    public void deleteByUserIdAndConversationId(UUID userId, UUID conversationId) {
        jpaRepository.deleteByUserIdAndConversationId(userId, conversationId);
    }
}
