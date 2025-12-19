package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScenarioComment {

    private UUID id;
    private UUID userId;
    private UUID scenarioId;
    private String scenarioType;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Relationships
    private User user;
}
