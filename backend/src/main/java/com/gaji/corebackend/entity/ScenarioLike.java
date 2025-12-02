package com.gaji.corebackend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

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
@IdClass(ScenarioLike.ScenarioLikeId.class)
public class ScenarioLike {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "scenario_id")
    private UUID scenarioId;

    @Column(name = "scenario_type", nullable = false)
    private String scenarioType;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ScenarioLikeId implements Serializable {
        private UUID userId;
        private UUID scenarioId;
    }
}
