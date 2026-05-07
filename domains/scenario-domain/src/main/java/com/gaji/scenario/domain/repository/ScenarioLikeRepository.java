package com.gaji.scenario.domain.repository;

import com.gaji.scenario.domain.model.ScenarioLike;
import com.gaji.scenario.domain.model.ScenarioLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface ScenarioLikeRepository {
    
    ScenarioLike save(ScenarioLike scenarioLike);
    
    Optional<ScenarioLike> findById(ScenarioLikeId id);
    
    void deleteById(ScenarioLikeId id);

    long countByScenarioId(UUID scenarioId);
    
    boolean existsByUserIdAndScenarioId(UUID userId, UUID scenarioId);
    
    Page<ScenarioLike> findByUserId(UUID userId, Pageable pageable);
}

