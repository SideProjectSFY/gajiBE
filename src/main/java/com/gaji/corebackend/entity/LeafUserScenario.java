package com.gaji.corebackend.entity;

import com.gaji.corebackend.enums.ScenarioType;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Leaf user scenario entity - Forked scenarios from root scenarios
 * Cannot be forked again (max depth 1)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LeafUserScenario {

    private UUID id;
    private UUID userId;
    private UUID parentScenarioId;
    private String title;
    private String description;
    private String whatIfQuestion;
    private ScenarioType scenarioType;

    @Builder.Default
    private Boolean isPrivate = false;

    private ScenarioCategory scenarioCategory;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
