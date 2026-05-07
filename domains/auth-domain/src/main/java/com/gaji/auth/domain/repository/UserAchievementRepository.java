package com.gaji.auth.domain.repository;

import com.gaji.auth.domain.model.UserAchievement;
import com.gaji.auth.domain.model.UserAchievementId;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserAchievementRepository {
    
    UserAchievement save(UserAchievement userAchievement);
    
    Optional<UserAchievement> findById(UserAchievementId id);
    
    void deleteById(UserAchievementId id);

    List<UserAchievement> findByUserId(UUID userId);
}

