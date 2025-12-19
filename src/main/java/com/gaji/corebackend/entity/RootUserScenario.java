package com.gaji.corebackend.entity;

import com.gaji.corebackend.enums.ScenarioType;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Root user scenario entity - Root-level "What If?" scenarios
 * Can be forked to create LeafUserScenarios (max depth 1)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RootUserScenario {

    private UUID id;
    private UUID userId;
    private UUID baseScenarioId;
    private UUID novelId;
    private String title;
    private String description;
    private String whatIfQuestion;
    private String characterChanges;
    private String eventAlterations;
    private String settingModifications;
    private ScenarioType scenarioType;
    private ScenarioCategory scenarioCategory;

    @Builder.Default
    private Boolean isPrivate = false;

    @Builder.Default
    private Integer forkCount = 0;

    private String contentHash;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Increment fork count when this scenario is forked
     */
    public void incrementForkCount() {
        this.forkCount = (this.forkCount == null ? 0 : this.forkCount) + 1;
    }
}
