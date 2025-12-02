package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.MemoResponse;
import com.gaji.corebackend.dto.SaveMemoRequest;
import com.gaji.corebackend.security.CurrentUser;
import com.gaji.corebackend.security.UserPrincipal;
import com.gaji.corebackend.service.ConversationMemoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST API for conversation memo operations.
 * All endpoints require authentication.
 */
@RestController
@RequestMapping("/api/v1/conversations")
@RequiredArgsConstructor
public class ConversationMemoController {

    private final ConversationMemoService conversationMemoService;

    /**
     * Save or update a memo for a conversation (UPSERT).
     * POST /api/v1/conversations/{id}/memo
     */
    @PostMapping("/{id}/memo")
    public ResponseEntity<MemoResponse> saveMemo(
        @PathVariable UUID id,
        @Valid @RequestBody SaveMemoRequest request,
        @CurrentUser UserPrincipal currentUser
    ) {
        MemoResponse response = conversationMemoService.saveMemo(
            id,
            currentUser.getUserId(),
            request.getContent()
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Get memo for a conversation.
     * GET /api/v1/conversations/{id}/memo
     * Returns 404 if no memo exists.
     */
    @GetMapping("/{id}/memo")
    public ResponseEntity<MemoResponse> getMemo(
        @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        MemoResponse response = conversationMemoService.getMemo(id, currentUser.getUserId());
        
        if (response == null) {
            return ResponseEntity.notFound().build();
        }
        
        return ResponseEntity.ok(response);
    }

    /**
     * Delete memo for a conversation.
     * DELETE /api/v1/conversations/{id}/memo
     * Idempotent - returns 204 even if memo doesn't exist.
     */
    @DeleteMapping("/{id}/memo")
    public ResponseEntity<Void> deleteMemo(
        @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        conversationMemoService.deleteMemo(id, currentUser.getUserId());
        return ResponseEntity.noContent().build();
    }
}
