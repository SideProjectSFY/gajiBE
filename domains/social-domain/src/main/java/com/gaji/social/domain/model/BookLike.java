package com.gaji.social.domain.model;

import com.gaji.auth.domain.model.User;
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
@Table(name = "book_likes")
@IdClass(BookLikeId.class)
@EntityListeners(AuditingEntityListener.class)
public class BookLike {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "book_id")
    private UUID bookId;

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    // Associations for result mapping
    @Transient
    private User user;
}
