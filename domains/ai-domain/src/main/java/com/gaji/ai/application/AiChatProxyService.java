package com.gaji.ai.application;

import com.fasterxml.jackson.databind.JsonNode;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.exception.ResourceNotFoundException;
import com.gaji.common.security.UserPrincipal;
import com.gaji.content.application.ContentReadFacade;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Flux;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class AiChatProxyService {

    private static final ParameterizedTypeReference<ServerSentEvent<JsonNode>> JSON_SSE_TYPE =
            new ParameterizedTypeReference<>() {
            };

    private final WebClient fastApiClient;
    private final AiTokenBrokerService aiTokenBrokerService;
    private final ContentReadFacade contentReadFacade;
    private final AiChatConcurrencyLimiter aiChatConcurrencyLimiter;

    public AiChatProxyService(
            @Qualifier("fastApiClient") WebClient fastApiClient,
            AiTokenBrokerService aiTokenBrokerService,
            ContentReadFacade contentReadFacade,
            AiChatConcurrencyLimiter aiChatConcurrencyLimiter
    ) {
        this.fastApiClient = fastApiClient;
        this.aiTokenBrokerService = aiTokenBrokerService;
        this.contentReadFacade = contentReadFacade;
        this.aiChatConcurrencyLimiter = aiChatConcurrencyLimiter;
    }

    public JsonNode completeChat(UserPrincipal currentUser, AiChatCompletionRequest request) {
        List<String> novelIds = resolveAuthorizedNovelIds(currentUser, request, false);
        return forwardCompletion(currentUser, request, novelIds);
    }

    public JsonNode completeConversationChat(UserPrincipal currentUser, AiChatCompletionRequest request) {
        List<String> novelIds = resolveAuthorizedNovelIds(currentUser, request, true);
        return forwardCompletion(currentUser, request, novelIds);
    }

    public Flux<ServerSentEvent<JsonNode>> streamConversationChat(
            UserPrincipal currentUser,
            AiChatCompletionRequest request
    ) {
        List<String> novelIds = resolveAuthorizedNovelIds(currentUser, request, true);
        AiTokenBrokerService.BrokeredToken brokeredToken = aiTokenBrokerService.issue(
                currentUser,
                request.resolvedModel(),
                List.of("ai:chat:complete"),
                novelIds
        );

        return aiChatConcurrencyLimiter.executeFlux(() -> fastApiClient.post()
                .uri("/v1/chat/completions/stream")
                .accept(MediaType.TEXT_EVENT_STREAM)
                .headers(headers -> headers.setBearerAuth(brokeredToken.accessToken()))
                .bodyValue(request)
                .retrieve()
                .bodyToFlux(JSON_SSE_TYPE));
    }

    public JsonNode lookupPassageSources(UserPrincipal currentUser, UUID novelId, List<String> passageIds) {
        if (novelId == null) {
            throw new BadRequestException("novelId is required for RAG source lookup");
        }
        if (passageIds == null || passageIds.isEmpty()) {
            throw new BadRequestException("passageIds are required for RAG source lookup");
        }

        try {
            contentReadFacade.getNovel(novelId);
        } catch (IllegalArgumentException ex) {
            throw new ResourceNotFoundException("Novel not found: " + novelId, ex);
        }

        AiTokenBrokerService.BrokeredToken brokeredToken = aiTokenBrokerService.issueBoundedRagRead(
                currentUser,
                "gemini-2.5-flash",
                List.of(novelId.toString())
        );

        return fastApiClient.post()
                .uri("/v1/rag/sources/passages")
                .headers(headers -> headers.setBearerAuth(brokeredToken.accessToken()))
                .bodyValue(Map.of(
                        "novel_id", novelId.toString(),
                        "passage_ids", passageIds
                ))
                .retrieve()
                .bodyToMono(JsonNode.class)
                .block();
    }

    private JsonNode forwardCompletion(
            UserPrincipal currentUser,
            AiChatCompletionRequest request,
            List<String> novelIds
    ) {
        AiTokenBrokerService.BrokeredToken brokeredToken = aiTokenBrokerService.issue(
                currentUser,
                request.resolvedModel(),
                List.of("ai:chat:complete"),
                novelIds
        );

        return aiChatConcurrencyLimiter.execute(() -> fastApiClient.post()
                .uri("/v1/chat/completions")
                .headers(headers -> headers.setBearerAuth(brokeredToken.accessToken()))
                .bodyValue(request)
                .retrieve()
                .bodyToMono(JsonNode.class)
                .block());
    }

    private List<String> resolveAuthorizedNovelIds(
            UserPrincipal currentUser,
            AiChatCompletionRequest request,
            boolean allowOwnedConversationRag
    ) {
        AiChatCompletionRequest.RagOptions ragOptions = request.rag();
        if (ragOptions == null || !ragOptions.isEnabled()) {
            return List.of();
        }
        if (!allowOwnedConversationRag && !isOperator(currentUser)) {
            throw new ForbiddenException("Direct RAG chat requires developer or admin role");
        }
        if (ragOptions.novelId() == null || ragOptions.novelId().isBlank()) {
            throw new BadRequestException("rag.novelId is required when rag.enabled=true");
        }

        UUID novelId = parseNovelId(ragOptions.novelId());
        try {
            contentReadFacade.getNovel(novelId);
        } catch (IllegalArgumentException ex) {
            throw new ResourceNotFoundException("Novel not found: " + novelId, ex);
        }
        return List.of(novelId.toString());
    }

    private UUID parseNovelId(String rawNovelId) {
        try {
            return UUID.fromString(rawNovelId.trim());
        } catch (IllegalArgumentException ex) {
            throw new BadRequestException("rag.novelId must be a valid UUID");
        }
    }

    private boolean isOperator(UserPrincipal user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        String role = user.getRole().trim().toUpperCase();
        return "ADMIN".equals(role) || "DEVELOPER".equals(role);
    }
}
