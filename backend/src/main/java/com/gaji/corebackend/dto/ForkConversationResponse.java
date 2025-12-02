package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Response DTO for conversation fork operation
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ForkConversationResponse {

    private UUID id;
    private UUID parentConversationId;
    private Integer copiedMessageCount;
    private Integer messageCount;
    private Boolean isRoot;
}
