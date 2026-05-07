package com.gaji.shared.contract.dto;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RagChatSourceResponse {

    private UUID conversationId;
    private UUID assistantMessageId;
    private UUID ragMetadataId;
    private UUID novelId;
    private String groundingStatus;
    private Boolean fallbackUsed;
    private String fallbackReason;
    private List<CitationSource> citations;
    private List<String> missingPassageIds;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CitationSource {
        private UUID citationId;
        private String passageId;
        private Integer finalRank;
        private Integer vectorRank;
        private Integer bm25Rank;
        private String manifestId;
        private String chapter;
        private Boolean sourceAvailable;
        private String text;
        private JsonNode metadata;
    }
}
