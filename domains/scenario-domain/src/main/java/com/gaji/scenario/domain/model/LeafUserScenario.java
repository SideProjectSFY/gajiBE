package com.gaji.scenario.domain.model;

import com.gaji.common.enums.ScenarioType;
import com.gaji.content.domain.model.ScenarioCategory;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Leaf user scenario entity - Forked scenarios from root scenarios
 * Cannot be forked again (max depth 1)
 */
@Entity
@Table(name = "leaf_user_scenarios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class LeafUserScenario {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "parent_scenario_id", nullable = false)
    private UUID parentScenarioId;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "what_if_question", columnDefinition = "TEXT")
    private String whatIfQuestion;

    @Enumerated(EnumType.STRING)
    @Column(name = "scenario_type", length = 50)
    private ScenarioType scenarioType;

    @Builder.Default
    @Column(name = "is_private", nullable = false)
    private Boolean isPrivate = false;

    @Enumerated(EnumType.STRING)
    @Column(name = "scenario_category", length = 50)
    private ScenarioCategory scenarioCategory;

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
