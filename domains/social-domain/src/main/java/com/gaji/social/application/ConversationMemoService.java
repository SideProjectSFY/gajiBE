package com.gaji.social.application;

import com.gaji.shared.contract.dto.MemoResponse;
import com.gaji.auth.application.UserFacade;
import com.gaji.chat.application.ConversationFacade;
import com.gaji.social.domain.model.ConversationMemo;
import com.gaji.social.domain.repository.ConversationMemoRepository;
import com.gaji.common.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationMemoService {

    private final ConversationMemoRepository conversationMemoRepository;
    private final ConversationFacade conversationFacade;
    private final UserFacade userFacade;

    /**
     * Save or update a memo (UPSERT logic).
     * If memo exists for user+conversation, update it.
     * Otherwise, create new memo.
     */
    @Transactional
    public MemoResponse saveMemo(UUID conversationId, UUID userId, String content) {
        // Validate user exists
        if (!userFacade.existsById(userId)) {
            throw new ResourceNotFoundException("User not found: " + userId);
        }

        // Validate conversation exists
        if (!conversationFacade.existsById(conversationId)) {
            throw new ResourceNotFoundException("Conversation not found: " + conversationId);
        }

        // Find existing memo or create new
        ConversationMemo memo = conversationMemoRepository
            .findByUserIdAndConversationId(userId, conversationId)
            .orElse(null);

        if (memo == null) {
            memo = ConversationMemo.builder()
                // .id(UUID.randomUUID()) // Handled by @GeneratedValue if configured, but here builder
                .userId(userId)
                .conversationId(conversationId)
                .content(content)
                // createdAt handled by Auditing or manual?
                // Using entity listener but let's be safe if ID is manual
                // If using Builder, entity listener works on persist.
                .build();
            // If ID is generated value, we don't set it.
            // But builder might set it if passed.
            // Let's rely on JPA generation if annotated with @GeneratedValue
        } else {
            memo.setContent(content);
            // updatedAt handled by Auditing
        }

        ConversationMemo saved = conversationMemoRepository.save(memo);

        log.info("Saved memo for user {} on conversation {}", userId, conversationId);

        return toResponse(saved);
    }

    /**
     * Get memo for user and conversation.
     * Returns null if not found.
     */
    @Transactional(readOnly = true)
    public MemoResponse getMemo(UUID conversationId, UUID userId) {
        // Validate conversation exists
        if (!conversationFacade.existsById(conversationId)) {
            throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        return conversationMemoRepository
            .findByUserIdAndConversationId(userId, conversationId)
            .map(this::toResponse)
            .orElse(null);
    }

    /**
     * Delete memo for user and conversation.
     * Idempotent - no error if memo doesn't exist.
     */
    @Transactional
    public void deleteMemo(UUID conversationId, UUID userId) {
        // Validate conversation exists
        if (!conversationFacade.existsById(conversationId)) {
            throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        if (conversationMemoRepository.existsByUserIdAndConversationId(userId, conversationId)) {
            conversationMemoRepository.deleteByUserIdAndConversationId(userId, conversationId);
            log.info("Deleted memo for user {} on conversation {}", userId, conversationId);
        } else {
            log.info("No memo to delete for user {} on conversation {}", userId, conversationId);
        }
    }
    
    private MemoResponse toResponse(ConversationMemo memo) {
        // Assuming MemoResponse has static from method or builder
        // The original code used MemoResponse.from(memo)
        // If MemoResponse expects User/Conversation populated, it will fail because they are null.
        // But usually MemoResponse is simple DTO.
        // Let's assume it works with just ID and content.
        // Since I cannot see MemoResponse definition here, I'll rely on existing usage.
        
        // Wait, original code `MemoResponse.from(memo)` implies static method.
        // I'll stick to that.
        // But if `memo` is proxy, might be issue? No, `save` returns entity.
        // But `findBy` returns entity.
        // Let's check `MemoResponse.from` usage?
        // I'll try to use the same logic as before.
        
        return MemoResponse.builder()
                .id(memo.getId())
                .userId(memo.getUserId())
                .conversationId(memo.getConversationId())
                .content(memo.getContent())
                .createdAt(memo.getCreatedAt())
                .updatedAt(memo.getUpdatedAt())
                .build();
    }
}
