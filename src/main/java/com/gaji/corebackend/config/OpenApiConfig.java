package com.gaji.corebackend.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * OpenAPI/Swagger 설정
 * JWT 인증을 위한 Security Scheme 정의
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        final String securitySchemeName = "bearerAuth";
        
        return new OpenAPI()
                .info(new Info()
                        .title("Gaji API Gateway")
                        .description("""
                                Gaji Backend API - Pattern B Architecture
                                
                                ## 인증 방법
                                1. `/api/v1/auth/login` 엔드포인트로 로그인하여 JWT 토큰을 받습니다.
                                2. 우측 상단의 'Authorize' 버튼을 클릭합니다.
                                3. 받은 토큰을 입력하고 'Authorize'를 클릭합니다.
                                4. 이제 보호된 API를 테스트할 수 있습니다.
                                
                                ## 아키텍처
                                - Frontend ↔ Spring Boot (port 8080) ↔ FastAPI (port 8200)
                                - PostgreSQL: 메타데이터 저장
                                - FastAPI: AI/RAG 기능 + VectorDB 관리
                                """)
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Gaji Team")
                                .email("support@gaji.app")))
                .servers(List.of(
                        new Server()
                                .url("http://localhost:8080")
                                .description("Development Server"),
                        new Server()
                                .url("https://api.gaji.app")
                                .description("Production Server")))
                .addSecurityItem(new SecurityRequirement()
                        .addList(securitySchemeName))
                .components(new Components()
                        .addSecuritySchemes(securitySchemeName,
                                new SecurityScheme()
                                        .name(securitySchemeName)
                                        .type(SecurityScheme.Type.HTTP)
                                        .scheme("bearer")
                                        .bearerFormat("JWT")
                                        .description("JWT 토큰을 입력하세요 (Bearer 접두사 없이)")));
    }
}

