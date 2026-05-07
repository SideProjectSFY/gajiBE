package com.gaji.ai.api.dto;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record AiChatCompletionRequest(
        @NotBlank
        @Size(max = 4000)
        String prompt,

        String model,

        @Min(0)
        @Max(2)
        Double temperature,

        @JsonProperty("max_output_tokens")
        @JsonAlias("maxOutputTokens")
        @Min(1)
        @Max(4096)
        Integer maxOutputTokens,

        @JsonProperty("thinking_budget")
        @JsonAlias("thinkingBudget")
        @Min(0)
        @Max(24576)
        Integer thinkingBudget,

        @Valid
        RagOptions rag
) {
    public String resolvedModel() {
        return model == null || model.isBlank() ? "gemini-2.5-flash" : model.trim();
    }

    @JsonInclude(JsonInclude.Include.NON_NULL)
    public record RagOptions(
            Boolean enabled,

            @JsonProperty("novel_id")
            @JsonAlias("novelId")
            String novelId,

            String query,

            String mode,

            @JsonProperty("top_k")
            @JsonAlias("topK")
            @Min(1)
            @Max(12)
            Integer topK,

            @JsonProperty("max_context_passages")
            @JsonAlias("maxContextPassages")
            @Min(1)
            @Max(8)
            Integer maxContextPassages,

            @JsonProperty("candidate_k_vector")
            @JsonAlias("candidateKVector")
            @Min(1)
            @Max(500)
            Integer candidateKVector,

            @JsonProperty("candidate_k_bm25")
            @JsonAlias("candidateKBm25")
            @Min(1)
            @Max(500)
            Integer candidateKBm25,

            @Valid
            SearchFilters filters,

            @JsonProperty("fallback_on_error")
            @JsonAlias("fallbackOnError")
            Boolean fallbackOnError
    ) {
        public boolean isEnabled() {
            return Boolean.TRUE.equals(enabled);
        }
    }

    @JsonInclude(JsonInclude.Include.NON_NULL)
    public record SearchFilters(
            String chapter,

            @JsonProperty("character_names")
            @JsonAlias("characterNames")
            List<String> characterNames
    ) {
    }
}
