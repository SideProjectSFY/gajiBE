package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.UpdateUserProfileRequest;
import com.gaji.corebackend.dto.UserDTO;
import com.gaji.corebackend.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
@Tag(name = "Users", description = "User Management API")
public class UserController {

    private final UserService userService;

    @GetMapping("/{username}")
    @Operation(summary = "Get user profile", description = "Get public profile of a user by username")
    public ResponseEntity<UserDTO> getUserProfile(@PathVariable String username) {
        UserDTO user = userService.getUserByUsername(username);
        return ResponseEntity.ok(user);
    }

    @PutMapping("/{userId}")
    @Operation(summary = "Update user profile", description = "Update user's bio and avatar")
    public ResponseEntity<UserDTO> updateUserProfile(
            @PathVariable UUID userId,
            @RequestHeader("X-User-Id") UUID requestingUserId,
            @Valid @RequestBody UpdateUserProfileRequest request) {
        
        // Verify user is updating their own profile
        if (!userId.equals(requestingUserId)) {
            return ResponseEntity.status(403).build();
        }
        
        UserDTO updatedUser = userService.updateUserProfile(userId, request);
        return ResponseEntity.ok(updatedUser);
    }
}
