package com.gaji.ai.api.controller;

import com.gaji.ai.application.AiTokenBrokerService;
import com.gaji.common.exception.UnauthorizedException;
import com.gaji.common.security.CurrentUser;
import com.gaji.common.security.UserPrincipal;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/ai-token")
@Tag(name = "AI Token Broker", description = "Issue scoped short-lived token for direct AI calls")
public class AiTokenController {

    private static final Logger log = LoggerFactory.getLogger(AiTokenController.class);

    private final AiTokenBrokerService aiTokenBrokerService;

    public AiTokenController(AiTokenBrokerService aiTokenBrokerService) {
        this.aiTokenBrokerService = aiTokenBrokerService;
    }

    @PostMapping
    @Operation(summary = "Issue brokered AI token for authenticated user")
    public ResponseEntity<AiTokenBrokerService.BrokeredToken> issueToken(
            @CurrentUser UserPrincipal currentUser,
            @Valid @RequestBody(required = false) IssueAiTokenRequest request
    ) {
        if (currentUser == null || currentUser.getUserId() == null) {
            throw new UnauthorizedException("Authentication required");
        }

        String requestedModel = request == null ? null : request.model();
        List<String> requestedScopes = request == null ? null : request.requestedScopes();
        List<String> requestedNovelIds = request == null ? null : request.novelIds();
        AiTokenBrokerService.BrokeredToken token = aiTokenBrokerService.issue(
                currentUser,
                requestedModel,
                requestedScopes,
                requestedNovelIds
        );

        log.info("ai_token_issued request_id={} user_id={} model={} token_usage={}",
                token.requestId(), currentUser.getUserId(), token.model(), 0);
        return ResponseEntity.ok(token);
    }

    public record IssueAiTokenRequest(String model, String scope, List<String> scopes, List<String> novelIds) {
        public IssueAiTokenRequest(String model) {
            this(model, null, null, null);
        }

        public IssueAiTokenRequest(String model, List<String> scopes) {
            this(model, null, scopes, null);
        }

        public List<String> requestedScopes() {
            if (scopes != null && !scopes.isEmpty()) {
                return scopes;
            }
            if (scope != null && !scope.isBlank()) {
                return List.of(scope);
            }
            return null;
        }
    }
}
