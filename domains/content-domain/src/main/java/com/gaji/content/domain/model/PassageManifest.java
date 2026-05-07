package com.gaji.content.domain.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "rag_passage_manifests")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PassageManifest {

    @Id
    @Column(name = "passage_manifest_id", length = 80)
    private String passageManifestId;

    @Column(name = "novel_id", nullable = false)
    private UUID novelId;

    @Column(name = "source_novel_id", nullable = false, length = 120)
    private String sourceNovelId;

    @Column(name = "chunker_version", nullable = false, length = 80)
    private String chunkerVersion;

    @Column(name = "source_text_hash", nullable = false, length = 64)
    private String sourceTextHash;

    @Column(name = "embedding_model_id", nullable = false, length = 120)
    private String embeddingModelId;

    @Column(name = "embedding_config_hash", nullable = false, length = 64)
    private String embeddingConfigHash;

    @Column(name = "vector_collection_name", nullable = false, length = 120)
    private String vectorCollectionName;

    @Column(name = "elasticsearch_index_name", nullable = false, length = 120)
    private String elasticsearchIndexName;

    @Column(name = "expected_passage_count", nullable = false)
    private Integer expectedPassageCount;

    @Column(name = "vector_passage_count", nullable = false)
    private Integer vectorPassageCount;

    @Column(name = "elasticsearch_passage_count", nullable = false)
    private Integer elasticsearchPassageCount;

    @Column(name = "vector_status", nullable = false, length = 40)
    private String vectorStatus;

    @Column(name = "elasticsearch_status", nullable = false, length = 40)
    private String elasticsearchStatus;

    @Column(name = "reconciliation_status", nullable = false, length = 40)
    private String reconciliationStatus;

    @Column(name = "indexed_at", nullable = false)
    private LocalDateTime indexedAt;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    void prePersist() {
        LocalDateTime now = LocalDateTime.now();
        createdAt = now;
        updatedAt = now;
        if (indexedAt == null) {
            indexedAt = now;
        }
    }

    @PreUpdate
    void preUpdate() {
        updatedAt = LocalDateTime.now();
        if (indexedAt == null) {
            indexedAt = updatedAt;
        }
    }
}
