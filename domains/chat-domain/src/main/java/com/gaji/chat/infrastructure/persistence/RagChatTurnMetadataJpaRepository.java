package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.RagChatTurnMetadata;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface RagChatTurnMetadataJpaRepository extends JpaRepository<RagChatTurnMetadata, UUID> {

    @EntityGraph(attributePaths = "citations")
    Optional<RagChatTurnMetadata> findByAssistantMessageId(UUID assistantMessageId);
}
