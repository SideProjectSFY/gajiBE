package com.gaji.scenario.domain.repository;

import com.gaji.scenario.domain.model.ScenarioTag;
import com.gaji.scenario.domain.model.ScenarioTagId;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ScenarioTagRepository {
    
    ScenarioTag save(ScenarioTag scenarioTag);
    
    Optional<ScenarioTag> findById(ScenarioTagId id);
    
    List<ScenarioTag> findAll();
    
    void deleteById(ScenarioTagId id);
    
    void deleteAll(Iterable<? extends ScenarioTag> entities);

    List<ScenarioTag> findByScenarioId(UUID scenarioId);
    
    List<ScenarioTag> findByTagId(UUID tagId);
}

