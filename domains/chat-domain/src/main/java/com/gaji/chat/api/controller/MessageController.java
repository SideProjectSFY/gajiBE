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
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import jakarta.validation.Valid;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicBoolean;

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
    private final AsyncTaskExecutor applicationTaskExecutor;

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

    @GetMapping("/search")
    @Operation(summary = "Search messages in a conversation", description = "Searches message text in one conversation owned by the authenticated user")
    @ApiResponse(responseCode = "200", description = "Messages searched successfully")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    @ApiResponse(responseCode = "403", description = "Conversation access forbidden")
    @ApiResponse(responseCode = "404", description = "Conversation not found")
    public ResponseEntity<List<MessageSearchResponse>> searchConversationMessages(
            @PathVariable UUID conversationId,
            @CurrentUser UserPrincipal currentUser,
            @RequestParam("query") String query,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        log.debug("Searching conversation messages: conversationId={}, userId={}, query={}, page={}, size={}",
                conversationId, currentUser.getUserId(), query, page, size);

        List<MessageSearchResponse> responses = messageService.searchOwnedMessagesInConversation(
                conversationId,
                currentUser,
                query,
                page,
                size
        );

        return ResponseEntity.ok(responses);
    }

    @DeleteMapping("/{messageId}")
    @Operation(summary = "Delete a message", description = "Deletes one message from a conversation owned by the authenticated user")
    @ApiResponse(responseCode = "204", description = "Message deleted successfully")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    @ApiResponse(responseCode = "403", description = "Conversation access forbidden")
    @ApiResponse(responseCode = "404", description = "Conversation or message not found")
    public ResponseEntity<Void> deleteMessage(
            @PathVariable UUID conversationId,
            @PathVariable UUID messageId,
            @CurrentUser UserPrincipal currentUser) {

        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        log.info("Deleting message: conversationId={}, messageId={}, userId={}",
                conversationId, messageId, currentUser.getUserId());

        messageService.deleteMessage(conversationId, messageId, currentUser);
        return ResponseEntity.noContent().build();
    }

    /**
     * Submit user message without generating an assistant response.
     * @deprecated Use /chat-completion for Spring pgvector/Elasticsearch RAG generation.
     */
    @Deprecated
    @PostMapping
    @Operation(summary = "Submit user message", description = "Saves a user message without triggering legacy async AI generation")
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
    @Operation(summary = "Submit user message with RAG chat completion", description = "Saves the user message, generates a grounded assistant response through Spring RAG, and saves the assistant message")
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

    /**
     * Submit a user message and deliver chat completion result over SSE.
     */
    @PostMapping(value = "/chat-completion/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(summary = "Stream RAG chat completion status", description = "Returns immediately with an SSE stream and emits completion metadata when the assistant turn is saved")
    @ApiResponse(responseCode = "200", description = "SSE stream opened")
    @ApiResponse(responseCode = "401", description = "User not authenticated")
    public SseEmitter streamMessageWithChatCompletion(
            @PathVariable UUID conversationId,
            @CurrentUser UserPrincipal currentUser,
            @Valid @RequestBody CreateMessageRequest request) {

        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        SseEmitter emitter = new SseEmitter(120_000L);
        AtomicBoolean streamOpen = new AtomicBoolean(true);
        emitter.onCompletion(() -> streamOpen.set(false));
        emitter.onTimeout(() -> streamOpen.set(false));
        emitter.onError(_error -> streamOpen.set(false));

        if (!sendSseEvent(emitter, "accepted", Map.of(
                "status", "accepted",
                "conversationId", conversationId.toString()
        ))) {
            streamOpen.set(false);
            return emitter;
        }

        applicationTaskExecutor.execute(() -> {
            try {
                messageService.submitMessageWithChatCompletionStream(
                        conversationId,
                        currentUser,
                        request,
                        event -> {
                            if (!streamOpen.get()) {
                                throw new SseClientDisconnectedException();
                            }
                            if (!sendSseEvent(emitter, event.eventName(), event.data())) {
                                streamOpen.set(false);
                                throw new SseClientDisconnectedException();
                            }
                        }
                );
                completeEmitter(emitter, streamOpen);
            } catch (SseClientDisconnectedException ex) {
                log.debug("Streaming RAG chat client disconnected: conversationId={}, userId={}",
                        conversationId, currentUser.getUserId());
                streamOpen.set(false);
            } catch (Exception ex) {
                log.warn("Streaming RAG chat completion failed: conversationId={}, userId={}",
                        conversationId, currentUser.getUserId(), ex);
                if (streamOpen.get()) {
                    sendSseEvent(emitter, "error", Map.of(
                            "status", "error",
                            "message", safeStreamingErrorMessage(ex)
                    ));
                }
                completeEmitter(emitter, streamOpen);
            }
        });

        return emitter;
    }

    private boolean sendSseEvent(SseEmitter emitter, String eventName, Object data) {
        try {
            emitter.send(SseEmitter.event().name(eventName).data(data));
            return true;
        } catch (IOException ex) {
            emitter.completeWithError(ex);
            return false;
        }
    }

    private void completeEmitter(SseEmitter emitter, AtomicBoolean streamOpen) {
        if (streamOpen.getAndSet(false)) {
            emitter.complete();
        }
    }

    private String safeStreamingErrorMessage(Exception ex) {
        String message = ex.getMessage();
        return message == null || message.isBlank()
                ? "AI chat completion failed. Please retry shortly."
                : message;
    }

    private static class SseClientDisconnectedException extends RuntimeException {
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
