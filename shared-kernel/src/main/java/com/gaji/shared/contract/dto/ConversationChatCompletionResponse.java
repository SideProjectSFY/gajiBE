package com.gaji.shared.contract.dto;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Synchronous chat completion response for learner conversation turns.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConversationChatCompletionResponse {

    private MessageResponse userMessage;
    private MessageResponse assistantMessage;
    private JsonNode rag;
    private UUID ragMetadataId;
    private String provider;
    private String model;
    private Integer tokenUsage;
    private Double providerElapsedMs;
}
