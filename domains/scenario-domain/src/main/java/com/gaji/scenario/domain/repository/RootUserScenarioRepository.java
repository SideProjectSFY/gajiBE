package com.gaji.scenario.domain.repository;

import com.gaji.content.domain.model.ScenarioCategory;
import com.gaji.scenario.domain.model.RootUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface RootUserScenarioRepository {
    
    RootUserScenario save(RootUserScenario rootUserScenario);
    
    Optional<RootUserScenario> findById(UUID id);

    List<RootUserScenario> findAllById(Iterable<UUID> ids);
    
    void deleteById(UUID id);
    
    Page<RootUserScenario> findByUserId(UUID userId, Pageable pageable);
    
    long countByUserId(UUID userId);
    
    List<RootUserScenario> findByUserId(UUID userId);
    
    Page<RootUserScenario> findPublicByUserId(UUID userId, Pageable pageable);

    long countPublicByUserId(UUID userId);

    Page<RootUserScenario> findByIsPrivateFalse(Pageable pageable);
    
    long countByIsPrivateFalse();
    
    List<RootUserScenario> findByBaseScenarioId(UUID baseScenarioId);
    
    Page<RootUserScenario> findAccessibleScenarios(UUID userId, Pageable pageable);
    
    long countAccessibleScenarios(UUID userId);
    
    boolean existsByNovelIdAndContentHash(UUID novelId, String contentHash);
    
    Page<RootUserScenario> searchPublicScenarios(String query, Pageable pageable);
    
    long countSearchPublicScenarios(String query);
    
    Page<RootUserScenario> filterScenarios(ScenarioCategory category, UUID creatorId, Pageable pageable);
    
    long countFilterScenarios(ScenarioCategory category, UUID creatorId);

    void updateReferenceConversation(UUID scenarioId, UUID conversationId);
    
    Page<RootUserScenario> searchWithFilters(String query, ScenarioCategory category, UUID creatorId, Pageable pageable);

    long countSearchResults(String query, ScenarioCategory category, UUID creatorId);
}

