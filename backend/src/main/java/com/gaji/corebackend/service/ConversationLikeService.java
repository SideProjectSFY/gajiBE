package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.ConversationResponse;
import com.gaji.corebackend.dto.LikeResponse;
import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationLike;
import com.gaji.corebackend.entity.ConversationLikeId;
import com.gaji.corebackend.repository.ConversationLikeRepository;
import com.gaji.corebackend.repository.ConversationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class ConversationLikeService {

    private final ConversationLikeRepository conversationLikeRepository;
    private final ConversationRepository conversationRepository;

    /**
     * Like a conversation (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse likeConversation(UUID conversationId, UUID userId) {
        // Verify conversation exists
        Conversation conversation = conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        // Check if already liked
        boolean alreadyLiked = conversationLikeRepository.existsByUserIdAndConversationId(userId, conversationId);

        if (alreadyLiked) {
            log.info("User {} already liked conversation {}", userId, conversationId);
            return LikeResponse.builder()
                .isLiked(true)
                .likeCount(conversation.getLikeCount())
                .build();
        }

        // Create like (trigger will update like_count automatically)
        ConversationLike like = ConversationLike.builder()
            .userId(userId)
            .conversationId(conversationId)
            .build();

        conversationLikeRepository.save(like);
        conversationLikeRepository.flush();

        // Refresh to get updated like_count from trigger
        conversation = conversationRepository.findById(conversationId).orElseThrow();

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
        Conversation conversation = conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        ConversationLikeId likeId = new ConversationLikeId(userId, conversationId);
        boolean existed = conversationLikeRepository.existsById(likeId);

        if (!existed) {
            log.info("User {} never liked conversation {}", userId, conversationId);
            return LikeResponse.builder()
                .isLiked(false)
                .likeCount(conversation.getLikeCount())
                .build();
        }

        // Delete like (trigger will update like_count automatically)
        conversationLikeRepository.deleteById(likeId);
        conversationLikeRepository.flush();

        // Refresh to get updated like_count from trigger
        conversation = conversationRepository.findById(conversationId).orElseThrow();

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
        Conversation conversation = conversationRepository.findById(conversationId)
            .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        boolean isLiked = conversationLikeRepository.existsByUserIdAndConversationId(userId, conversationId);

        return LikeResponse.builder()
            .isLiked(isLiked)
            .likeCount(conversation.getLikeCount())
            .build();
    }

    /**
     * Get paginated list of conversations liked by user.
     */
    @Transactional(readOnly = true)
    public Page<ConversationResponse> getLikedConversations(UUID userId, Pageable pageable) {
        Page<Conversation> conversations = conversationLikeRepository.findLikedConversationsByUserId(userId, pageable);

        return conversations.map(ConversationResponse::from);
    }
}
