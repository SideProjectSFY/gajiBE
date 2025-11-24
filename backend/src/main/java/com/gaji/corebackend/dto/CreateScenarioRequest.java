package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Request DTO for creating a new scenario
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateScenarioRequest {

    /**
     * Optional base scenario ID to link to
     */
    private UUID baseScenarioId;

    /**
     * Scenario title (required)
     */
    @NotBlank(message = "Title is required")
    @Size(max = 200, message = "Title must not exceed 200 characters")
    private String title;

    /**
     * Scenario description (optional)
     */
    @Size(max = 5000, message = "Description must not exceed 5000 characters")
    private String description;

    /**
     * The "What If?" question for this scenario (required)
     */
    @NotBlank(message = "What If question is required")
    @Size(max = 2000, message = "What If question must not exceed 2000 characters")
    private String whatIfQuestion;

    /**
     * Whether this scenario is public (default: false)
     */
    @Builder.Default
    private Boolean isPublic = false;
}
