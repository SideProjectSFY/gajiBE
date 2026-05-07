package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface ScenarioCommentJpaRepository extends JpaRepository<ScenarioComment, UUID>, QuerydslPredicateExecutor<ScenarioComment> {
    Page<ScenarioComment> findByScenarioIdOrderByCreatedAtDesc(UUID scenarioId, Pageable pageable);
    
    long countByScenarioId(UUID scenarioId);
}
