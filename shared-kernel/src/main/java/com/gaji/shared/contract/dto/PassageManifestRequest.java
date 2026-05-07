package com.gaji.shared.contract.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PassageManifestRequest {

    @NotBlank
    private String passageManifestId;

    @NotNull
    private UUID novelId;

    @NotBlank
    private String sourceNovelId;

    @NotBlank
    private String chunkerVersion;

    @NotBlank
    private String sourceTextHash;

    @NotBlank
    private String embeddingModelId;

    @NotBlank
    private String embeddingConfigHash;

    @NotBlank
    private String vectorCollectionName;

    @NotBlank
    private String elasticsearchIndexName;

    private Integer expectedPassageCount;
    private Integer vectorPassageCount;
    private Integer elasticsearchPassageCount;
    private String vectorStatus;
    private String elasticsearchStatus;
    private String reconciliationStatus;
}
