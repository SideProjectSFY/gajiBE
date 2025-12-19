package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.MemoResponse;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationMemo;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.mapper.ConversationMapper;
import com.gaji.corebackend.mapper.ConversationMemoMapper;
import com.gaji.corebackend.mapper.UserMapper;
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

    private final ConversationMemoMapper conversationMemoMapper;
    private final ConversationMapper conversationMapper;
    private final UserMapper userMapper;

    /**
     * Save or update a memo (UPSERT logic).
     * If memo exists for user+conversation, update it.
     * Otherwise, create new memo.
     */
    @Transactional
    public MemoResponse saveMemo(UUID conversationId, UUID userId, String content) {
        // Validate user exists
        if (!userMapper.existsById(userId)) {
            throw new ResourceNotFoundException("User not found: " + userId);
        }

        // Validate conversation exists
        if (!conversationMapper.existsById(conversationId)) {
            throw new ResourceNotFoundException("Conversation not found: " + conversationId);
        }

        // Find existing memo or create new
        ConversationMemo memo = conversationMemoMapper
            .findByUserIdAndConversationId(userId, conversationId)
            .orElse(null);

        if (memo == null) {
            memo = ConversationMemo.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .conversationId(conversationId)
                .content(content)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();
            conversationMemoMapper.insert(memo);
        } else {
            memo.setContent(content);
            memo.setUpdatedAt(LocalDateTime.now());
            conversationMemoMapper.update(memo);
        }

        log.info("Saved memo for user {} on conversation {}", userId, conversationId);

        return MemoResponse.from(memo);
    }

    /**
     * Get memo for user and conversation.
     * Returns null if not found.
     */
    @Transactional(readOnly = true)
    public MemoResponse getMemo(UUID conversationId, UUID userId) {
        // Validate conversation exists
        if (!conversationMapper.existsById(conversationId)) {
            throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        return conversationMemoMapper
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
        if (!conversationMapper.existsById(conversationId)) {
            throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        boolean existed = conversationMemoMapper.existsByUserIdAndConversationId(userId, conversationId);

        if (existed) {
            conversationMemoMapper.deleteByUserIdAndConversationId(userId, conversationId);
            log.info("Deleted memo for user {} on conversation {}", userId, conversationId);
        } else {
            log.info("No memo to delete for user {} on conversation {}", userId, conversationId);
        }
    }
}
