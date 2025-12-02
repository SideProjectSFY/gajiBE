package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Response DTO for is-following check endpoint
 * Story 6.4: Follow/Follower System Backend
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class IsFollowingResponse {
    /**
     * Whether the current user is following the target user
     */
    @JsonProperty("isFollowing")
    private boolean isFollowing;
    
    /**
     * Whether it's a mutual follow (both users follow each other)
     */
    @JsonProperty("isMutual")
    private boolean isMutual;
}
