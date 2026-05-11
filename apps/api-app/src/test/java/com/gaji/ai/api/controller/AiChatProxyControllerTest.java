package com.gaji.ai.api.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.ai.application.AiChatProxyService;
import com.gaji.common.exception.UnauthorizedException;
import com.gaji.common.security.UserPrincipal;
import org.junit.jupiter.api.Test;
import org.springframework.http.ResponseEntity;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AiChatProxyControllerTest {

    @Test
    void completeChat_requiresAuthenticatedUser() {
        AiChatProxyController controller = new AiChatProxyController(mock(AiChatProxyService.class));
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "hello",
                "gemini-2.5-flash",
                null,
                null,
                null,
                null
        );

        assertThrows(UnauthorizedException.class, () -> controller.completeChat(null, request));
    }

    @Test
    void completeChat_returnsFastApiPayload() throws Exception {
        AiChatProxyService service = mock(AiChatProxyService.class);
        AiChatProxyController controller = new AiChatProxyController(service);
        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .build();
        AiChatCompletionRequest request = new AiChatCompletionRequest(
                "hello",
                "gemini-2.5-flash",
                null,
                null,
                null,
                null
        );
        var payload = new ObjectMapper().readTree("{\"answer\":\"hello\"}");
        when(service.completeChat(principal, request)).thenReturn(payload);

        ResponseEntity<?> response = controller.completeChat(principal, request);

        assertEquals(200, response.getStatusCode().value());
        assertEquals(payload, response.getBody());
        verify(service).completeChat(principal, request);
    }
}
