package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConversationMemo {

    private UUID id;
    private UUID userId;
    private UUID conversationId;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Associations for result mapping
    private User user;
    private Conversation conversation;
}
