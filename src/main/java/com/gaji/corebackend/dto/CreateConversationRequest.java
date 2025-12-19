package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Request DTO for creating a new conversation
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateConversationRequest {

    @NotNull(message = "Scenario ID is required")
    private UUID scenarioId;

    // Optional: Will be auto-determined from scenario if not provided
    private String scenarioType; // 'root_user' or 'leaf_user'

    // Optional: Will use default character if not provided
    private String characterVectordbId;

    private String title;

    private Boolean isPrivate;
}
