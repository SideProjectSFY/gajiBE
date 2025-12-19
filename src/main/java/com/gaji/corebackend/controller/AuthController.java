package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.auth.AuthResponse;
import com.gaji.corebackend.dto.auth.LoginRequest;
import com.gaji.corebackend.dto.auth.RegisterRequest;
import com.gaji.corebackend.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Authentication Controller
 * Handles user registration, login, token refresh, and logout
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication", description = "User authentication and authorization")
public class AuthController {

    private static final String ACCESS_TOKEN_COOKIE = "accessToken";
    private static final String REFRESH_TOKEN_COOKIE = "refreshToken";
    private static final int ACCESS_TOKEN_MAX_AGE = 3600; // 1 hour
    private static final int REFRESH_TOKEN_MAX_AGE = 604800; // 7 days

    private final AuthService authService;

    /**
     * Register a new user
     * POST /api/auth/register
     */
    @PostMapping("/register")
    @Operation(summary = "Register new user", description = "Create a new user account with email and password")
    public ResponseEntity<AuthResponse> register(
            @Valid @RequestBody RegisterRequest request,
            HttpServletResponse response) {
        log.info("Registration request received for email: {}", request.getEmail());
        AuthResponse authResponse = authService.register(request);
        
        // Set tokens in HTTP-only cookies
        setAuthCookies(response, authResponse.getAccessToken(), authResponse.getRefreshToken());
        
        return ResponseEntity.status(HttpStatus.CREATED).body(authResponse);
    }

    /**
     * Login with email and password
     * POST /api/auth/login
     */
    @PostMapping("/login")
    @Operation(summary = "User login", description = "Authenticate user and return JWT tokens")
    public ResponseEntity<AuthResponse> login(
            @Valid @RequestBody LoginRequest request,
            HttpServletResponse response) {
        log.info("Login request received for email: {}", request.getEmail());
        AuthResponse authResponse = authService.login(request);
        
        // Set tokens in HTTP-only cookies
        setAuthCookies(response, authResponse.getAccessToken(), authResponse.getRefreshToken());
        
        return ResponseEntity.ok(authResponse);
    }

    /**
     * Refresh access token using refresh token
     * POST /api/auth/refresh
     */
    @PostMapping("/refresh")
    @Operation(summary = "Refresh access token", description = "Get new access token using refresh token")
    public ResponseEntity<AuthResponse> refresh(
            HttpServletRequest request,
            HttpServletResponse response) {
        log.info("Token refresh request received");
        
        // Extract refresh token from cookie
        String refreshToken = extractTokenFromCookie(request, REFRESH_TOKEN_COOKIE);
        if (refreshToken == null) {
            throw new IllegalArgumentException("Refresh token not found in cookies");
        }
        
        AuthResponse authResponse = authService.refreshToken(refreshToken);
        
        // Update access token cookie
        setAuthCookies(response, authResponse.getAccessToken(), authResponse.getRefreshToken());
        
        return ResponseEntity.ok(authResponse);
    }

    /**
     * Logout by blacklisting refresh token
     * POST /api/auth/logout
     */
    @PostMapping("/logout")
    @Operation(summary = "User logout", description = "Invalidate refresh token")
    public ResponseEntity<Map<String, String>> logout(
            HttpServletRequest request,
            HttpServletResponse response) {
        log.info("Logout request received");
        
        // Extract refresh token from cookie
        String refreshToken = extractTokenFromCookie(request, REFRESH_TOKEN_COOKIE);
        if (refreshToken != null) {
            authService.logout(refreshToken);
        }
        
        // Clear auth cookies
        clearAuthCookies(response);
        
        return ResponseEntity.ok(Map.of("message", "Logged out successfully"));
    }

    /**
     * Set authentication tokens in HTTP-only cookies
     */
    private void setAuthCookies(HttpServletResponse response, String accessToken, String refreshToken) {
        // Access token cookie (1 hour)
        Cookie accessTokenCookie = new Cookie(ACCESS_TOKEN_COOKIE, accessToken);
        accessTokenCookie.setHttpOnly(true);
        accessTokenCookie.setSecure(false); // Set to true in production with HTTPS
        accessTokenCookie.setPath("/");
        accessTokenCookie.setMaxAge(ACCESS_TOKEN_MAX_AGE);
        response.addCookie(accessTokenCookie);

        // Refresh token cookie (7 days)
        Cookie refreshTokenCookie = new Cookie(REFRESH_TOKEN_COOKIE, refreshToken);
        refreshTokenCookie.setHttpOnly(true);
        refreshTokenCookie.setSecure(false); // Set to true in production with HTTPS
        refreshTokenCookie.setPath("/");
        refreshTokenCookie.setMaxAge(REFRESH_TOKEN_MAX_AGE);
        response.addCookie(refreshTokenCookie);
    }

    /**
     * Clear authentication cookies
     */
    private void clearAuthCookies(HttpServletResponse response) {
        Cookie accessTokenCookie = new Cookie(ACCESS_TOKEN_COOKIE, "");
        accessTokenCookie.setHttpOnly(true);
        accessTokenCookie.setSecure(false);
        accessTokenCookie.setPath("/");
        accessTokenCookie.setMaxAge(0);
        response.addCookie(accessTokenCookie);

        Cookie refreshTokenCookie = new Cookie(REFRESH_TOKEN_COOKIE, "");
        refreshTokenCookie.setHttpOnly(true);
        refreshTokenCookie.setSecure(false);
        refreshTokenCookie.setPath("/");
        refreshTokenCookie.setMaxAge(0);
        response.addCookie(refreshTokenCookie);
    }

    /**
     * Extract token from request cookies
     */
    private String extractTokenFromCookie(HttpServletRequest request, String cookieName) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookieName.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
