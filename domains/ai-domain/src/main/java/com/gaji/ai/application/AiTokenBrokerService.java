package com.gaji.ai.application;

import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.security.JwtTokenProvider;
import com.gaji.common.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class AiTokenBrokerService {

    private static final Set<String> CHAT_SCOPES = Set.of("ai:chat:complete");
    private static final Set<String> RAG_SCOPES = Set.of("rag:read", "rag:debug", "rag:evaluate", "rag:index");
    private static final Set<String> PRIVILEGED_ROLES = Set.of("ADMIN", "DEVELOPER");

    private final JwtTokenProvider jwtTokenProvider;

    @Value("${gaji.ai.broker.audience:gaji-ai-direct}")
    private String audience;

    @Value("${gaji.ai.broker.scope:ai:chat:complete}")
    private String scope;

    @Value("${gaji.ai.broker.issuer:gaji-backend}")
    private String issuer;

    @Value("${gaji.ai.broker.ttl-seconds:180}")
    private int ttlSeconds;

    public BrokeredToken issue(UserPrincipal user, String model) {
        return issue(user, model, null);
    }

    public BrokeredToken issue(UserPrincipal user, String model, List<String> requestedScopes) {
        return issue(user, model, requestedScopes, List.of());
    }

    public BrokeredToken issue(
            UserPrincipal user,
            String model,
            List<String> requestedScopes,
            List<String> novelIds
    ) {
        return issueInternal(user, model, requestedScopes, novelIds, false);
    }

    public BrokeredToken issueBoundedRagRead(
            UserPrincipal user,
            String model,
            List<String> novelIds
    ) {
        return issueInternal(user, model, List.of("rag:read"), novelIds, true);
    }

    private BrokeredToken issueInternal(
            UserPrincipal user,
            String model,
            List<String> requestedScopes,
            List<String> novelIds,
            boolean allowBoundedRagRead
    ) {
        String requestId = MDC.get("correlationId");
        String safeModel = (model == null || model.isBlank()) ? "gemini-2.5-flash" : model.trim();
        List<String> safeNovelIds = sanitizeNovelIds(novelIds);
        String resolvedScope = resolveScope(user, requestedScopes, safeNovelIds, allowBoundedRagRead);

        String token = jwtTokenProvider.generateAiBrokerToken(
                user.getUserId(),
                user.getEmail(),
                user.getUsername(),
                audience,
                resolvedScope,
                issuer,
                requestId,
                safeModel,
                user.getRole(),
                ttlSeconds,
                safeNovelIds
        );

        return new BrokeredToken(token, "Bearer", ttlSeconds, audience, resolvedScope, safeModel, requestId);
    }

    private String resolveScope(
            UserPrincipal user,
            List<String> requestedScopes,
            List<String> novelIds,
            boolean allowBoundedRagRead
    ) {
        LinkedHashSet<String> scopes = new LinkedHashSet<>();
        if (requestedScopes == null || requestedScopes.isEmpty()) {
            scopes.addAll(parseScopes(scope));
        } else {
            for (String requestedScope : requestedScopes) {
                scopes.addAll(parseScopes(requestedScope));
            }
        }

        if (scopes.isEmpty()) {
            scopes.addAll(parseScopes(scope));
        }

        for (String requestedScope : scopes) {
            if (!CHAT_SCOPES.contains(requestedScope) && !RAG_SCOPES.contains(requestedScope)) {
                throw new BadRequestException("Unsupported AI broker scope: " + requestedScope);
            }
        }

        boolean requestsRagScope = scopes.stream().anyMatch(RAG_SCOPES::contains);
        boolean boundedLearnerRagRead = allowBoundedRagRead
                && scopes.size() == 1
                && scopes.contains("rag:read")
                && novelIds != null
                && !novelIds.isEmpty();
        if (requestsRagScope && !hasPrivilegedRole(user) && !boundedLearnerRagRead) {
            throw new ForbiddenException("RAG scopes require developer or admin role");
        }

        return String.join(" ", scopes);
    }

    private Set<String> parseScopes(String rawScopes) {
        LinkedHashSet<String> parsed = new LinkedHashSet<>();
        if (rawScopes == null || rawScopes.isBlank()) {
            return parsed;
        }
        for (String item : rawScopes.trim().split("[,\\s]+")) {
            if (!item.isBlank()) {
                parsed.add(item.trim());
            }
        }
        return parsed;
    }

    private boolean hasPrivilegedRole(UserPrincipal user) {
        if (user == null || user.getRole() == null) {
            return false;
        }
        return PRIVILEGED_ROLES.contains(user.getRole().trim().toUpperCase());
    }

    private List<String> sanitizeNovelIds(List<String> novelIds) {
        if (novelIds == null || novelIds.isEmpty()) {
            return List.of();
        }
        return novelIds.stream()
                .filter(novelId -> novelId != null && !novelId.isBlank())
                .map(String::trim)
                .distinct()
                .toList();
    }

    public record BrokeredToken(
            String accessToken,
            String tokenType,
            int expiresInSeconds,
            String audience,
            String scope,
            String model,
            String requestId
    ) {
    }
}
