package com.gaji.social.domain.model;

import com.gaji.auth.domain.model.User;
import com.gaji.chat.domain.model.Conversation;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "conversation_likes")
@IdClass(ConversationLikeId.class)
@EntityListeners(AuditingEntityListener.class)
public class ConversationLike {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "conversation_id")
    private UUID conversationId;

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    // Associations for result mapping
    @Transient
    private User user;
    @Transient
    private Conversation conversation;
}
