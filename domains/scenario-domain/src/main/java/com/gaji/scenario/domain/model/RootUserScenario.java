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
@EntityListeners(AuditingEntityListener.class)
public class RootUserScenario {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "base_scenario_id")
    private UUID baseScenarioId;

    @Column(name = "novel_id")
    private UUID novelId;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "what_if_question", columnDefinition = "TEXT")
    private String whatIfQuestion;

    @Column(name = "character_changes", columnDefinition = "TEXT")
    private String characterChanges;

    @Column(name = "event_alterations", columnDefinition = "TEXT")
    private String eventAlterations;

    @Column(name = "setting_modifications", columnDefinition = "TEXT")
    private String settingModifications;

    @Enumerated(EnumType.STRING)
    @Column(name = "scenario_type", length = 50)
    private ScenarioType scenarioType;

    @Enumerated(EnumType.STRING)
    @Column(name = "scenario_category", length = 50)
    private ScenarioCategory scenarioCategory;

    @Builder.Default
    @Column(name = "is_private", nullable = false)
    private Boolean isPrivate = false;

    @Builder.Default
    @Column(name = "fork_count", nullable = false)
    private Integer forkCount = 0;

    @Column(name = "content_hash", length = 64)
    private String contentHash;
    
    // 기준 대화 ID - 시나리오 생성자가 저장한 대화, 포크 시 이 대화의 메시지를 복사
    @Column(name = "reference_conversation_id")
    private UUID referenceConversationId;
    
    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    /**
     * Increment fork count when this scenario is forked
     */
    public void incrementForkCount() {
        this.forkCount = (this.forkCount == null ? 0 : this.forkCount) + 1;
    }
}
