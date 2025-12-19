package com.gaji.corebackend.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * FastAPI AI 생성 요청 DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FastAPIGenerationRequest {
    
    @JsonProperty("conversation_id")
    private String conversationId;
    
    @JsonProperty("scenario_context")
    private String scenarioContext;
    
    @JsonProperty("user_message")
    private String userMessage;
    
    private List<MessageHistory> history;
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class MessageHistory {
        private String role;
        private String content;
    }
}
