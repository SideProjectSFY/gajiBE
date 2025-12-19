package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.service.MessageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
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
     * Submit user message and trigger AI generation
     */
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
