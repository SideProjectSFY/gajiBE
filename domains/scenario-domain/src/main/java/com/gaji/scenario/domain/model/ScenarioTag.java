package com.gaji.scenario.domain.model;

import com.gaji.content.domain.model.Tag;
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
@IdClass(ScenarioTagId.class)
public class ScenarioTag {

    @Id
    @Column(name = "scenario_id")
    private UUID scenarioId;

    @Id
    @Column(name = "tag_id")
    private UUID tagId;

    @Column(name = "scenario_type", nullable = false)
    private String scenarioType;
    
    @Transient // Tag is in content-domain
    private Tag tag;
}
