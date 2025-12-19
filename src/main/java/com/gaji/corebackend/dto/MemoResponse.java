package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.ConversationMemo;
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
public class MemoResponse {

    private UUID id;
    private UUID userId;
    private UUID conversationId;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static MemoResponse from(ConversationMemo memo) {
        return MemoResponse.builder()
            .id(memo.getId())
            .userId(memo.getUserId())
            .conversationId(memo.getConversationId())
            .content(memo.getContent())
            .createdAt(memo.getCreatedAt())
            .updatedAt(memo.getUpdatedAt())
            .build();
    }
}
