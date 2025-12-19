package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.ConversationResponse;
import com.gaji.corebackend.dto.LikeResponse;
import com.gaji.corebackend.security.CurrentUser;
import com.gaji.corebackend.security.UserPrincipal;
import com.gaji.corebackend.service.ConversationLikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST API for conversation like operations
 */
@RestController
@RequestMapping("/api/v1/conversations")
@RequiredArgsConstructor
public class ConversationLikeController {

    private final ConversationLikeService conversationLikeService;

    /**
     * Like a conversation.
     * POST /api/conversations/{id}/like
     */
    @PostMapping("/{id}/like")
    public ResponseEntity<LikeResponse> likeConversation(
        @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = conversationLikeService.likeConversation(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Unlike a conversation.
     * DELETE /api/conversations/{id}/unlike
     */
    @DeleteMapping("/{id}/unlike")
    public ResponseEntity<LikeResponse> unlikeConversation(
        @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = conversationLikeService.unlikeConversation(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Check if user liked a conversation.
     * GET /api/conversations/{id}/liked
     */
    @GetMapping("/{id}/liked")
    public ResponseEntity<LikeResponse> isLiked(
        @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = conversationLikeService.isLiked(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Get user's liked conversations.
     * GET /api/users/me/liked-conversations
     */
    @GetMapping("/users/me/liked-conversations")
    public ResponseEntity<Page<ConversationResponse>> getLikedConversations(
        @CurrentUser UserPrincipal currentUser,
        @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        Page<ConversationResponse> conversations = conversationLikeService.getLikedConversations(
            currentUser.getUserId(),
            pageable
        );
        return ResponseEntity.ok(conversations);
    }
}
