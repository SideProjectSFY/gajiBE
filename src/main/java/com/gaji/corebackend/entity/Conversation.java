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

    // Joined fields (for display)
    private String bookTitle;
    private String bookAuthor;
    private String bookCoverUrl;
    private String scenarioDescription;
}
