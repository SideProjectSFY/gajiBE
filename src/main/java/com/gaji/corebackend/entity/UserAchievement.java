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
public class UserAchievement {

    private UUID userId;
    private String achievementId;
    private LocalDateTime unlockedAt;
    
    // Relationships
    private User user;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserAchievementId implements Serializable {
        private UUID userId;
        private String achievementId;
    }
}
