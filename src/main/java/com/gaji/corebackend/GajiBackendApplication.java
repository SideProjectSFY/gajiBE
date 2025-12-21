package com.gaji.corebackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import jakarta.annotation.PostConstruct;
import java.util.TimeZone;

/**
 * Gaji Core Backend - API Gateway Application
 *
 * Pattern B Architecture:
 * - Frontend communicates ONLY with this Spring Boot service (port 8080)
 * - Spring Boot proxies AI requests to FastAPI (internal, port 8000)
 * - PostgreSQL access via MyBatis (13 metadata tables)
 * - No direct VectorDB access (delegated to FastAPI)
 */
@SpringBootApplication
public class GajiBackendApplication {

    @PostConstruct
    public void init() {
        // Set JVM timezone to Asia/Seoul
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
    }

    public static void main(String[] args) {
        SpringApplication.run(GajiBackendApplication.class, args);
    }

}
