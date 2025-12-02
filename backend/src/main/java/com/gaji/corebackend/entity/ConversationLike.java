package com.gaji.corebackend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "conversation_likes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(ConversationLike.ConversationLikeId.class)
public class ConversationLike {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "conversation_id")
    private UUID conversationId;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "conversation_id", insertable = false, updatable = false)
    private Conversation conversation;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ConversationLikeId implements Serializable {
        private UUID userId;
        private UUID conversationId;
    }
}
