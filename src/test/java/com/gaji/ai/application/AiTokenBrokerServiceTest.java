package com.gaji.ai.application;

import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.security.JwtTokenProvider;
import com.gaji.common.security.UserPrincipal;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class AiTokenBrokerServiceTest {

    private AiTokenBrokerService service;
    private JwtTokenProvider provider;

    @BeforeEach
    void setUp() {
        provider = new JwtTokenProvider("test-secret-key-minimum-32-chars-required-for-hs256");
        service = new AiTokenBrokerService(provider);
        ReflectionTestUtils.setField(service, "audience", "gaji-ai-direct");
        ReflectionTestUtils.setField(service, "scope", "ai:chat:complete");
        ReflectionTestUtils.setField(service, "issuer", "gaji-backend");
        ReflectionTestUtils.setField(service, "ttlSeconds", 180);
    }

    @Test
    void issue_returnsShortLivedBearerToken() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("test@gaji.app")
                .username("tester")
                .build();

        AiTokenBrokerService.BrokeredToken token = service.issue(user, "gemini-2.5-flash");

        assertNotNull(token.accessToken());
        assertTrue(token.accessToken().split("\\.").length >= 3);
        assertEquals("Bearer", token.tokenType());
        assertEquals(180, token.expiresInSeconds());
        assertEquals("gaji-ai-direct", token.audience());
        assertEquals("ai:chat:complete", token.scope());
        assertEquals("gemini-2.5-flash", token.model());
    }

    @Test
    void issue_allowsRagScopesForAdminUser() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("admin@gaji.app")
                .username("admin")
                .role("ADMIN")
                .build();

        AiTokenBrokerService.BrokeredToken token = service.issue(
                user,
                "gemini-2.5-flash",
                List.of("rag:read", "rag:index", "rag:evaluate", "rag:debug")
        );

        assertEquals("rag:read rag:index rag:evaluate rag:debug", token.scope());
        assertEquals("ADMIN", provider.getRoleFromToken(token.accessToken()));
    }

    @Test
    void issue_includesNovelIdsWhenProvided() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();
        String novelId = UUID.randomUUID().toString();

        AiTokenBrokerService.BrokeredToken token = service.issue(
                user,
                "gemini-2.5-flash",
                List.of("ai:chat:complete"),
                List.of(novelId)
        );

        assertEquals(List.of(novelId), provider.getNovelIdsFromToken(token.accessToken()));
    }

    @Test
    void issue_rejectsPublicRagScopesForRegularUser() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("user@gaji.app")
                .username("user")
                .role("USER")
                .build();

        assertThrows(
                ForbiddenException.class,
                () -> service.issue(user, "gemini-2.5-flash", List.of("rag:read"))
        );
    }

    @Test
    void issueBoundedRagRead_allowsRegularUserWithNovelClaim() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();
        String novelId = UUID.randomUUID().toString();

        AiTokenBrokerService.BrokeredToken token = service.issueBoundedRagRead(
                user,
                "gemini-2.5-flash",
                List.of(novelId)
        );

        assertEquals("rag:read", token.scope());
        assertEquals(List.of(novelId), provider.getNovelIdsFromToken(token.accessToken()));
    }

    @Test
    void issueBoundedRagRead_rejectsRegularUserWithoutNovelClaim() {
        UserPrincipal user = UserPrincipal.builder()
                .userId(UUID.randomUUID())
                .email("reader@gaji.app")
                .username("reader")
                .role("USER")
                .build();

        assertThrows(
                ForbiddenException.class,
                () -> service.issueBoundedRagRead(user, "gemini-2.5-flash", List.of())
        );
    }
}
