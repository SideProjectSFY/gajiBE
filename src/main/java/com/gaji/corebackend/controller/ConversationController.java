package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.service.ConversationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST API Controller for Conversation CRUD operations
 *
 * Endpoints:
 * - POST /api/conversations - Create new conversation
 * - GET /api/conversations/{id} - Get conversation by ID with messages
 * - GET /api/conversations - List conversations
 * - PUT /api/conversations/{id} - Update conversation
 * - DELETE /api/conversations/{id} - Delete conversation
 * - POST /api/conversations/{id}/fork - Fork a ROOT conversation
 */
@RestController
@RequestMapping("/api/v1/conversations")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Conversations", description = "Conversation Management API")
public class ConversationController {

    private final ConversationService conversationService;

    /**
     * Create a new conversation
     */
    @PostMapping
    @Operation(summary = "Create a new conversation", description = "Creates a new conversation in a scenario with a character")
    @ApiResponse(responseCode = "201", description = "Conversation created successfully")
    @ApiResponse(responseCode = "400", description = "Invalid request data")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    public ResponseEntity<ConversationResponse> createConversation(
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody CreateConversationRequest request) {

        log.info("Creating conversation: userId={}, scenarioId={}", userId, request.getScenarioId());

        ConversationResponse response = conversationService.createConversation(userId, request);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Get conversation by ID with messages
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get conversation by ID", description = "Retrieves a conversation with all messages")
    @ApiResponse(responseCode = "200", description = "Conversation retrieved successfully")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    @ApiResponse(responseCode = "403", description = "Access forbidden")
    public ResponseEntity<ConversationResponse> getConversation(
            @PathVariable UUID id,
            @RequestHeader(value = "X-User-Id", required = false) UUID userId) {

        log.debug("Getting conversation: id={}", id);

        ConversationResponse response = conversationService.getConversationWithMessages(id);

        // Access control: check if user can access this private conversation
        if (Boolean.TRUE.equals(response.getIsPrivate()) && userId != null && !response.getUserId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(response);
    }

    /**
     * List conversations
     */
    @GetMapping
    @Operation(summary = "List conversations", description = "Lists conversations with pagination")
    @ApiResponse(responseCode = "200", description = "Conversations retrieved successfully")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    public ResponseEntity<List<ConversationResponse>> listConversations(
            @RequestHeader(value = "X-User-Id", required = false) UUID userId,
            @RequestParam(value = "userId", required = false) UUID targetUserId,
            @RequestParam(value = "filter", required = false) String filter,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        log.debug("Listing conversations: userId={}, targetUserId={}, filter={}, page={}, size={}", userId, targetUserId, filter, page, size);

        List<ConversationResponse> responses;
        if (targetUserId != null) {
            // Fetch conversations for a specific user
            if (userId != null && userId.equals(targetUserId)) {
                // Own conversations (all)
                responses = conversationService.listUserConversations(targetUserId, page, size);
            } else {
                // Others' conversations (public only)
                responses = conversationService.listUserPublicConversations(targetUserId, page, size);
            }
        } else if ("my".equals(filter) && userId != null) {
            // List user's conversations
            responses = conversationService.listUserConversations(userId, page, size);
        } else if ("public".equals(filter) || userId == null) {
            // List all public conversations
            responses = conversationService.listPublicConversations(page, size);
        } else {
            // Default for authenticated user: list their own conversations (legacy behavior preserved but can be changed)
            // User requested "Header Conversations = All Conversations", so if no filter is provided but user is logged in,
            // we might want to show public feed?
            // However, to be safe and consistent with ScenarioController, let's default to "my" if logged in, unless filter=public is passed.
            // But the frontend will pass filter=public.
            responses = conversationService.listUserConversations(userId, page, size);
        }

        return ResponseEntity.ok(responses);
    }

    /**
     * Update conversation metadata
     */
    @PutMapping("/{id}")
    @Operation(summary = "Update conversation", description = "Updates conversation title or privacy settings")
    @ApiResponse(responseCode = "200", description = "Conversation updated successfully")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    @ApiResponse(responseCode = "403", description = "Access forbidden")
    public ResponseEntity<ConversationResponse> updateConversation(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody UpdateConversationRequest request) {

        log.info("Updating conversation: id={}, userId={}", id, userId);

        // Access control: verify user owns the conversation
        ConversationResponse existing = conversationService.getConversation(id);
        if (!existing.getUserId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        ConversationResponse response = conversationService.updateConversation(id, request);

        return ResponseEntity.ok(response);
    }

    /**
     * Delete conversation
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Delete conversation", description = "Deletes a conversation and all its messages")
    @ApiResponse(responseCode = "204", description = "Conversation deleted successfully")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    @ApiResponse(responseCode = "403", description = "Access forbidden")
    public ResponseEntity<Void> deleteConversation(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId) {

        log.info("Deleting conversation: id={}, userId={}", id, userId);

        // Access control: verify user owns the conversation
        ConversationResponse existing = conversationService.getConversation(id);
        if (!existing.getUserId().equals(userId)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        conversationService.deleteConversation(id);

        return ResponseEntity.noContent().build();
    }

    /**
     * Fork a ROOT conversation (copy min(6, total) messages)
     */
    @PostMapping("/{id}/fork")
    @Operation(summary = "Fork a conversation", description = "Creates a forked conversation with copied messages (ROOT only)")
    @ApiResponse(responseCode = "201", description = "Conversation forked successfully")
    @ApiResponse(responseCode = "400", description = "Cannot fork a forked conversation")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    public ResponseEntity<ForkConversationResponse> forkConversation(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId) {

        log.info("Forking conversation: id={}, userId={}", id, userId);

        ForkConversationResponse response = conversationService.forkConversation(id, userId);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Get fork relationship for a conversation
     */
    @GetMapping("/{id}/fork-relationship")
    @Operation(summary = "Get fork relationship", description = "Returns parent/child fork relationships for a conversation")
    @ApiResponse(responseCode = "200", description = "Fork relationship retrieved successfully")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    public ResponseEntity<ForkRelationshipResponse> getForkRelationship(@PathVariable UUID id) {
        log.debug("Getting fork relationship: id={}", id);
        
        ForkRelationshipResponse response = conversationService.getForkRelationship(id);
        
        return ResponseEntity.ok(response);
    }
}
