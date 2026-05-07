package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.LeafUserScenario;
import com.gaji.scenario.domain.repository.LeafUserScenarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class LeafUserScenarioRepositoryImpl implements LeafUserScenarioRepository {

    private final LeafUserScenarioJpaRepository jpaRepository;

    @Override
    public LeafUserScenario save(LeafUserScenario leafUserScenario) {
        return jpaRepository.save(leafUserScenario);
    }

    @Override
    public Optional<LeafUserScenario> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public boolean existsById(UUID id) {
        return jpaRepository.existsById(id);
    }

    @Override
    public List<LeafUserScenario> findAllById(Iterable<UUID> ids) {
        return jpaRepository.findAllById(ids);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public List<LeafUserScenario> findByParentScenarioId(UUID parentScenarioId) {
        return jpaRepository.findByParentScenarioId(parentScenarioId);
    }

    @Override
    public List<LeafUserScenario> findByUserId(UUID userId) {
        return jpaRepository.findByUserId(userId);
    }

    @Override
    public Page<LeafUserScenario> findByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserId(userId, pageable);
    }

    @Override
    public long countByParentScenarioId(UUID parentScenarioId) {
        return jpaRepository.countByParentScenarioId(parentScenarioId);
    }

    @Override
    public Page<LeafUserScenario> findByIsPrivateFalse(Pageable pageable) {
        return jpaRepository.findByIsPrivateFalse(pageable);
    }

    @Override
    public long countByIsPrivateFalse() {
        return jpaRepository.countByIsPrivateFalse();
    }

    @Override
    public boolean existsByParentScenarioIdAndUserId(UUID parentScenarioId, UUID userId) {
        return jpaRepository.existsByParentScenarioIdAndUserId(parentScenarioId, userId);
    }

    @Override
    public Page<LeafUserScenario> findAccessibleScenarios(UUID userId, Pageable pageable) {
        return jpaRepository.findAccessibleScenarios(userId, pageable);
    }

    @Override
    public long countAccessibleScenarios(UUID userId) {
        return jpaRepository.countAccessibleScenarios(userId);
    }

    @Override
    public List<Map<String, Object>> findScenarioTree(UUID rootId) {
        return jpaRepository.findScenarioTree(rootId);
    }
}
