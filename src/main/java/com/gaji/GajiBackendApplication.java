package com.gaji;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import jakarta.annotation.PostConstruct;
import java.util.TimeZone;

/**
 * Gaji Core Backend - API Gateway Application
 *
 * - Frontend communicates ONLY with this Spring Boot service (port 8080)
 * - Spring Boot handles AI/RAG orchestration directly
 * - PostgreSQL access via JPA plus pgvector for passage embeddings
 * - Elasticsearch provides BM25 retrieval for hybrid RAG
 */
@SpringBootApplication
@EnableJpaAuditing
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
