package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.UserDTO;
import com.gaji.corebackend.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
}
