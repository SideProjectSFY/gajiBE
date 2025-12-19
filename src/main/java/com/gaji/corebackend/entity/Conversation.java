package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Conversation {

    private UUID id;
    private UUID userId;
    private UUID scenarioId;
    private String scenarioType;
    private String characterVectordbId;
    private UUID parentConversationId;
    private String title;

    @Builder.Default
    private Boolean isRoot = true;

    @Builder.Default
    private Boolean hasBeenForked = false;

    @Builder.Default
    private Integer messageCount = 0;

    @Builder.Default
    private Integer likeCount = 0;

    @Builder.Default
    private Boolean isPrivate = false;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Optional: Keep User object if needed for result mapping, but usually we fetch separately or use DTOs
    // For now, I'll remove it to simplify.
}
