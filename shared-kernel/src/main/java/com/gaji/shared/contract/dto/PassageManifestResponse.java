package com.gaji.shared.contract.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PassageManifestResponse {

    private String passageManifestId;
    private UUID novelId;
    private String sourceNovelId;
    private String chunkerVersion;
    private String sourceTextHash;
    private String embeddingModelId;
    private String embeddingConfigHash;
    private String vectorCollectionName;
    private String elasticsearchIndexName;
    private Integer expectedPassageCount;
    private Integer vectorPassageCount;
    private Integer elasticsearchPassageCount;
    private String vectorStatus;
    private String elasticsearchStatus;
    private String reconciliationStatus;
    private LocalDateTime indexedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
