package com.gaji.chat.domain.model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "rag_chat_turns")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RagChatTurnMetadata {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "conversation_id", nullable = false)
    private UUID conversationId;

    @Column(name = "user_message_id")
    private UUID userMessageId;

    @Column(name = "assistant_message_id", nullable = false)
    private UUID assistantMessageId;

    @Column(name = "novel_id")
    private UUID novelId;

    @Column(name = "provider", length = 50)
    private String provider;

    @Column(name = "model", length = 100)
    private String model;

    @Column(name = "mode", length = 32)
    private String mode;

    @Column(name = "grounding_status", length = 50)
    private String groundingStatus;

    @Builder.Default
    @Column(name = "fallback_used", nullable = false)
    private Boolean fallbackUsed = false;

    @Column(name = "fallback_reason", length = 120)
    private String fallbackReason;

    @Column(name = "ranking_policy", length = 120)
    private String rankingPolicy;

    @Column(name = "query_source", length = 32)
    private String querySource;

    @Builder.Default
    @Column(name = "passage_count", nullable = false)
    private Integer passageCount = 0;

    @Builder.Default
    @Column(name = "citation_count", nullable = false)
    private Integer citationCount = 0;

    @Column(name = "token_usage")
    private Integer tokenUsage;

    @Column(name = "provider_elapsed_ms")
    private Double providerElapsedMs;

    @Column(name = "total_ms")
    private Double totalMs;

    @Column(name = "embedding_ms")
    private Double embeddingMs;

    @Column(name = "vector_search_ms")
    private Double vectorSearchMs;

    @Column(name = "bm25_search_ms")
    private Double bm25SearchMs;

    @Column(name = "fusion_ms")
    private Double fusionMs;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Builder.Default
    @OneToMany(mappedBy = "turn", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RagChatTurnCitation> citations = new ArrayList<>();

    public void addCitation(RagChatTurnCitation citation) {
        citations.add(citation);
        citation.setTurn(this);
    }

    @PrePersist
    void prePersist() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
        if (fallbackUsed == null) {
            fallbackUsed = false;
        }
        if (passageCount == null) {
            passageCount = 0;
        }
        citationCount = citations == null ? 0 : citations.size();
    }
}
