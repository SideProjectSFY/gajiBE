package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Message {

    private UUID id;
    private UUID conversationId;
    private UUID senderId;
    private String role;
    private String content;
    private LocalDateTime createdAt;
}
