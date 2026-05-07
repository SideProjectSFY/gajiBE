package com.gaji.ai.api.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.ai.application.AiChatProxyService;
import com.gaji.common.exception.UnauthorizedException;
import com.gaji.common.security.CurrentUser;
import com.gaji.common.security.UserPrincipal;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/ai")
@Tag(name = "AI Chat Proxy", description = "Proxy learner chat requests to the internal FastAPI AI service")
public class AiChatProxyController {

    private static final Logger log = LoggerFactory.getLogger(AiChatProxyController.class);

    private final AiChatProxyService aiChatProxyService;

    public AiChatProxyController(AiChatProxyService aiChatProxyService) {
        this.aiChatProxyService = aiChatProxyService;
    }

    @PostMapping("/chat/completions")
    @Operation(summary = "Generate an AI chat completion, optionally with Hybrid RAG grounding")
    public ResponseEntity<JsonNode> completeChat(
            @CurrentUser UserPrincipal currentUser,
            @Valid @RequestBody AiChatCompletionRequest request
    ) {
        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        JsonNode response = aiChatProxyService.completeChat(currentUser, request);
        log.info(
                "ai_chat_completion_proxied user_id={} model={} rag_enabled={}",
                currentUser.getUserId(),
                request.resolvedModel(),
                request.rag() != null && request.rag().isEnabled()
        );
        return ResponseEntity.ok(response);
    }
}
