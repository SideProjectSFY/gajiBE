package com.gaji.auth.infrastructure.persistence;

import com.gaji.auth.domain.model.UserAchievement;
import com.gaji.auth.domain.model.UserAchievementId;
import com.gaji.auth.domain.repository.UserAchievementRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class UserAchievementRepositoryImpl implements UserAchievementRepository {

    private final UserAchievementJpaRepository jpaRepository;

    @Override
    public UserAchievement save(UserAchievement userAchievement) {
        return jpaRepository.save(userAchievement);
    }

    @Override
    public Optional<UserAchievement> findById(UserAchievementId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UserAchievementId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public List<UserAchievement> findByUserId(UUID userId) {
        return jpaRepository.findByUserId(userId);
    }
}
