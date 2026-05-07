package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.ScenarioComment;
import com.gaji.scenario.domain.repository.ScenarioCommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class ScenarioCommentRepositoryImpl implements ScenarioCommentRepository {

    private final ScenarioCommentJpaRepository jpaRepository;

    @Override
    public ScenarioComment save(ScenarioComment scenarioComment) {
        return jpaRepository.save(scenarioComment);
    }

    @Override
    public Optional<ScenarioComment> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Page<ScenarioComment> findByScenarioIdOrderByCreatedAtDesc(UUID scenarioId, Pageable pageable) {
        return jpaRepository.findByScenarioIdOrderByCreatedAtDesc(scenarioId, pageable);
    }

    @Override
    public long countByScenarioId(UUID scenarioId) {
        return jpaRepository.countByScenarioId(scenarioId);
    }
}
