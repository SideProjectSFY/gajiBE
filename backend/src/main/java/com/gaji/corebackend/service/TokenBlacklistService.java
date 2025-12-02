package com.gaji.corebackend.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.UUID;

/**
 * Service for managing blacklisted refresh tokens (logout)
 * Uses Redis for token blacklist storage with TTL
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class TokenBlacklistService {

    private final RedisTemplate<String, String> redisTemplate;
    private static final String BLACKLIST_PREFIX = "blacklist:token:";
    private static final Duration BLACKLIST_TTL = Duration.ofDays(7); // Match refresh token expiration

    /**
     * Add token to blacklist (for logout)
     */
    public void blacklistToken(String token) {
        String key = BLACKLIST_PREFIX + token;
        redisTemplate.opsForValue().set(key, "blacklisted", BLACKLIST_TTL);
        log.info("Token blacklisted: {}", token.substring(0, Math.min(20, token.length())));
    }

    /**
     * Check if token is blacklisted
     */
    public boolean isBlacklisted(String token) {
        String key = BLACKLIST_PREFIX + token;
        return Boolean.TRUE.equals(redisTemplate.hasKey(key));
    }

    /**
     * Remove token from blacklist (usually not needed, but useful for testing)
     */
    public void removeFromBlacklist(String token) {
        String key = BLACKLIST_PREFIX + token;
        redisTemplate.delete(key);
    }
}
