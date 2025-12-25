package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * 기준 대화 설정 요청 DTO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SetReferenceConversationRequest {
    
    @NotNull(message = "Conversation ID is required")
    private UUID conversationId;
}

