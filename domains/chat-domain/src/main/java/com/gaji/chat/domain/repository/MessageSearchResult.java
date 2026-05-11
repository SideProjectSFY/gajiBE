package com.gaji.chat.domain.repository;

import java.time.LocalDateTime;
import java.util.UUID;

public record MessageSearchResult(
        UUID messageId,
        UUID conversationId,
        String conversationTitle,
        String role,
        String content,
        LocalDateTime createdAt
) {
}
