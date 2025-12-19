package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.Conversation;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Response DTO for conversation data with nested messages
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConversationResponse {

    private UUID id;
    private UUID userId;
    private UUID scenarioId;
    private String scenarioType;
    private String characterVectordbId;
    private UUID parentConversationId;
    private String title;
    private Boolean isRoot;
    private Boolean hasBeenForked;
    private Integer depth;
    private Integer messageCount;
    private Integer likeCount;
    private Boolean isPrivate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<MessageResponse> messages;

    /**
     * Create response from conversation entity
     */
    public static ConversationResponse from(Conversation entity) {
        return ConversationResponse.builder()
                .id(entity.getId())
                .userId(entity.getUserId())
                .scenarioId(entity.getScenarioId())
                .scenarioType(entity.getScenarioType())
                .characterVectordbId(entity.getCharacterVectordbId())
                .parentConversationId(entity.getParentConversationId())
                .title(entity.getTitle())
                .isRoot(entity.getIsRoot())
                .hasBeenForked(entity.getHasBeenForked())
                .depth(calculateDepth(entity))
                .messageCount(entity.getMessageCount())
                .likeCount(entity.getLikeCount())
                .isPrivate(entity.getIsPrivate())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    /**
     * Calculate conversation depth (0 for root, 1 for first fork, etc.)
     */
    private static Integer calculateDepth(Conversation entity) {
        if (Boolean.TRUE.equals(entity.getIsRoot())) {
            return 0;
        }
        // For forked conversations, depth is 1 or more
        // In a simple two-level system, all forks are depth 1
        return 1;
    }
}
