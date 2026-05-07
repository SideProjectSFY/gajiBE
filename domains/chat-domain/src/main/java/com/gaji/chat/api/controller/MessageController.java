package com.gaji.chat.api.controller;

import com.gaji.shared.contract.dto.*;
import com.gaji.chat.application.MessageService;
import com.gaji.common.exception.UnauthorizedException;
import com.gaji.common.security.CurrentUser;
import com.gaji.common.security.UserPrincipal;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import java.util.List;
import java.util.UUID;

/**
 * 메시지 컨트롤러
 * 
 * 메시지 생성 및 AI 응답 폴링 엔드포인트
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/conversations/{conversationId}/messages")
@RequiredArgsConstructor
@Tag(name = "Messages", description = "Message submission and AI response polling APIs")
public class MessageController {

    private final MessageService messageService;

    /**
     * Get all messages in a conversation
     */
    @GetMapping
    @Operation(summary = "Get messages", description = "Get all messages in a conversation")
    @ApiResponse(responseCode = "200", description = "Messages retrieved successfully")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    public ResponseEntity<List<MessageResponse>> getMessages(
            @PathVariable UUID conversationId) {
        
        log.debug("Getting messages for conversation: {}", conversationId);
        
        List<MessageResponse> responses = messageService.getMessages(conversationId);
        
        return ResponseEntity.ok(responses);
    }

    /**
     * Submit user message and trigger AI generation
     * @deprecated Use direct AI endpoint /api/ai/generate instead
     */
    @Deprecated
    @PostMapping
    @Operation(summary = "Submit user message", description = "Saves user message and triggers AI generation via FastAPI")
    @ApiResponse(responseCode = "202", description = "Message accepted for processing")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    public ResponseEntity<MessageResponse> submitMessage(
            @PathVariable UUID conversationId,
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody CreateMessageRequest request) {

        log.info("Submitting message: conversationId={}, userId={}", conversationId, userId);

        MessageResponse response = messageService.submitMessage(conversationId, userId, request);

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(response);
    }

    /**
     * Submit a user message and synchronously generate a grounded RAG chat completion.
     */
    @PostMapping("/chat-completion")
    @Operation(summary = "Submit user message with RAG chat completion", description = "Saves the user message, generates a grounded assistant response through the canonical AI service, and saves the assistant message")
    @ApiResponse(responseCode = "200", description = "Message and grounded assistant response created")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    @ApiResponse(responseCode = "403", description = "Conversation access forbidden")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    public ResponseEntity<ConversationChatCompletionResponse> submitMessageWithChatCompletion(
            @PathVariable UUID conversationId,
            @CurrentUser UserPrincipal currentUser,
            @Valid @RequestBody CreateMessageRequest request) {

        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        log.info("Submitting RAG chat message: conversationId={}, userId={}",
                conversationId, currentUser.getUserId());

        ConversationChatCompletionResponse response = messageService.submitMessageWithChatCompletion(
                conversationId,
                currentUser,
                request
        );

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{assistantMessageId}/rag-sources")
    @Operation(summary = "Get RAG citation sources", description = "Returns source passages for citations attached to an assistant message without storing passage text in PostgreSQL")
    @ApiResponse(responseCode = "200", description = "RAG citation sources retrieved")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    @ApiResponse(responseCode = "403", description = "Conversation access forbidden")
    @ApiResponse(responseCode = "404", description = "RAG metadata or conversation not found")
    public ResponseEntity<RagChatSourceResponse> getRagSources(
            @PathVariable UUID conversationId,
            @PathVariable UUID assistantMessageId,
            @CurrentUser UserPrincipal currentUser) {

        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        RagChatSourceResponse response = messageService.getRagSources(
                conversationId,
                assistantMessageId,
                currentUser
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Poll for AI response status
     */
    @GetMapping("/poll")
    @Operation(summary = "Poll for AI response", description = "Check AI generation status and retrieve result when completed")
    @ApiResponse(responseCode = "200", description = "Poll result retrieved")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    public ResponseEntity<PollResponse> pollResponse(
            @PathVariable UUID conversationId) {

        log.debug("Polling conversation: id={}", conversationId);

        PollResponse response = messageService.pollResponse(conversationId);

        return ResponseEntity.ok(response);
    }
}
