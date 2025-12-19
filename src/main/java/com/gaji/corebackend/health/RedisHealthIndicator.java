package com.gaji.corebackend.health;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

/**
 * Redis Health Indicator
 *
 * Checks connectivity to Redis server used for:
 * - Celery broker (task queue)
 * - Long Polling task storage (600s TTL)
 *
 * Uses simple socket connection to avoid adding redis dependency to Spring Boot
 * (Redis is primarily used by FastAPI/Celery)
 */
@Slf4j
@Component("redis")
public class RedisHealthIndicator implements HealthIndicator {

    @Value("${spring.data.redis.host:localhost}")
    private String redisHost;

    @Value("${spring.data.redis.port:6379}")
    private int redisPort;

    @Override
    public Health health() {
        try {
            long startTime = System.currentTimeMillis();

            // Simple Redis PING command via socket
            try (Socket socket = new Socket(redisHost, redisPort);
                 PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
                 BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()))) {

                socket.setSoTimeout(5000); // 5 second timeout

                // Send Redis PING command
                out.println("PING");
                String response = in.readLine();

                long responseTime = System.currentTimeMillis() - startTime;

                if (response != null && response.contains("PONG")) {
                    log.debug("Redis health check passed in {}ms", responseTime);
                    return Health.up()
                        .withDetail("host", redisHost + ":" + redisPort)
                        .withDetail("ping", "PONG")
                        .withDetail("responseTime", responseTime + "ms")
                        .build();
                } else {
                    log.warn("Redis returned unexpected response: {}", response);
                    return Health.down()
                        .withDetail("host", redisHost + ":" + redisPort)
                        .withDetail("response", response)
                        .withDetail("error", "Unexpected response to PING")
                        .build();
                }
            }

        } catch (Exception e) {
            log.error("Redis health check failed: {}", e.getMessage());
            return Health.down()
                .withDetail("host", redisHost + ":" + redisPort)
                .withDetail("error", e.getMessage())
                .withDetail("errorType", e.getClass().getSimpleName())
                .build();
        }
    }
}
