package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.RagChatTurnMetadata;
import com.gaji.chat.domain.repository.RagChatTurnMetadataRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class RagChatTurnMetadataRepositoryImpl implements RagChatTurnMetadataRepository {

    private final RagChatTurnMetadataJpaRepository jpaRepository;

    @Override
    public RagChatTurnMetadata save(RagChatTurnMetadata metadata) {
        return jpaRepository.save(metadata);
    }

    @Override
    public Optional<RagChatTurnMetadata> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public Optional<RagChatTurnMetadata> findByAssistantMessageId(UUID assistantMessageId) {
        return jpaRepository.findByAssistantMessageId(assistantMessageId);
    }
}
