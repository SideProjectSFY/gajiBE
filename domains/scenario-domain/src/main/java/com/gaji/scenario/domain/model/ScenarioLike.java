package com.gaji.scenario.domain.model;

import com.gaji.auth.domain.model.User;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "scenario_likes")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(ScenarioLikeId.class)
@EntityListeners(AuditingEntityListener.class)
public class ScenarioLike {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "scenario_id")
    private UUID scenarioId;

    @Column(name = "scenario_type", nullable = false)
    private String scenarioType;

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @Transient // User is in auth-domain
    private User user;
}
