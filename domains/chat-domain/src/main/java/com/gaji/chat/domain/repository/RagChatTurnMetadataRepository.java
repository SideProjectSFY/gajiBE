package com.gaji.chat.domain.repository;

import com.gaji.chat.domain.model.RagChatTurnMetadata;

import java.util.Optional;
import java.util.UUID;

public interface RagChatTurnMetadataRepository {

    RagChatTurnMetadata save(RagChatTurnMetadata metadata);

    Optional<RagChatTurnMetadata> findById(UUID id);

    Optional<RagChatTurnMetadata> findByAssistantMessageId(UUID assistantMessageId);
}
