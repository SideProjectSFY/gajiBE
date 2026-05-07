package com.gaji.chat.domain.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "rag_chat_turn_citations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RagChatTurnCitation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rag_chat_turn_id", nullable = false)
    private RagChatTurnMetadata turn;

    @Column(name = "passage_id", nullable = false, length = 500)
    private String passageId;

    @Column(name = "final_rank")
    private Integer finalRank;

    @Column(name = "vector_rank")
    private Integer vectorRank;

    @Column(name = "bm25_rank")
    private Integer bm25Rank;

    @Column(name = "manifest_id", length = 120)
    private String manifestId;

    @Column(name = "chapter", length = 80)
    private String chapter;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    void prePersist() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
}
