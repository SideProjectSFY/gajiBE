package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.LeafUserScenario;
import com.gaji.corebackend.entity.RootUserScenario;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for scenario data
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScenarioResponse {

    private UUID id;
    private UUID userId;
    private UUID baseScenarioId;
    private UUID parentScenarioId;
    private String title;
    private String description;
    private String whatIfQuestion;
    private Boolean isPublic;
    private Integer forkCount;
    private ScenarioType scenarioType;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Enum to distinguish between root and leaf scenarios
     */
    public enum ScenarioType {
        ROOT,
        LEAF
    }

    /**
     * Create response from root user scenario entity
     */
    public static ScenarioResponse from(RootUserScenario entity) {
        return ScenarioResponse.builder()
                .id(entity.getId())
                .userId(entity.getUserId())
                .baseScenarioId(entity.getBaseScenarioId())
                .parentScenarioId(null) // Root scenarios have no parent
                .title(entity.getTitle())
                .description(entity.getDescription())
                .whatIfQuestion(entity.getWhatIfQuestion())
                .isPublic(entity.getIsPublic())
                .forkCount(entity.getForkCount())
                .scenarioType(ScenarioType.ROOT)
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    /**
     * Create response from leaf user scenario entity
     */
    public static ScenarioResponse from(LeafUserScenario entity) {
        return ScenarioResponse.builder()
                .id(entity.getId())
                .userId(entity.getUserId())
                .baseScenarioId(null) // Leaf scenarios don't have base scenario
                .parentScenarioId(entity.getParentScenarioId())
                .title(entity.getTitle())
                .description(entity.getDescription())
                .whatIfQuestion(entity.getWhatIfQuestion())
                .isPublic(entity.getIsPublic())
                .forkCount(null) // Leaf scenarios can't be forked
                .scenarioType(ScenarioType.LEAF)
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }
}
