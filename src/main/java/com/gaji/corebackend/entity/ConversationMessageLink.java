package com.gaji.corebackend.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConversationMessageLink {

    private UUID id;
    private Conversation conversation;
    private Message message;
    private Integer sequenceOrder;
    private LocalDateTime createdAt;
}
