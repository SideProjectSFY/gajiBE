package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioLike;
import com.gaji.scenario.domain.model.ScenarioLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface ScenarioLikeJpaRepository extends JpaRepository<ScenarioLike, ScenarioLikeId>, QuerydslPredicateExecutor<ScenarioLike> {
    
    long countByScenarioId(UUID scenarioId);
    
    boolean existsByUserIdAndScenarioId(UUID userId, UUID scenarioId);
    
    Page<ScenarioLike> findByUserId(UUID userId, Pageable pageable);
}
