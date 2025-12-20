package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.Size;

/**
 * Request DTO for updating user profile
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateUserProfileRequest {
    
    @Size(max = 500, message = "Bio must be less than 500 characters")
    private String bio;
    
    @Size(max = 255, message = "Avatar URL must be less than 255 characters")
    private String avatarUrl;
}
