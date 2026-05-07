package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioTag;
import com.gaji.scenario.domain.model.ScenarioTagId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.List;
import java.util.UUID;

public interface ScenarioTagJpaRepository extends JpaRepository<ScenarioTag, ScenarioTagId>, QuerydslPredicateExecutor<ScenarioTag> {
    
    List<ScenarioTag> findByScenarioId(UUID scenarioId);
    
    List<ScenarioTag> findByTagId(UUID tagId);
}
