package com.gaji.ai.interfaces.rest;

import com.gaji.ai.api.controller.AiTokenController;
import com.gaji.ai.application.AiTokenBrokerService;
import com.gaji.common.exception.UnauthorizedException;
import com.gaji.common.security.UserPrincipal;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class AiTokenControllerTest {

    @Test
    void issueToken_returnsUnauthorizedWhenNoAuthenticatedUser() {
        AiTokenBrokerService brokerService = mock(AiTokenBrokerService.class);
        AiTokenController controller = new AiTokenController(brokerService);

        assertThrows(UnauthorizedException.class, () -> controller.issueToken(null, null));
    }

    @Test
    void issueToken_returnsBrokeredTokenPayload() {
        AiTokenBrokerService brokerService = mock(AiTokenBrokerService.class);
        AiTokenController controller = new AiTokenController(brokerService);

        UserPrincipal principal = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("qa@gaji.app")
                .username("qa-user")
                .build();

        AiTokenBrokerService.BrokeredToken brokeredToken = new AiTokenBrokerService.BrokeredToken(
                "token-value",
                "Bearer",
                180,
                "gaji-ai-direct",
                "ai:chat:complete",
                "gemini-2.5-flash",
                "req-1"
        );

        when(brokerService.issue(
                principal,
                "gemini-2.5-flash",
                List.of("ai:chat:complete"),
                null
        )).thenReturn(brokeredToken);

        var response = controller.issueToken(
                principal,
                new AiTokenController.IssueAiTokenRequest("gemini-2.5-flash", List.of("ai:chat:complete"))
        );

        assertEquals(200, response.getStatusCode().value());
        assertEquals("token-value", response.getBody().accessToken());
        assertEquals("ai:chat:complete", response.getBody().scope());
    }
}
