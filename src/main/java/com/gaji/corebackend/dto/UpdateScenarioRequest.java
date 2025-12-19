package com.gaji.corebackend.dto;

import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO for updating an existing scenario
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateScenarioRequest {

    /**
     * Updated scenario title (optional)
     */
    @Size(max = 200, message = "Title must not exceed 200 characters")
    private String title;

    /**
     * Updated scenario description (optional)
     */
    @Size(max = 5000, message = "Description must not exceed 5000 characters")
    private String description;

    /**
     * Updated "What If?" question (optional)
     */
    @Size(max = 2000, message = "What If question must not exceed 2000 characters")
    private String whatIfQuestion;

    /**
     * Updated visibility (optional)
     */
    private Boolean isPrivate;
}
