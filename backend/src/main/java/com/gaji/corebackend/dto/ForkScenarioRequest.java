package com.gaji.corebackend.dto;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO for forking a scenario
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ForkScenarioRequest {

    /**
     * Optional custom title for the forked scenario.
     * If not provided, will use "Fork of [original title]"
     */
    @Size(max = 200, message = "Title must not exceed 200 characters")
    private String title;

    /**
     * Optional custom description for the forked scenario.
     */
    @Size(max = 5000, message = "Description must not exceed 5000 characters")
    private String description;

    /**
     * Optional custom "What If?" question for the fork.
     * If not provided, will inherit from parent.
     */
    @Size(max = 2000, message = "What If question must not exceed 2000 characters")
    private String whatIfQuestion;

    /**
     * Whether the forked scenario is public (default: false)
     */
    @Builder.Default
    private Boolean isPublic = false;
}
