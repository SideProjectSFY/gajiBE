package com.gaji.ai.application;

import com.fasterxml.jackson.databind.JsonNode;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.security.UserPrincipal;
import com.gaji.content.application.ContentReadFacade;
import com.gaji.shared.contract.dto.NovelResponse;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AiChatProxyServiceTest {

    @Test
    void completeChat_forwardsOperatorRagRequestWithBrokerTokenAndNovelClaim() {
        UUID userId = UUID.randomUUID();
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(userId)
                .email("admin@gaji.app")
                .username("admin")
                .role("ADMIN")
                .build();
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "Elizabeth Bennet Darcy assembly",
                "gemini-2.5-flash",
                0.2,
                128,
                0,
                new AiChatCompletionRequest.RagOptions(
                        true,
                        novelId.toString(),
                        "Elizabeth Darcy assembly",
                        "hybrid",
                        3,
                        2,
                        null,
                        null,
                        null,
                        true
                )
        );

        AiTokenBrokerService brokerService = mock(AiTokenBrokerService.class);
        when(brokerService.issue(
                principal,
                "gemini-2.5-flash",
                List.of("ai:chat:complete"),
                List.of(novelId.toString())
        )).thenReturn(new AiTokenBrokerService.BrokeredToken(
                "broker-token",
                "Bearer",
                180,
                "gaji-ai-direct",
                "ai:chat:complete",
                "gemini-2.5-flash",
                "req-1"
        ));

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        AtomicReference<String> observedAuthorization = new AtomicReference<>();
        WebClient fastApiClient = WebClient.builder()
                .baseUrl("http://fastapi")
                .exchangeFunction(clientRequest -> {
                    observedAuthorization.set(clientRequest.headers().getFirst(HttpHeaders.AUTHORIZATION));
                    assertEquals("/v1/chat/completions", clientRequest.url().getPath());
                    return Mono.just(ClientResponse.create(HttpStatus.OK)
                            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                            .body("{\"answer\":\"grounded\",\"rag\":{\"grounding_status\":\"grounded\",\"citations\":[]}}")
                            .build());
                })
                .build();

        AiChatProxyService service = new AiChatProxyService(
                fastApiClient,
                brokerService,
                contentReadFacade,
                new AiChatConcurrencyLimiter(10, 0)
        );

        JsonNode response = service.completeChat(principal, request);

        assertEquals("grounded", response.get("answer").asText());
        assertEquals("Bearer broker-token", observedAuthorization.get());
        verify(contentReadFacade).getNovel(novelId);
    }

    @Test
    void completeConversationChat_allowsOwnerCheckedLearnerRagRequest() {
        UUID userId = UUID.randomUUID();
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(userId)
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "Conversation context\n\nUser message\nElizabeth Bennet Darcy assembly",
                "gemini-2.5-flash",
                0.2,
                128,
                0,
                new AiChatCompletionRequest.RagOptions(
                        true,
                        novelId.toString(),
                        "Elizabeth Darcy assembly",
                        "hybrid",
                        3,
                        2,
                        null,
                        null,
                        null,
                        true
                )
        );

        AiTokenBrokerService brokerService = mock(AiTokenBrokerService.class);
        when(brokerService.issue(
                principal,
                "gemini-2.5-flash",
                List.of("ai:chat:complete"),
                List.of(novelId.toString())
        )).thenReturn(new AiTokenBrokerService.BrokeredToken(
                "broker-token",
                "Bearer",
                180,
                "gaji-ai-direct",
                "ai:chat:complete",
                "gemini-2.5-flash",
                "req-1"
        ));

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        WebClient fastApiClient = WebClient.builder()
                .baseUrl("http://fastapi")
                .exchangeFunction(clientRequest -> Mono.just(ClientResponse.create(HttpStatus.OK)
                        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                        .body("{\"answer\":\"grounded\",\"rag\":{\"grounding_status\":\"grounded\",\"citations\":[]}}")
                        .build()))
                .build();

        AiChatProxyService service = new AiChatProxyService(
                fastApiClient,
                brokerService,
                contentReadFacade,
                new AiChatConcurrencyLimiter(10, 0)
        );

        JsonNode response = service.completeConversationChat(principal, request);

        assertEquals("grounded", response.get("answer").asText());
        verify(contentReadFacade).getNovel(novelId);
    }

    @Test
    void lookupPassageSources_usesBoundedRagReadTokenAndForwardsExactIds() {
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();

        AiTokenBrokerService brokerService = mock(AiTokenBrokerService.class);
        when(brokerService.issueBoundedRagRead(
                principal,
                "gemini-2.5-flash",
                List.of(novelId.toString())
        )).thenReturn(new AiTokenBrokerService.BrokeredToken(
                "broker-token",
                "Bearer",
                180,
                "gaji-ai-direct",
                "rag:read",
                "gemini-2.5-flash",
                "req-1"
        ));

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        AtomicReference<String> observedAuthorization = new AtomicReference<>();
        WebClient fastApiClient = WebClient.builder()
                .baseUrl("http://fastapi")
                .exchangeFunction(clientRequest -> {
                    observedAuthorization.set(clientRequest.headers().getFirst(HttpHeaders.AUTHORIZATION));
                    assertEquals("/v1/rag/sources/passages", clientRequest.url().getPath());
                    return Mono.just(ClientResponse.create(HttpStatus.OK)
                            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                            .body("{\"passages\":[{\"passage_id\":\"p1\",\"text\":\"source\"}],\"missing_passage_ids\":[]}")
                            .build());
                })
                .build();

        AiChatProxyService service = new AiChatProxyService(
                fastApiClient,
                brokerService,
                contentReadFacade,
                new AiChatConcurrencyLimiter(10, 0)
        );

        JsonNode response = service.lookupPassageSources(principal, novelId, List.of("p1"));

        assertEquals("source", response.get("passages").get(0).get("text").asText());
        assertEquals("Bearer broker-token", observedAuthorization.get());
        verify(contentReadFacade).getNovel(novelId);
    }

    @Test
    void completeChat_rejectsNonOperatorDirectRagRequest() {
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "Elizabeth Bennet Darcy assembly",
                "gemini-2.5-flash",
                0.2,
                128,
                0,
                new AiChatCompletionRequest.RagOptions(
                        true,
                        novelId.toString(),
                        "Elizabeth Darcy assembly",
                        "hybrid",
                        3,
                        2,
                        null,
                        null,
                        null,
                        true
                )
        );
        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        AiChatProxyService service = new AiChatProxyService(
                WebClient.builder().baseUrl("http://fastapi").build(),
                mock(AiTokenBrokerService.class),
                contentReadFacade,
                new AiChatConcurrencyLimiter(10, 0)
        );

        assertThrows(ForbiddenException.class, () -> service.completeChat(principal, request));
        verifyNoInteractions(contentReadFacade);
    }

    @Test
    void completeChat_requiresNovelIdWhenRagEnabled() {
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "hello",
                "gemini-2.5-flash",
                null,
                null,
                null,
                new AiChatCompletionRequest.RagOptions(true, null, null, null, null, null, null, null, null, null)
        );
        AiChatProxyService service = new AiChatProxyService(
                WebClient.builder().baseUrl("http://fastapi").build(),
                mock(AiTokenBrokerService.class),
                mock(ContentReadFacade.class),
                new AiChatConcurrencyLimiter(10, 0)
        );

        assertThrows(
                BadRequestException.class,
                () -> service.completeChat(
                        UserPrincipal.builder().userId(UUID.randomUUID()).role("ADMIN").build(),
                        request
                )
        );
    }
}
