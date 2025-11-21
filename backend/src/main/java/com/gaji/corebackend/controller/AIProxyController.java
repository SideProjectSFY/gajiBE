package com.gaji.corebackend.controller;

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

import java.util.Map;

/**
 * AI Proxy Controller
 * 
 * Purpose: Proxy requests from frontend to FastAPI service
 * Pattern B Implementation:
 * - Frontend → Spring Boot (this controller) → FastAPI (internal)
 * - FastAPI URL never exposed to frontend
 * - Gemini API keys secured in FastAPI service
 * 
 * Routes:
 * - /api/v1/ai/* → http://localhost:8000/api/*
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/ai")
@RequiredArgsConstructor
public class AIProxyController {

    @Qualifier("fastApiClient")
    private final WebClient fastApiClient;

    /**
     * Proxy GET requests to FastAPI
     * Example: GET /api/v1/ai/health → http://localhost:8000/api/health
     */
    @GetMapping("/**")
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
                .onErrorResume(WebClientResponseException.class, ex -> {
                    log.error("FastAPI GET error: {} - {}", ex.getStatusCode(), ex.getMessage());
                    return Mono.just(ResponseEntity
                            .status(ex.getStatusCode())
                            .body(Map.of(
                                "error", "FastAPI service error",
                                "message", ex.getMessage()
                            )));
                })
                .onErrorResume(Exception.class, ex -> {
                    log.error("Proxy GET error: {}", ex.getMessage());
                    return Mono.just(ResponseEntity
                            .status(HttpStatus.SERVICE_UNAVAILABLE)
                            .body(Map.of(
                                "error", "FastAPI service unavailable",
                                "message", ex.getMessage()
                            )));
                });
    }

    /**
     * Proxy POST requests to FastAPI
     * Example: POST /api/v1/ai/chat → http://localhost:8000/api/chat
     */
    @PostMapping("/**")
    public Mono<ResponseEntity<Object>> proxyPost(@RequestBody(required = false) Object body) {
        String path = extractPath();
        log.info("Proxying POST request to FastAPI: {}", path);
        
        return fastApiClient.post()
                .uri(path)
                .bodyValue(body != null ? body : Map.of())
                .retrieve()
                .toEntity(Object.class)
                .onErrorResume(WebClientResponseException.class, ex -> {
                    log.error("FastAPI POST error: {} - {}", ex.getStatusCode(), ex.getMessage());
                    return Mono.just(ResponseEntity
                            .status(ex.getStatusCode())
                            .body(Map.of(
                                "error", "FastAPI service error",
                                "message", ex.getMessage()
                            )));
                })
                .onErrorResume(Exception.class, ex -> {
                    log.error("Proxy POST error: {}", ex.getMessage());
                    return Mono.just(ResponseEntity
                            .status(HttpStatus.SERVICE_UNAVAILABLE)
                            .body(Map.of(
                                "error", "FastAPI service unavailable",
                                "message", ex.getMessage()
                            )));
                });
    }

    /**
     * Proxy streaming responses from FastAPI
     * Example: GET /api/v1/ai/chat/stream → http://localhost:8000/api/chat/stream
     */
    @GetMapping(value = "/stream/**", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> proxyStream() {
        String path = extractPath().replace("/stream", "/stream");
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

    /**
     * Extract the path after /api/v1/ai/
     * /api/v1/ai/health → /api/health
     * /api/v1/ai/chat/123 → /api/chat/123
     */
    private String extractPath() {
        String fullPath = org.springframework.web.servlet.HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE;
        String path = (String) org.springframework.web.context.request.RequestContextHolder
                .currentRequestAttributes()
                .getAttribute(fullPath, org.springframework.web.context.request.RequestAttributes.SCOPE_REQUEST);
        
        if (path != null && path.startsWith("/api/v1/ai")) {
            return "/api" + path.substring("/api/v1/ai".length());
        }
        
        return "/api";
    }
}
