package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    private UUID id;
    private String email;
    private String username;
    private String passwordHash;
    private String bio;
    private String avatarUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @Builder.Default
    private String role = "USER";

    @Builder.Default
    private Boolean isActive = true;

    private LocalDateTime lastLoginAt;
}
