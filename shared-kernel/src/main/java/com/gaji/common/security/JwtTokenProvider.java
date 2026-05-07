package com.gaji.common.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * JWT utility class for token generation and validation
 * Access Token: 1 hour expiration
 * Refresh Token: 7 days expiration
 */
@Slf4j
@Component
public class JwtTokenProvider {

    private final SecretKey secretKey;
    private final long accessTokenExpiration = 3600000; // 1 hour in milliseconds
    private final long refreshTokenExpiration = 604800000; // 7 days in milliseconds

    public JwtTokenProvider(@Value("${spring.security.jwt.secret}") String secret) {
        // Ensure the secret is at least 256 bits (32 bytes) for HS256
        String paddedSecret = secret.length() < 32 
            ? secret + "0".repeat(32 - secret.length()) 
            : secret;
        this.secretKey = Keys.hmacShaKeyFor(paddedSecret.getBytes(StandardCharsets.UTF_8));
    }

    /**
     * Generate access token with 1 hour expiration
     */
    public String generateAccessToken(UUID userId, String email, String username) {
        return generateAccessToken(userId, email, username, null);
    }

    public String generateAccessToken(UUID userId, String email, String username, String role) {
        Instant now = Instant.now();

        JwtBuilder builder = Jwts.builder()
                .subject(userId.toString())
                .claim("email", email)
                .claim("username", username)
                .claim("type", "access")
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plusMillis(accessTokenExpiration)))
                .signWith(secretKey);

        if (role != null && !role.isBlank()) {
            builder.claim("role", role);
        }

        return builder.compact();
    }

    /**
     * Generate refresh token with 7 days expiration
     */
    public String generateRefreshToken(UUID userId) {
        Instant now = Instant.now();
        
        return Jwts.builder()
                .subject(userId.toString())
                .claim("type", "refresh")
                .issuedAt(Date.from(now))
                .expiration(Date.from(now.plusMillis(refreshTokenExpiration)))
                .signWith(secretKey)
                .compact();
    }

    /**
     * Generate short-lived AI broker token for direct AI gateway calls.
     */
    public String generateAiBrokerToken(
            UUID userId,
            String email,
            String username,
            String audience,
            String scope,
            String issuer,
            String requestId,
            String model,
            String role,
            int ttlSeconds
    ) {
        return generateAiBrokerToken(
                userId,
                email,
                username,
                audience,
                scope,
                issuer,
                requestId,
                model,
                role,
                ttlSeconds,
                Collections.emptyList()
        );
    }

    public String generateAiBrokerToken(
            UUID userId,
            String email,
            String username,
            String audience,
            String scope,
            String issuer,
            String requestId,
            String model,
            String role,
            int ttlSeconds,
            List<String> novelIds
    ) {
        Instant now = Instant.now();
        Instant expiration = now.plus(Math.max(30, ttlSeconds), ChronoUnit.SECONDS);

        JwtBuilder builder = Jwts.builder()
                .subject(userId.toString())
                .issuer(issuer)
                .audience().add(audience).and()
                .claim("email", email)
                .claim("username", username)
                .claim("scope", scope)
                .claim("owner_user_id", userId.toString())
                .claim("type", "ai_broker")
                .claim("request_id", requestId)
                .claim("model", model)
                .id(UUID.randomUUID().toString())
                .issuedAt(Date.from(now))
                .expiration(Date.from(expiration))
                .signWith(secretKey);

        if (role != null && !role.isBlank()) {
            builder.claim("role", role);
        }
        if (novelIds != null && !novelIds.isEmpty()) {
            builder.claim("novel_ids", novelIds);
        }

        return builder.compact();
    }

    /**
     * Extract user ID from token
     */
    public UUID getUserIdFromToken(String token) {
        Claims claims = extractClaims(token);
        return UUID.fromString(claims.getSubject());
    }

    /**
     * Extract email from token
     */
    public String getEmailFromToken(String token) {
        Claims claims = extractClaims(token);
        return claims.get("email", String.class);
    }

    /**
     * Extract username from token
     */
    public String getUsernameFromToken(String token) {
        Claims claims = extractClaims(token);
        return claims.get("username", String.class);
    }

    public String getRoleFromToken(String token) {
        Claims claims = extractClaims(token);
        return claims.get("role", String.class);
    }

    public List<String> getNovelIdsFromToken(String token) {
        Claims claims = extractClaims(token);
        Object value = claims.get("novel_ids");
        if (!(value instanceof List<?> rawList)) {
            return Collections.emptyList();
        }
        return rawList.stream()
                .filter(item -> item != null)
                .map(String::valueOf)
                .toList();
    }

    /**
     * Validate token and return true if valid
     */
    public boolean validateToken(String token) {
        try {
            extractClaims(token);
            return true;
        } catch (ExpiredJwtException e) {
            log.error("JWT token is expired: {}", e.getMessage());
        } catch (UnsupportedJwtException e) {
            log.error("JWT token is unsupported: {}", e.getMessage());
        } catch (MalformedJwtException e) {
            log.error("JWT token is malformed: {}", e.getMessage());
        } catch (SignatureException e) {
            log.error("JWT signature validation failed: {}", e.getMessage());
        } catch (IllegalArgumentException e) {
            log.error("JWT token compact is empty: {}", e.getMessage());
        }
        return false;
    }

    /**
     * Check if token is a refresh token
     */
    public boolean isRefreshToken(String token) {
        Claims claims = extractClaims(token);
        return "refresh".equals(claims.get("type", String.class));
    }

    /**
     * Extract all claims from token
     */
    private Claims extractClaims(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
}
