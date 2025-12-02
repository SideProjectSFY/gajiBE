package com.gaji.corebackend.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@Entity
@Table(name = "scenario_tags")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@IdClass(ScenarioTag.ScenarioTagId.class)
public class ScenarioTag {

    @Id
    @Column(name = "scenario_id")
    private UUID scenarioId;

    @Id
    @Column(name = "tag_id")
    private UUID tagId;

    @Column(name = "scenario_type", nullable = false)
    private String scenarioType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id", insertable = false, updatable = false)
    private Tag tag;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ScenarioTagId implements Serializable {
        private UUID scenarioId;
        private UUID tagId;
    }
}
