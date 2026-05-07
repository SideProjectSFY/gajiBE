package com.gaji.scenario.domain.repository;

import com.gaji.scenario.domain.model.ScenarioComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface ScenarioCommentRepository {
    
    ScenarioComment save(ScenarioComment scenarioComment);
    
    Optional<ScenarioComment> findById(UUID id);
    
    void deleteById(UUID id);

    Page<ScenarioComment> findByScenarioIdOrderByCreatedAtDesc(UUID scenarioId, Pageable pageable);
    
    long countByScenarioId(UUID scenarioId);
}

