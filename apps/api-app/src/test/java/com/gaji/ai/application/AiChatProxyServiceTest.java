package com.gaji.ai.application;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.security.UserPrincipal;
import com.gaji.content.application.ContentReadFacade;
import com.gaji.shared.contract.dto.NovelResponse;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

class AiChatProxyServiceTest {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Test
    void completeChat_delegatesOperatorRagRequestWithNovelAuthorization() {
        UUID userId = UUID.randomUUID();
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(userId)
                .email("admin@gaji.app")
                .username("admin")
                .role("ADMIN")
                .build();
        AiChatCompletionRequest request = ragRequest(novelId);

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        AiChatCompletionService completionService = mock(AiChatCompletionService.class);
        when(completionService.complete(request, List.of(novelId.toString())))
                .thenReturn(answer("grounded"));

        AiChatProxyService service = service(completionService, contentReadFacade);

        JsonNode response = service.completeChat(principal, request);

        assertEquals("grounded", response.get("answer").asText());
        verify(contentReadFacade).getNovel(novelId);
        verify(completionService).complete(request, List.of(novelId.toString()));
    }

    @Test
    void completeConversationChat_allowsOwnerCheckedLearnerRagRequest() {
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();
        AiChatCompletionRequest request = ragRequest(novelId);

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        AiChatCompletionService completionService = mock(AiChatCompletionService.class);
        when(completionService.complete(request, List.of(novelId.toString())))
                .thenReturn(answer("grounded"));

        AiChatProxyService service = service(completionService, contentReadFacade);

        JsonNode response = service.completeConversationChat(principal, request);

        assertEquals("grounded", response.get("answer").asText());
        verify(contentReadFacade).getNovel(novelId);
        verify(completionService).complete(request, List.of(novelId.toString()));
    }

    @Test
    void lookupPassageSources_readsLocalRagPassagesForExactIds() {
        UUID novelId = UUID.randomUUID();
        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();

        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        when(contentReadFacade.getNovel(novelId)).thenReturn(NovelResponse.builder().id(novelId).build());

        AiChatCompletionService completionService = mock(AiChatCompletionService.class);
        when(completionService.lookupPassageSources(novelId, List.of("p1")))
                .thenReturn(objectMapper.createObjectNode()
                        .set("passages", objectMapper.createArrayNode()
                                .add(objectMapper.createObjectNode()
                                        .put("passage_id", "p1")
                                        .put("text", "source"))));

        AiChatProxyService service = service(completionService, contentReadFacade);

        JsonNode response = service.lookupPassageSources(principal, novelId, List.of("p1"));

        assertEquals("source", response.get("passages").get(0).get("text").asText());
        verify(contentReadFacade).getNovel(novelId);
        verify(completionService).lookupPassageSources(novelId, List.of("p1"));
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
        AiChatCompletionRequest request = ragRequest(novelId);
        ContentReadFacade contentReadFacade = mock(ContentReadFacade.class);
        AiChatProxyService service = service(mock(AiChatCompletionService.class), contentReadFacade);

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
        AiChatProxyService service = service(mock(AiChatCompletionService.class), mock(ContentReadFacade.class));

        assertThrows(
                BadRequestException.class,
                () -> service.completeChat(
                        UserPrincipal.builder().userId(UUID.randomUUID()).role("ADMIN").build(),
                        request
                )
        );
    }

    private AiChatProxyService service(
            AiChatCompletionService completionService,
            ContentReadFacade contentReadFacade
    ) {
        return new AiChatProxyService(
                objectMapper,
                completionService,
                contentReadFacade,
                new AiChatConcurrencyLimiter(10, 0)
        );
    }

    private AiChatCompletionRequest ragRequest(UUID novelId) {
        return new AiChatCompletionRequest(
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
    }

    private JsonNode answer(String answer) {
        return objectMapper.createObjectNode()
                .put("answer", answer)
                .put("provider", "spring")
                .put("model", "gemini-2.5-flash");
    }
}
