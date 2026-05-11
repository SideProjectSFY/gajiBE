package com.gaji.chat.domain.repository;

import java.time.LocalDateTime;
import java.util.UUID;

public record ConversationMessageSearchIndexHit(
        UUID conversationId,
        String conversationTitle,
        long messageHitCount,
        LocalDateTime lastHitAt,
        String matchedContent
) {
}
