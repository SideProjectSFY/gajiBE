package com.gaji.chat.domain.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public record ConversationMessageSearchResult(
        UUID conversationId,
        String conversationTitle,
        long messageHitCount,
        LocalDateTime lastHitAt,
        String matchedContent,
        List<RecentMessage> recentMessages
) {
    public record RecentMessage(
            UUID messageId,
            String role,
            String snippet,
            LocalDateTime createdAt
    ) {
    }
}
