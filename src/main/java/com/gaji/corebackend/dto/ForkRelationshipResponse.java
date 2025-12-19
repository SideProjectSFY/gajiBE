package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Response DTO for fork relationship
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ForkRelationshipResponse {
    private UUID conversationId;
    private UUID parentConversationId;
    private String parentTitle;
    private Boolean isRoot;
    private Integer depth;
}
