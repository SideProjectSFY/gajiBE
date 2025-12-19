package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.auth.AuthResponse;
import com.gaji.corebackend.dto.auth.LoginRequest;
import com.gaji.corebackend.dto.auth.RegisterRequest;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.exception.UnauthorizedException;
import com.gaji.corebackend.mapper.UserMapper;
import com.gaji.corebackend.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Service for authentication operations (register, login, refresh, logout)
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;
    private final TokenBlacklistService tokenBlacklistService;

    /**
     * Register a new user
     * Validates email uniqueness and password requirements
     */
    @Transactional
    public AuthResponse register(RegisterRequest request) {
        log.info("Attempting to register user with email: {}", request.getEmail());

        // Check if email already exists
        if (userMapper.existsByEmail(request.getEmail())) {
            throw new BadRequestException("Email is already registered");
        }

        // Check if username already exists
        if (userMapper.existsByUsername(request.getUsername())) {
            throw new BadRequestException("Username is already taken");
        }

        // Create new user
        User user = User.builder()
                .id(UUID.randomUUID())
                .email(request.getEmail())
                .username(request.getUsername())
                .passwordHash(passwordEncoder.encode(request.getPassword()))
                .build();

        userMapper.insert(user);
        log.info("User registered successfully: {}", user.getId());

        // Generate tokens
        String accessToken = jwtTokenProvider.generateAccessToken(
                user.getId(), 
                user.getEmail(), 
                user.getUsername()
        );
        String refreshToken = jwtTokenProvider.generateRefreshToken(user.getId());

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userId(user.getId())
                .email(user.getEmail())
                .username(user.getUsername())
                .build();
    }

    /**
     * Login with email and password
     */
    @Transactional(readOnly = true)
    public AuthResponse login(LoginRequest request) {
        log.info("Attempting login for email: {}", request.getEmail());

        // Find user by email
        User user = userMapper.findByEmail(request.getEmail())
                .orElseThrow(() -> new UnauthorizedException("Invalid email or password"));

        // Verify password
        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new UnauthorizedException("Invalid email or password");
        }

        log.info("User logged in successfully: {}", user.getId());

        // Generate tokens
        String accessToken = jwtTokenProvider.generateAccessToken(
                user.getId(), 
                user.getEmail(), 
                user.getUsername()
        );
        String refreshToken = jwtTokenProvider.generateRefreshToken(user.getId());

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .userId(user.getId())
                .email(user.getEmail())
                .username(user.getUsername())
                .build();
    }

    /**
     * Refresh access token using refresh token
     */
    @Transactional(readOnly = true)
    public AuthResponse refreshToken(String refreshToken) {
        log.info("Attempting to refresh token");

        // Validate refresh token
        if (!jwtTokenProvider.validateToken(refreshToken)) {
            throw new UnauthorizedException("Invalid or expired refresh token");
        }

        // Check if token is blacklisted (logged out)
        if (tokenBlacklistService.isBlacklisted(refreshToken)) {
            throw new UnauthorizedException("Refresh token has been invalidated");
        }

        // Verify it's a refresh token
        if (!jwtTokenProvider.isRefreshToken(refreshToken)) {
            throw new UnauthorizedException("Token is not a refresh token");
        }

        // Extract user ID and get user details
        UUID userId = jwtTokenProvider.getUserIdFromToken(refreshToken);
        User user = userMapper.findById(userId)
                .orElseThrow(() -> new UnauthorizedException("User not found"));

        log.info("Token refreshed successfully for user: {}", user.getId());

        // Generate new access token (keep the same refresh token)
        String newAccessToken = jwtTokenProvider.generateAccessToken(
                user.getId(), 
                user.getEmail(), 
                user.getUsername()
        );

        return AuthResponse.builder()
                .accessToken(newAccessToken)
                .refreshToken(refreshToken) // Return the same refresh token
                .userId(user.getId())
                .email(user.getEmail())
                .username(user.getUsername())
                .build();
    }

    /**
     * Logout by blacklisting the refresh token
     */
    public void logout(String refreshToken) {
        log.info("Attempting to logout");

        // Validate refresh token format
        if (!jwtTokenProvider.validateToken(refreshToken)) {
            throw new UnauthorizedException("Invalid refresh token");
        }

        // Add to blacklist
        tokenBlacklistService.blacklistToken(refreshToken);
        
        UUID userId = jwtTokenProvider.getUserIdFromToken(refreshToken);
        log.info("User logged out successfully: {}", userId);
    }
}
