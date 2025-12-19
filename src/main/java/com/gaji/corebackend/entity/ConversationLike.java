package com.gaji.corebackend.entity;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConversationLike {

    private UUID userId;
    private UUID conversationId;
    private LocalDateTime createdAt;

    // Associations for result mapping
    private User user;
    private Conversation conversation;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ConversationLikeId implements Serializable {
        private UUID userId;
        private UUID conversationId;
    }
}
