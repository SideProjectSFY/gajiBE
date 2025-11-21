package com.gaji.corebackend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.HashMap;
import java.util.Map;

/**
 * Health Check Controller
 * 
 * Provides health status for Spring Boot + FastAPI services
 * Endpoint: GET /actuator/health
 */
@Slf4j
@RestController
@RequestMapping("/actuator")
@RequiredArgsConstructor
@Tag(name = "Health", description = "Health check endpoints")
public class HealthCheckController {

    @Qualifier("fastApiClient")
    private final WebClient fastApiClient;

    @GetMapping("/health")
    @Operation(summary = "Health check", description = "Check health of Spring Boot and FastAPI services")
    public ResponseEntity<Map<String, Object>> health() {
        Map<String, Object> health = new HashMap<>();
        
        // Spring Boot status
        health.put("status", "UP");
        
        Map<String, Object> components = new HashMap<>();
        
        // Spring Boot component
        Map<String, String> springBoot = new HashMap<>();
        springBoot.put("status", "UP");
        components.put("springboot", springBoot);
        
        // Database component (will be implemented in Story 0.3)
        Map<String, String> db = new HashMap<>();
        db.put("status", "NOT_CONFIGURED");
        db.put("note", "Database configuration pending - Story 0.3");
        components.put("db", db);
        
        // FastAPI health check
        Map<String, String> fastapi = new HashMap<>();
        try {
            String fastapiStatus = fastApiClient.get()
                    .uri("/api/health")
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
            
            fastapi.put("status", "UP");
            fastapi.put("response", fastapiStatus != null ? fastapiStatus : "OK");
            log.info("FastAPI health check: UP");
        } catch (Exception e) {
            fastapi.put("status", "DOWN");
            fastapi.put("error", e.getMessage());
            fastapi.put("note", "FastAPI service not available (expected if not running)");
            log.warn("FastAPI health check failed: {}", e.getMessage());
            
            // Don't fail overall health if FastAPI is down (it's optional for now)
        }
        components.put("fastapi", fastapi);
        
        health.put("components", components);
        
        return ResponseEntity.ok(health);
    }

    @GetMapping("/health/live")
    @Operation(summary = "Liveness probe", description = "Kubernetes liveness probe")
    public ResponseEntity<Map<String, String>> liveness() {
        return ResponseEntity.ok(Map.of("status", "UP"));
    }

    @GetMapping("/health/ready")
    @Operation(summary = "Readiness probe", description = "Kubernetes readiness probe")
    public ResponseEntity<Map<String, String>> readiness() {
        // For now, always ready. Will add DB check in Story 0.3
        return ResponseEntity.ok(Map.of("status", "UP"));
    }
}
