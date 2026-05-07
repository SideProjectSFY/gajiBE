package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioLike;
import com.gaji.scenario.domain.model.ScenarioLikeId;
import com.gaji.scenario.domain.repository.ScenarioLikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ScenarioLikeRepositoryImpl implements ScenarioLikeRepository {

    private final ScenarioLikeJpaRepository jpaRepository;

    @Override
    public ScenarioLike save(ScenarioLike scenarioLike) {
        return jpaRepository.save(scenarioLike);
    }

    @Override
    public Optional<ScenarioLike> findById(ScenarioLikeId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(ScenarioLikeId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public long countByScenarioId(UUID scenarioId) {
        return jpaRepository.countByScenarioId(scenarioId);
    }

    @Override
    public boolean existsByUserIdAndScenarioId(UUID userId, UUID scenarioId) {
        return jpaRepository.existsByUserIdAndScenarioId(userId, scenarioId);
    }

    @Override
    public Page<ScenarioLike> findByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserId(userId, pageable);
    }
}
