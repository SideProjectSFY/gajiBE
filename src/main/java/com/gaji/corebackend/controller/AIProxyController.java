package com.gaji.corebackend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

/**
 * AI Proxy Controller
 * 
 * Purpose: Proxy requests from frontend to FastAPI service
 * Pattern B Implementation:
 * - Frontend → Spring Boot (this controller) → FastAPI (internal)
 * - FastAPI URL never exposed to frontend
 * - Gemini API keys secured in FastAPI service
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/ai")
@RequiredArgsConstructor
@Tag(name = "AI Service", description = "AI 서비스 프록시 API (FastAPI 연동)")
public class AIProxyController {

    @Qualifier("fastApiClient")
    private final WebClient fastApiClient;

    // ==================== 명시적 엔드포인트 (Swagger 문서화) ====================

    @GetMapping("/health")
    @Operation(
        summary = "AI 서비스 헬스체크",
        description = "FastAPI AI 서비스의 상태를 확인합니다. Gemini API, VectorDB, Redis 연결 상태를 포함합니다."
    )
    @ApiResponse(responseCode = "200", description = "헬스체크 성공")
    public Mono<ResponseEntity<Object>> getHealth() {
        log.info("Proxying health check to FastAPI");
        return proxyGetRequest("/health");
    }

    @GetMapping("/characters")
    @Operation(
        summary = "캐릭터 목록 조회",
        description = "사용 가능한 모든 AI 캐릭터 목록을 반환합니다."
    )
    @ApiResponse(responseCode = "200", description = "캐릭터 목록 조회 성공")
    public Mono<ResponseEntity<Object>> getCharacters() {
        log.info("Proxying characters list to FastAPI");
        return proxyGetRequest("/api/ai/characters");
    }

    @GetMapping("/characters/info/{characterName}")
    @Operation(
        summary = "캐릭터 정보 조회",
        description = "특정 캐릭터의 상세 정보(페르소나, 말투, 배경 등)를 조회합니다."
    )
    @ApiResponse(responseCode = "200", description = "캐릭터 정보 조회 성공")
    @ApiResponse(responseCode = "404", description = "캐릭터를 찾을 수 없음")
    public Mono<ResponseEntity<Object>> getCharacterInfo(
            @Parameter(description = "캐릭터 이름", example = "Sherlock Holmes")
            @PathVariable String characterName,
            @Parameter(description = "책 제목 (같은 이름 캐릭터 구분용)", example = "The Adventures of Sherlock Holmes")
            @RequestParam(required = false) String bookTitle
    ) {
        log.info("Proxying character info to FastAPI: {}", characterName);
        String path = "/api/ai/characters/info/" + characterName;
        if (bookTitle != null && !bookTitle.isEmpty()) {
            path += "?book_title=" + bookTitle;
        }
        return proxyGetRequest(path);
    }

    @PostMapping("/conversations/{conversationId}/messages")
    @Operation(
        summary = "일반 캐릭터 대화",
        description = "책 속 인물과 실시간 대화를 진행합니다. Redis에 임시 저장됩니다. RAG + Gemini 2.5 Flash를 사용합니다."
    )
    @ApiResponse(responseCode = "200", description = "대화 응답 생성 성공")
    @ApiResponse(responseCode = "404", description = "캐릭터를 찾을 수 없음")
    public Mono<ResponseEntity<Object>> chatWithCharacter(
            @Parameter(description = "대화 ID (새 대화는 temp-{uuid} 형식 사용)", example = "temp-123")
            @PathVariable String conversationId,
            @io.swagger.v3.oas.annotations.parameters.RequestBody(
                description = "대화 요청",
                content = @Content(schema = @Schema(implementation = ChatRequestDto.class))
            )
            @RequestBody Map<String, Object> request
    ) {
        log.info("Proxying character chat request to FastAPI: conversationId={}", conversationId);
        String path = "/api/ai/conversations/" + conversationId + "/messages";
        return proxyPostRequest(path, request);
    }

    @PostMapping("/chat/scenarios/{scenarioId}")
    @Operation(
        summary = "시나리오 기반 대화",
        description = "What If 시나리오를 기반으로 캐릭터와 대화합니다. PostgreSQL에 영구 저장됩니다. JWT 인증이 필요합니다."
    )
    @ApiResponse(responseCode = "200", description = "대화 응답 생성 성공")
    @ApiResponse(responseCode = "401", description = "인증 실패")
    @ApiResponse(responseCode = "404", description = "시나리오를 찾을 수 없음")
    public Mono<ResponseEntity<Object>> chatWithScenario(
            @Parameter(description = "시나리오 ID", example = "550e8400-e29b-41d4-a716-446655440000")
            @PathVariable String scenarioId,
            @io.swagger.v3.oas.annotations.parameters.RequestBody(
                description = "대화 요청",
                content = @Content(schema = @Schema(implementation = ScenarioChatRequestDto.class))
            )
            @RequestBody Map<String, Object> request,
            @RequestHeader(value = "Authorization", required = false) String authorization
    ) {
        log.info("Proxying scenario chat request to FastAPI: scenarioId={}", scenarioId);
        String path = "/api/ai/chat/scenarios/" + scenarioId;
        return proxyPostRequest(path, request, authorization);
    }

    // ==================== 와일드카드 프록시 (기타 엔드포인트) ====================

    @GetMapping("/**")
    @Operation(hidden = true)  // Swagger에서 숨김
    public Mono<ResponseEntity<Object>> proxyGet(
            @RequestParam(required = false) Map<String, String> queryParams) {
        String path = extractPath();
        log.info("Proxying GET request to FastAPI: {}", path);
        
        return fastApiClient.get()
                .uri(uriBuilder -> {
                    uriBuilder.path(path);
                    if (queryParams != null && !queryParams.isEmpty()) {
                        queryParams.forEach(uriBuilder::queryParam);
                    }
                    return uriBuilder.build();
                })
                .retrieve()
                .toEntity(Object.class)
                .onErrorResume(this::handleError);
    }

    @PostMapping("/**")
    @Operation(hidden = true)  // Swagger에서 숨김
    public Mono<ResponseEntity<Object>> proxyPost(
            @RequestBody(required = false) Object body,
            @RequestHeader(value = "Authorization", required = false) String authorization) {
        String path = extractPath();
        log.info("Proxying POST request to FastAPI: {}", path);
        return proxyPostRequest(path, body, authorization);
    }

    @GetMapping(value = "/stream/**", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @Operation(hidden = true)  // Swagger에서 숨김
    public Flux<String> proxyStream() {
        String path = extractPath();
        log.info("Proxying stream request to FastAPI: {}", path);
        
        return fastApiClient.get()
                .uri(path)
                .retrieve()
                .bodyToFlux(String.class)
                .onErrorResume(Exception.class, ex -> {
                    log.error("Proxy stream error: {}", ex.getMessage());
                    return Flux.just("data: {\"error\": \"" + ex.getMessage() + "\"}\n\n");
                });
    }

    // ==================== 공통 헬퍼 메서드 ====================

    private Mono<ResponseEntity<Object>> proxyGetRequest(String path) {
        return fastApiClient.get()
                .uri(path)
                .retrieve()
                .toEntity(Object.class)
                .onErrorResume(this::handleError);
    }

    private Mono<ResponseEntity<Object>> proxyPostRequest(String path, Object body) {
        return proxyPostRequest(path, body, null);
    }

    private Mono<ResponseEntity<Object>> proxyPostRequest(String path, Object body, String authorization) {
        var requestSpec = fastApiClient.post()
                .uri(path)
                .bodyValue(body != null ? body : Map.of());
        
        if (authorization != null && !authorization.isEmpty()) {
            requestSpec = requestSpec.header("Authorization", authorization);
        }
        
        return requestSpec
                .retrieve()
                .toEntity(Object.class)
                .onErrorResume(this::handleError);
    }

    private Mono<ResponseEntity<Object>> handleError(Throwable ex) {
        if (ex instanceof WebClientResponseException wcex) {
            log.error("FastAPI error: {} - {}", wcex.getStatusCode(), wcex.getMessage());
            return Mono.just(ResponseEntity
                    .status(wcex.getStatusCode())
                    .body(Map.of(
                        "error", "FastAPI service error",
                        "message", wcex.getMessage()
                    )));
        }
        log.error("Proxy error: {}", ex.getMessage(), ex);
        return Mono.just(ResponseEntity
                .status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(Map.of(
                    "error", "FastAPI service unavailable",
                    "message", ex.getMessage()
                )));
    }

    private String extractPath() {
        String fullPath = org.springframework.web.servlet.HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE;
        String path = (String) org.springframework.web.context.request.RequestContextHolder
                .currentRequestAttributes()
                .getAttribute(fullPath, org.springframework.web.context.request.RequestAttributes.SCOPE_REQUEST);
        
        if (path != null && path.startsWith("/api/v1/ai")) {
            String subPath = path.substring("/api/v1/ai".length());
            if ("/health".equals(subPath)) {
                return "/health";
            }
            return "/api/ai" + subPath;
        }
        
        return "/health";
    }

    // ==================== Swagger 문서용 DTO ====================

    @Schema(description = "AI 대화 요청")
    public record ChatRequestDto(
        @Schema(description = "캐릭터 이름", example = "Elizabeth Bennet")
        String character_name,
        
        @Schema(description = "사용자 메시지", example = "안녕하세요, 자기소개 부탁드립니다")
        String message,
        
        @Schema(description = "책 제목", example = "Pride and Prejudice")
        String book_title,
        
        @Schema(description = "출력 언어", example = "ko")
        String output_language,
        
        @Schema(description = "대화 상대 유형", example = "stranger")
        String conversation_partner_type,
        
        @Schema(description = "이전 대화 기록")
        List<Map<String, String>> conversation_history
    ) {}

    @Schema(description = "시나리오 기반 대화 요청")
    public record ScenarioChatRequestDto(
        @Schema(description = "사용자 메시지", example = "안녕하세요, 자기소개 부탁드립니다")
        String message,
        
        @Schema(description = "대화 ID (기존 대화 이어가기용)", example = "550e8400-e29b-41d4-a716-446655440000")
        String conversation_id,
        
        @Schema(description = "대화 상대 유형", example = "stranger")
        String conversation_partner_type,
        
        @Schema(description = "다른 주인공 정보 (conversation_partner_type이 'other_main_character'일 때)")
        Map<String, Object> other_main_character
    ) {}
}
