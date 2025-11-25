package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Request DTO for creating a new scenario (Unified Modal Design)
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateScenarioRequest {

    /**
     * Novel ID (book) this scenario is based on (required)
     */
    @NotNull(message = "Novel ID is required")
    private UUID novelId;

    /**
     * Optional base scenario ID to link to
     */
    private UUID baseScenarioId;

    /**
     * Scenario title (required, max 100 chars)
     */
    @NotBlank(message = "Scenario title is required")
    @Size(max = 100, message = "Scenario title must not exceed 100 characters")
    private String scenarioTitle;

    /**
     * Character changes (optional, min 10 chars if provided)
     * Validated in service layer for "at least one type" rule
     */
    private String characterChanges;

    /**
     * Event alterations (optional, min 10 chars if provided)
     * Validated in service layer for "at least one type" rule
     */
    private String eventAlterations;

    /**
     * Setting modifications (optional, min 10 chars if provided)
     * Validated in service layer for "at least one type" rule
     */
    private String settingModifications;

    /**
     * Scenario description (optional, for backward compatibility)
     */
    @Size(max = 5000, message = "Description must not exceed 5000 characters")
    private String description;

    /**
     * The "What If?" question for this scenario (optional, auto-generated from types if not provided)
     */
    @Size(max = 2000, message = "What If question must not exceed 2000 characters")
    private String whatIfQuestion;

    /**
     * Whether this scenario is public (default: false)
     */
    @Builder.Default
    private Boolean isPublic = false;
}
