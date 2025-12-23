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
    
    @JsonProperty("scenario_id")
    private String scenarioId;
    
    // What If 시나리오 정보
    @JsonProperty("what_if_question")
    private String whatIfQuestion;
    
    @JsonProperty("character_changes")
    private String characterChanges;
    
    @JsonProperty("event_alterations")
    private String eventAlterations;
    
    @JsonProperty("setting_modifications")
    private String settingModifications;
    
    // 캐릭터 정보
    @JsonProperty("character_name")
    private String characterName;
    
    @JsonProperty("character_persona")
    private String characterPersona;
    
    @JsonProperty("character_speaking_style")
    private String characterSpeakingStyle;
    
    // 책 정보
    @JsonProperty("book_title")
    private String bookTitle;
    
    @JsonProperty("book_author")
    private String bookAuthor;
    
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
