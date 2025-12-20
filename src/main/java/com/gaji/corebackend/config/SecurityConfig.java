package com.gaji.corebackend.config;

import com.gaji.corebackend.security.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfigurationSource;

/**
 * Security Configuration
 * 
 * JWT-based authentication with stateless sessions
 * Public endpoints: /api/auth/*, health checks, documentation
 * Protected endpoints: All other API endpoints
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    private final CorsConfigurationSource corsConfigurationSource;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    public SecurityConfig(@Qualifier("corsConfigurationSource") CorsConfigurationSource corsConfigurationSource,
                          JwtAuthenticationFilter jwtAuthenticationFilter) {
        this.corsConfigurationSource = corsConfigurationSource;
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // CORS configuration
            .cors(cors -> cors.configurationSource(corsConfigurationSource))
            
            // Disable CSRF (using JWT, not session-based auth)
            .csrf(AbstractHttpConfigurer::disable)
            
            // Stateless session (no server-side sessions)
            .sessionManagement(session -> 
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            )
            
            // Authorization rules
            .authorizeHttpRequests(auth -> auth
                // Public endpoints
                .requestMatchers(
                    "/api/auth/**",          // Authentication endpoints (legacy)
                    "/api/v1/auth/**",       // Authentication endpoints (v1)
                    "/api/v1/system/**",     // System health endpoints
                    "/api/v1/books/**",      // Books endpoints (list, detail, like)
                    "/api/v1/novels/**",     // Novel endpoints (public browsing)
                    "/api/v1/internal/**",       // Internal API (FastAPI → Spring Boot, no auth required)
                    "/actuator/health",      // Health check
                    "/swagger-ui.html",      // Swagger UI (legacy path)
                    "/swagger-ui/**",        // Swagger UI
                    "/v3/api-docs/**",       // OpenAPI docs
                    "/error"                 // Error handling
                ).permitAll()
                
                // Public GET endpoints
                .requestMatchers(HttpMethod.GET, "/api/v1/users/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/scenarios/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/conversations/**").permitAll()
                .requestMatchers(HttpMethod.GET, "/api/v1/book-likes/**").permitAll()

                // All other requests require authentication
                .anyRequest().authenticated()
            )
            
            // Add JWT filter before UsernamePasswordAuthenticationFilter
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // BCrypt with 12 rounds (as specified in story requirements)
        return new BCryptPasswordEncoder(12);
    }
}
