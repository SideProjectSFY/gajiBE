package com.gaji.content.application;

import com.gaji.content.domain.model.PassageManifest;
import com.gaji.content.infrastructure.persistence.NovelJpaRepository;
import com.gaji.content.infrastructure.persistence.PassageManifestJpaRepository;
import com.gaji.shared.contract.dto.PassageManifestRequest;
import com.gaji.shared.contract.dto.PassageManifestResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class PassageManifestService {

    private final PassageManifestJpaRepository passageManifestRepository;
    private final NovelJpaRepository novelRepository;

    @Transactional
    public PassageManifestResponse upsert(PassageManifestRequest request) {
        if (!novelRepository.existsById(request.getNovelId())) {
            throw new IllegalArgumentException("Novel not found: " + request.getNovelId());
        }

        PassageManifest manifest = passageManifestRepository
                .findById(request.getPassageManifestId())
                .orElseGet(PassageManifest::new);

        apply(manifest, request);
        PassageManifest saved = passageManifestRepository.save(manifest);
        return toResponse(saved);
    }

    @Transactional(readOnly = true)
    public PassageManifestResponse get(String passageManifestId) {
        return passageManifestRepository.findById(passageManifestId)
                .map(this::toResponse)
                .orElseThrow(() -> new IllegalArgumentException("Passage manifest not found: " + passageManifestId));
    }

    @Transactional(readOnly = true)
    public List<PassageManifestResponse> listByNovel(UUID novelId) {
        return passageManifestRepository.findByNovelIdOrderByIndexedAtDesc(novelId).stream()
                .map(this::toResponse)
                .toList();
    }

    private void apply(PassageManifest manifest, PassageManifestRequest request) {
        manifest.setPassageManifestId(request.getPassageManifestId());
        manifest.setNovelId(request.getNovelId());
        manifest.setSourceNovelId(request.getSourceNovelId());
        manifest.setChunkerVersion(request.getChunkerVersion());
        manifest.setSourceTextHash(request.getSourceTextHash());
        manifest.setEmbeddingModelId(request.getEmbeddingModelId());
        manifest.setEmbeddingConfigHash(request.getEmbeddingConfigHash());
        manifest.setVectorCollectionName(request.getVectorCollectionName());
        manifest.setElasticsearchIndexName(request.getElasticsearchIndexName());
        manifest.setExpectedPassageCount(defaultInt(request.getExpectedPassageCount()));
        manifest.setVectorPassageCount(defaultInt(request.getVectorPassageCount()));
        manifest.setElasticsearchPassageCount(defaultInt(request.getElasticsearchPassageCount()));
        manifest.setVectorStatus(defaultString(request.getVectorStatus(), "pending"));
        manifest.setElasticsearchStatus(defaultString(request.getElasticsearchStatus(), "pending"));
        manifest.setReconciliationStatus(defaultString(request.getReconciliationStatus(), "pending"));
        manifest.setIndexedAt(LocalDateTime.now());
    }

    private PassageManifestResponse toResponse(PassageManifest manifest) {
        return PassageManifestResponse.builder()
                .passageManifestId(manifest.getPassageManifestId())
                .novelId(manifest.getNovelId())
                .sourceNovelId(manifest.getSourceNovelId())
                .chunkerVersion(manifest.getChunkerVersion())
                .sourceTextHash(manifest.getSourceTextHash())
                .embeddingModelId(manifest.getEmbeddingModelId())
                .embeddingConfigHash(manifest.getEmbeddingConfigHash())
                .vectorCollectionName(manifest.getVectorCollectionName())
                .elasticsearchIndexName(manifest.getElasticsearchIndexName())
                .expectedPassageCount(manifest.getExpectedPassageCount())
                .vectorPassageCount(manifest.getVectorPassageCount())
                .elasticsearchPassageCount(manifest.getElasticsearchPassageCount())
                .vectorStatus(manifest.getVectorStatus())
                .elasticsearchStatus(manifest.getElasticsearchStatus())
                .reconciliationStatus(manifest.getReconciliationStatus())
                .indexedAt(manifest.getIndexedAt())
                .createdAt(manifest.getCreatedAt())
                .updatedAt(manifest.getUpdatedAt())
                .build();
    }

    private int defaultInt(Integer value) {
        return value == null ? 0 : value;
    }

    private String defaultString(String value, String fallback) {
        return value == null || value.isBlank() ? fallback : value;
    }
}
