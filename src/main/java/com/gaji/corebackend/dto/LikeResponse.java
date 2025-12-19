package com.gaji.corebackend.dto;

import lombok.*;

/**
 * Response DTO for like operations
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeResponse {
    private boolean isLiked;
    private int likeCount;
}
