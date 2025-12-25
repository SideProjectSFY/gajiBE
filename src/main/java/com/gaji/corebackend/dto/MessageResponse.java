package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.Message;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for message data
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageResponse {

    private UUID id;
    private UUID conversationId;
    private UUID senderId;
    private String role;
    private String content;
    private LocalDateTime createdAt;
    
    // 턴 정보 (AI 응답에서 추출)
    private Integer turnCount;  // 현재 턴 수
    private Integer maxTurns;   // 최대 턴 수

    /**
     * Create response from message entity
     */
    public static MessageResponse from(Message entity) {
        return MessageResponse.builder()
                .id(entity.getId())
                .conversationId(entity.getConversationId())
                .senderId(entity.getSenderId())
                .role(entity.getRole())
                .content(entity.getContent())
                .createdAt(entity.getCreatedAt())
                .build();
    }
}
