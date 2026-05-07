package com.gaji.social.application;

import com.gaji.shared.contract.dto.ConversationResponse;
import com.gaji.shared.contract.dto.LikeResponse;
import com.gaji.chat.application.ConversationFacade;
import com.gaji.chat.domain.model.Conversation;
import com.gaji.social.domain.model.ConversationLike;
import com.gaji.social.domain.model.ConversationLikeId;
import com.gaji.social.domain.repository.ConversationLikeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationLikeService {

    private final ConversationLikeRepository conversationLikeRepository;
    private final ConversationFacade conversationFacade;

    /**
     * Like a conversation (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse likeConversation(UUID conversationId, UUID userId) {
        // Verify conversation exists
        if (!conversationFacade.existsById(conversationId)) {
             throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        // Check if already liked
        boolean alreadyLiked = conversationLikeRepository.existsByUserIdAndConversationId(userId, conversationId);

        if (alreadyLiked) {
            log.info("User {} already liked conversation {}", userId, conversationId);
            long likeCount = conversationLikeRepository.countByConversationId(conversationId);
            return LikeResponse.builder()
                .isLiked(true)
                .likeCount((int) likeCount)
                .build();
        }

        // Create like
        ConversationLike like = ConversationLike.builder()
            .userId(userId)
            .conversationId(conversationId)
            // .createdAt(LocalDateTime.now()) handled by auditing
            .build();

        conversationLikeRepository.save(like);
        
        // Explicitly increment like count (assuming no DB trigger, or okay to double update if idempotent logic handles it, but safer to assume trigger handles it OR query count directly)
        // Previous logic: "Refresh to get updated like_count from trigger"
        // To be safe and framework-agnostic, query the count directly using repository
        long likeCount = conversationLikeRepository.countByConversationId(conversationId);
        
        // Also update conversation entity if possible, or trigger does it.
        // If trigger exists, count matches DB state.
        // If no trigger, count matches DB state (which includes our insert).

        log.info("User {} liked conversation {}", userId, conversationId);

        return LikeResponse.builder()
            .isLiked(true)
            .likeCount((int) likeCount)
            .build();
    }

    /**
     * Unlike a conversation (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse unlikeConversation(UUID conversationId, UUID userId) {
        // Verify conversation exists
        if (!conversationFacade.existsById(conversationId)) {
             throw new IllegalArgumentException("Conversation not found: " + conversationId);
        }

        boolean existed = conversationLikeRepository.existsByUserIdAndConversationId(userId, conversationId);

        if (!existed) {
            log.info("User {} never liked conversation {}", userId, conversationId);
            long likeCount = conversationLikeRepository.countByConversationId(conversationId);
            return LikeResponse.builder()
                .isLiked(false)
                .likeCount((int) likeCount)
                .build();
        }

        // Delete like
        conversationLikeRepository.deleteById(new ConversationLikeId(userId, conversationId));

        // Get updated like count
        long likeCount = conversationLikeRepository.countByConversationId(conversationId);

        log.info("User {} unliked conversation {}", userId, conversationId);

        return LikeResponse.builder()
            .isLiked(false)
            .likeCount((int) likeCount)
            .build();
    }

    /**
     * Check if user liked a conversation.
     */
    @Transactional(readOnly = true)
    public LikeResponse isLiked(UUID conversationId, UUID userId) {
        Conversation conversation = conversationFacade.getById(conversationId);

        boolean isLiked = conversationLikeRepository.existsByUserIdAndConversationId(userId, conversationId);

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
        Page<ConversationLike> likes = conversationLikeRepository.findByUserId(userId, pageable);
        List<UUID> conversationIds = likes.getContent().stream()
                .map(ConversationLike::getConversationId)
                .collect(Collectors.toList());

        if (conversationIds.isEmpty()) {
            return new PageImpl<>(Collections.emptyList(), pageable, likes.getTotalElements());
        }
        
        List<Conversation> conversations = conversationFacade.findAllById(conversationIds);
        
        List<ConversationResponse> responses = conversations.stream()
                .map(ConversationResponse::from)
                .collect(Collectors.toList());
                
        return new PageImpl<>(responses, pageable, likes.getTotalElements());
    }
}
