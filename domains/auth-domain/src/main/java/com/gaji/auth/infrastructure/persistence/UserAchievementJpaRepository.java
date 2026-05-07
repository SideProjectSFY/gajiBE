package com.gaji.auth.infrastructure.persistence;

import com.gaji.auth.domain.model.UserAchievement;
import com.gaji.auth.domain.model.UserAchievementId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.List;
import java.util.UUID;

public interface UserAchievementJpaRepository extends JpaRepository<UserAchievement, UserAchievementId>, QuerydslPredicateExecutor<UserAchievement> {
    List<UserAchievement> findByUserId(UUID userId);
}
