package com.gaji.auth.domain.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "user_achievements")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(UserAchievementId.class)
@EntityListeners(AuditingEntityListener.class)
public class UserAchievement {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "achievement_id", length = 50)
    private String achievementId;

    @CreatedDate
    @Column(name = "unlocked_at", updatable = false)
    private LocalDateTime unlockedAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;
}
