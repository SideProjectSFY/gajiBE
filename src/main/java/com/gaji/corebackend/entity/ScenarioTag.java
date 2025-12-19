package com.gaji.corebackend.entity;

import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScenarioTag {

    private UUID scenarioId;
    private UUID tagId;
    private String scenarioType;
    
    // Relationships
    private Tag tag;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ScenarioTagId implements Serializable {
        private UUID scenarioId;
        private UUID tagId;
    }
}
