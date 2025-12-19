package com.gaji.corebackend.entity;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScenarioLike {

    private UUID userId;
    private UUID scenarioId;
    private String scenarioType;
    private LocalDateTime createdAt;
    
    // Relationships
    private User user;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ScenarioLikeId implements Serializable {
        private UUID userId;
        private UUID scenarioId;
    }
}
