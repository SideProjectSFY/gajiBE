package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO for updating novel ingestion status
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateNovelStatusRequest {

    @NotBlank(message = "Ingestion status is required")
    @Size(max = 50, message = "Ingestion status must be at most 50 characters")
    private String ingestionStatus;
}
