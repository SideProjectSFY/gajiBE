package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioTag;
import com.gaji.scenario.domain.model.ScenarioTagId;
import com.gaji.scenario.domain.repository.ScenarioTagRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ScenarioTagRepositoryImpl implements ScenarioTagRepository {

    private final ScenarioTagJpaRepository jpaRepository;

    @Override
    public ScenarioTag save(ScenarioTag scenarioTag) {
        return jpaRepository.save(scenarioTag);
    }

    @Override
    public Optional<ScenarioTag> findById(ScenarioTagId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public List<ScenarioTag> findAll() {
        return jpaRepository.findAll();
    }

    @Override
    public void deleteById(ScenarioTagId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public void deleteAll(Iterable<? extends ScenarioTag> entities) {
        jpaRepository.deleteAll(entities);
    }

    @Override
    public List<ScenarioTag> findByScenarioId(UUID scenarioId) {
        return jpaRepository.findByScenarioId(scenarioId);
    }

    @Override
    public List<ScenarioTag> findByTagId(UUID tagId) {
        return jpaRepository.findByTagId(tagId);
    }
}
