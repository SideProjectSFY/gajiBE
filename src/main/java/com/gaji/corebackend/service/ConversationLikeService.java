package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.ConversationResponse;
import com.gaji.corebackend.dto.LikeResponse;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationLike;
import com.gaji.corebackend.mapper.ConversationLikeMapper;
import com.gaji.corebackend.mapper.ConversationMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationLikeService {

    private final ConversationLikeMapper conversationLikeMapper;
    private final ConversationMapper conversationMapper;

    /**
     * Like a conversation (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse likeConversation(UUID conversationId, UUID userId) {
        // Verify conversation exists
        Conversation conversation = conversationMapper.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        // Check if already liked
        boolean alreadyLiked = conversationLikeMapper.existsByUserIdAndConversationId(userId, conversationId);

        if (alreadyLiked) {
            log.info("User {} already liked conversation {}", userId, conversationId);
            return LikeResponse.builder()
                .isLiked(true)
                .likeCount(conversation.getLikeCount())
                .build();
        }

        // Create like
        ConversationLike like = ConversationLike.builder()
            .userId(userId)
            .conversationId(conversationId)
            .build();

        conversationLikeMapper.insert(like);
        
        // Refresh to get updated like_count from trigger
        conversation = conversationMapper.findById(conversationId).orElseThrow();

        log.info("User {} liked conversation {}", userId, conversationId);

        return LikeResponse.builder()
            .isLiked(true)
            .likeCount(conversation.getLikeCount())
            .build();
    }

    /**
     * Unlike a conversation (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse unlikeConversation(UUID conversationId, UUID userId) {
        // Verify conversation exists
        Conversation conversation = conversationMapper.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        boolean existed = conversationLikeMapper.existsByUserIdAndConversationId(userId, conversationId);

        if (!existed) {
            log.info("User {} never liked conversation {}", userId, conversationId);
            return LikeResponse.builder()
                .isLiked(false)
                .likeCount(conversation.getLikeCount())
                .build();
        }

        // Delete like
        conversationLikeMapper.deleteByUserIdAndConversationId(userId, conversationId);

        // Refresh to get updated like_count from trigger
        conversation = conversationMapper.findById(conversationId).orElseThrow();

        log.info("User {} unliked conversation {}", userId, conversationId);

        return LikeResponse.builder()
            .isLiked(false)
            .likeCount(conversation.getLikeCount())
            .build();
    }

    /**
     * Check if user liked a conversation.
     */
    @Transactional(readOnly = true)
    public LikeResponse isLiked(UUID conversationId, UUID userId) {
        Conversation conversation = conversationMapper.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        boolean isLiked = conversationLikeMapper.existsByUserIdAndConversationId(userId, conversationId);

        return LikeResponse.builder()
            .isLiked(isLiked)
            .likeCount(conversation.getLikeCount())
            .build();
    }
    
    /**
     * Get liked conversations for a user
     */
    @Transactional(readOnly = true)
    public Page<ConversationResponse> getLikedConversations(UUID userId, Pageable pageable) {
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();
        
        List<Conversation> conversations = conversationLikeMapper.findLikedConversationsByUserId(userId, limit, offset);
        long total = conversationLikeMapper.countLikedConversationsByUserId(userId);
        
        List<ConversationResponse> responses = conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
                
        return new PageImpl<>(responses, pageable, total);
    }
}
