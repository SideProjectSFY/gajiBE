package com.gaji.corebackend.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.actuate.health.HealthComponent;
import org.springframework.boot.actuate.health.HealthEndpoint;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Health Check Controller
 *
 * Story 0.6: Inter-Service Health Check & API Contract (Pattern B)
 *
 * Provides unified health status aggregating:
 * - Spring Boot Actuator (db, diskSpace)
 * - Custom Health Indicators (fastapi, redis)
 *
 * Primary endpoint is Spring Boot Actuator's /actuator/health
 * This controller provides additional API-friendly endpoints
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/system")
@RequiredArgsConstructor
@Tag(name = "System Health", description = "System health check and monitoring endpoints")
public class HealthCheckController {

    private final HealthEndpoint healthEndpoint;

    @GetMapping("/health")
    @Operation(
        summary = "System health check",
        description = "Returns aggregated health status of all system components including PostgreSQL, FastAPI, Redis, and disk space"
    )
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "All services healthy"),
        @ApiResponse(responseCode = "503", description = "One or more services unhealthy")
    })
    public ResponseEntity<Map<String, Object>> health() {
        HealthComponent health = healthEndpoint.health();

        Map<String, Object> response = new LinkedHashMap<>();
        response.put("status", health.getStatus().getCode());
        response.put("timestamp", Instant.now().toString());

        // Determine HTTP status based on health
        HttpStatus httpStatus = "UP".equals(health.getStatus().getCode())
            ? HttpStatus.OK
            : HttpStatus.SERVICE_UNAVAILABLE;

        log.info("Health check requested, status: {}", health.getStatus().getCode());

        return ResponseEntity.status(httpStatus).body(response);
    }

    @GetMapping("/health/details")
    @Operation(
        summary = "Detailed system health",
        description = "Returns detailed health information for all components"
    )
    public ResponseEntity<HealthComponent> healthDetails() {
        return ResponseEntity.ok(healthEndpoint.health());
    }

    @GetMapping("/ready")
    @Operation(summary = "Readiness probe", description = "Kubernetes readiness probe - checks if service can accept traffic")
    public ResponseEntity<Map<String, String>> readiness() {
        HealthComponent health = healthEndpoint.health();
        boolean isReady = "UP".equals(health.getStatus().getCode());

        if (isReady) {
            return ResponseEntity.ok(Map.of(
                "status", "READY",
                "timestamp", Instant.now().toString()
            ));
        } else {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).body(Map.of(
                "status", "NOT_READY",
                "timestamp", Instant.now().toString()
            ));
        }
    }

    @GetMapping("/live")
    @Operation(summary = "Liveness probe", description = "Kubernetes liveness probe - checks if service is alive")
    public ResponseEntity<Map<String, String>> liveness() {
        // Liveness should return OK if the application is running
        // (not dependent on external services)
        return ResponseEntity.ok(Map.of(
            "status", "ALIVE",
            "timestamp", Instant.now().toString()
        ));
    }
}
