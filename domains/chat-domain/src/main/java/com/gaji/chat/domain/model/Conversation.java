package com.gaji.chat.domain.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "conversations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Conversation {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "scenario_id", nullable = false)
    private UUID scenarioId;

    @Column(name = "scenario_type", length = 50)
    private String scenarioType;

    @Column(name = "character_pgvector_id", length = 100)
    private String characterPgvectorId;

    @Column(name = "parent_conversation_id")
    private UUID parentConversationId;

    @Column(nullable = false)
    private String title;

    @Builder.Default
    @Column(name = "is_root", nullable = false)
    private Boolean isRoot = true;

    @Builder.Default
    @Column(name = "has_been_forked", nullable = false)
    private Boolean hasBeenForked = false;

    @Builder.Default
    @Column(name = "message_count", nullable = false)
    private Integer messageCount = 0;

    @Builder.Default
    @Column(name = "like_count", nullable = false)
    private Integer likeCount = 0;

    @Builder.Default
    @Column(name = "is_private", nullable = false)
    private Boolean isPrivate = false;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "conversation_id")
    @Builder.Default
    private java.util.List<Message> messages = new java.util.ArrayList<>();

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Joined fields (Transient)
    @Transient
    private String bookTitle;
    @Transient
    private String bookAuthor;
    @Transient
    private String bookCoverUrl;
    @Transient
    private UUID bookId;
    @Transient
    private String scenarioDescription;
}
