package com.gaji.shared.contract.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
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
    @JsonProperty("isLiked")
    private boolean isLiked;
    private int likeCount;
}
