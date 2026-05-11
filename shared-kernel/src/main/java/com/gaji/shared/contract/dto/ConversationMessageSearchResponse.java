package com.gaji.shared.contract.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ConversationMessageSearchResponse {

    private UUID conversationId;
    private String conversationTitle;
    private long messageHitCount;
    private LocalDateTime lastHitAt;
    private String snippet;
    private List<RecentMessagePreview> recentMessages;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class RecentMessagePreview {
        private UUID messageId;
        private String role;
        private String snippet;
        private LocalDateTime createdAt;
    }
}
