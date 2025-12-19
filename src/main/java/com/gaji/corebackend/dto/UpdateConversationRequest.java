package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO for updating conversation metadata
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateConversationRequest {

    private String title;
    private Boolean isPrivate;
}
