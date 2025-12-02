package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.MemoResponse;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationMemo;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.repository.ConversationMemoRepository;
import com.gaji.corebackend.repository.ConversationRepository;
import com.gaji.corebackend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationMemoService {

    private final ConversationMemoRepository conversationMemoRepository;
    private final ConversationRepository conversationRepository;
    private final UserRepository userRepository;

    /**
     * Save or update a memo (UPSERT logic).
     * If memo exists for user+conversation, update it.
     * Otherwise, create new memo.
     */
    @Transactional
    public MemoResponse saveMemo(UUID conversationId, UUID userId, String content) {
        // Validate user exists
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("User not found: " + userId));

        // Validate conversation exists
        Conversation conversation = conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        // Find existing memo or create new
        ConversationMemo memo = conversationMemoRepository
            .findByUserIdAndConversationId(userId, conversationId)
            .orElse(ConversationMemo.builder()
                .userId(userId)
                .conversationId(conversationId)
                .build());

        // Update content
        memo.setContent(content);

        // Save (insert or update)
        ConversationMemo savedMemo = conversationMemoRepository.save(memo);

        log.info("Saved memo for user {} on conversation {}", userId, conversationId);

        return MemoResponse.from(savedMemo);
    }

    /**
     * Get memo for user and conversation.
     * Returns null if not found.
     */
    @Transactional(readOnly = true)
    public MemoResponse getMemo(UUID conversationId, UUID userId) {
        // Validate conversation exists
        conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        return conversationMemoRepository
            .findByUserIdAndConversationId(userId, conversationId)
            .map(MemoResponse::from)
            .orElse(null);
    }

    /**
     * Delete memo for user and conversation.
     * Idempotent - no error if memo doesn't exist.
     */
    @Transactional
    public void deleteMemo(UUID conversationId, UUID userId) {
        // Validate conversation exists
        conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        boolean existed = conversationMemoRepository.existsByUserIdAndConversationId(userId, conversationId);

        if (existed) {
            conversationMemoRepository.deleteByUserIdAndConversationId(userId, conversationId);
            log.info("Deleted memo for user {} on conversation {}", userId, conversationId);
        } else {
            log.info("No memo to delete for user {} on conversation {}", userId, conversationId);
        }
    }
}
