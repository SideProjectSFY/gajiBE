package com.gaji.corebackend.health;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import java.time.Duration;
import java.util.Map;

/**
 * FastAPI Internal Service Health Indicator
 *
 * Checks connectivity to the FastAPI AI service (Pattern B: internal-only)
 * This indicator is included in Spring Boot's /actuator/health endpoint
 */
@Slf4j
@Component("fastapi")
@RequiredArgsConstructor
public class FastApiHealthIndicator implements HealthIndicator {

    @Qualifier("fastApiClient")
    private final WebClient fastApiClient;

    @Value("${fastapi.base-url:http://localhost:8000}")
    private String fastApiUrl;

    @Override
    public Health health() {
        try {
            long startTime = System.currentTimeMillis();

            @SuppressWarnings("unchecked")
            Map<String, Object> response = fastApiClient.get()
                .uri("/health")
                .retrieve()
                .bodyToMono(Map.class)
                .block(Duration.ofSeconds(5));

            long responseTime = System.currentTimeMillis() - startTime;

            if (response != null && "healthy".equals(response.get("status"))) {
                log.debug("FastAPI health check passed in {}ms", responseTime);

                Health.Builder healthBuilder = Health.up()
                    .withDetail("url", fastApiUrl)
                    .withDetail("responseTime", responseTime + "ms");

                // Include sub-component status from FastAPI response
                if (response.containsKey("gemini_api")) {
                    healthBuilder.withDetail("gemini_api", response.get("gemini_api"));
                }
                if (response.containsKey("vectordb")) {
                    healthBuilder.withDetail("vectordb", response.get("vectordb"));
                }
                if (response.containsKey("vectordb_type")) {
                    healthBuilder.withDetail("vectordb_type", response.get("vectordb_type"));
                }
                if (response.containsKey("redis")) {
                    healthBuilder.withDetail("redis", response.get("redis"));
                }
                if (response.containsKey("celery_workers")) {
                    healthBuilder.withDetail("celery_workers", response.get("celery_workers"));
                }

                return healthBuilder.build();
            } else {
                String status = response != null ? String.valueOf(response.get("status")) : "unknown";
                log.warn("FastAPI health check returned unhealthy status: {}", status);
                return Health.down()
                    .withDetail("url", fastApiUrl)
                    .withDetail("status", status)
                    .withDetail("response", response)
                    .build();
            }

        } catch (Exception e) {
            log.error("FastAPI health check failed: {}", e.getMessage());
            return Health.down()
                .withDetail("url", fastApiUrl)
                .withDetail("error", e.getMessage())
                .withDetail("errorType", e.getClass().getSimpleName())
                .build();
        }
    }
}
