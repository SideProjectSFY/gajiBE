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
                .userId(entity.getUser().getId())
                .scenarioId(entity.getScenarioId())
                .scenarioType(entity.getScenarioType())
                .characterVectordbId(entity.getCharacterVectordbId())
                .parentConversationId(entity.getParentConversation() != null ? 
                        entity.getParentConversation().getId() : null)
                .title(entity.getTitle())
                .isRoot(entity.getIsRoot())
                .messageCount(entity.getMessageCount())
                .likeCount(entity.getLikeCount())
                .isPrivate(entity.getIsPrivate())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }
}
