package com.gaji.corebackend.security;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * User principal for authenticated users
 * Used in SecurityContext
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserPrincipal {
    
    private UUID userId;
    private String email;
    private String username;
}
