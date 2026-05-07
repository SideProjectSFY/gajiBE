package com.gaji.scenario.domain.repository;

import com.gaji.scenario.domain.model.LeafUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public interface LeafUserScenarioRepository {
    
    LeafUserScenario save(LeafUserScenario leafUserScenario);
    
    Optional<LeafUserScenario> findById(UUID id);

    boolean existsById(UUID id);

    List<LeafUserScenario> findAllById(Iterable<UUID> ids);
    
    void deleteById(UUID id);

    List<LeafUserScenario> findByParentScenarioId(UUID parentScenarioId);
    
    List<LeafUserScenario> findByUserId(UUID userId);
    
    Page<LeafUserScenario> findByUserId(UUID userId, Pageable pageable);

    long countByParentScenarioId(UUID parentScenarioId);
    
    Page<LeafUserScenario> findByIsPrivateFalse(Pageable pageable);
    
    long countByIsPrivateFalse();
    
    boolean existsByParentScenarioIdAndUserId(UUID parentScenarioId, UUID userId);
    
    Page<LeafUserScenario> findAccessibleScenarios(UUID userId, Pageable pageable);

    long countAccessibleScenarios(UUID userId);
    
    List<Map<String, Object>> findScenarioTree(UUID rootId);
}

