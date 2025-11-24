package com.gaji.corebackend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Root user scenario entity - Root-level "What If?" scenarios
 * Can be forked to create LeafUserScenarios (max depth 1)
 */
@Entity
@Table(name = "root_user_scenarios")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RootUserScenario {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "base_scenario_id")
    private UUID baseScenarioId;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "what_if_question", nullable = false, columnDefinition = "TEXT")
    private String whatIfQuestion;

    @Column(name = "is_public")
    @Builder.Default
    private Boolean isPublic = false;

    @Column(name = "fork_count")
    @Builder.Default
    private Integer forkCount = 0;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    /**
     * Increment fork count when this scenario is forked
     */
    public void incrementForkCount() {
        this.forkCount = (this.forkCount == null ? 0 : this.forkCount) + 1;
    }
}
