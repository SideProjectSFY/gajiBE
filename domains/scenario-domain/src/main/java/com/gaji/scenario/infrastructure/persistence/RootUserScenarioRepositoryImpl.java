package com.gaji.scenario.infrastructure.persistence;

import com.gaji.content.domain.model.ScenarioCategory;
import com.gaji.scenario.domain.model.RootUserScenario;
import com.gaji.scenario.domain.repository.RootUserScenarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class RootUserScenarioRepositoryImpl implements RootUserScenarioRepository {

    private final RootUserScenarioJpaRepository jpaRepository;

    @Override
    public RootUserScenario save(RootUserScenario rootUserScenario) {
        return jpaRepository.save(rootUserScenario);
    }

    @Override
    public Optional<RootUserScenario> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public List<RootUserScenario> findAllById(Iterable<UUID> ids) {
        return jpaRepository.findAllById(ids);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Page<RootUserScenario> findByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserId(userId, pageable);
    }

    @Override
    public long countByUserId(UUID userId) {
        return jpaRepository.countByUserId(userId);
    }

    @Override
    public List<RootUserScenario> findByUserId(UUID userId) {
        return jpaRepository.findByUserId(userId);
    }

    @Override
    public Page<RootUserScenario> findPublicByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findPublicByUserId(userId, pageable);
    }

    @Override
    public long countPublicByUserId(UUID userId) {
        return jpaRepository.countPublicByUserId(userId);
    }

    @Override
    public Page<RootUserScenario> findByIsPrivateFalse(Pageable pageable) {
        return jpaRepository.findByIsPrivateFalse(pageable);
    }

    @Override
    public long countByIsPrivateFalse() {
        return jpaRepository.countByIsPrivateFalse();
    }

    @Override
    public List<RootUserScenario> findByBaseScenarioId(UUID baseScenarioId) {
        return jpaRepository.findByBaseScenarioId(baseScenarioId);
    }

    @Override
    public Page<RootUserScenario> findAccessibleScenarios(UUID userId, Pageable pageable) {
        return jpaRepository.findAccessibleScenarios(userId, pageable);
    }

    @Override
    public long countAccessibleScenarios(UUID userId) {
        return jpaRepository.countAccessibleScenarios(userId);
    }

    @Override
    public boolean existsByNovelIdAndContentHash(UUID novelId, String contentHash) {
        return jpaRepository.existsByNovelIdAndContentHash(novelId, contentHash);
    }

    @Override
    public Page<RootUserScenario> searchPublicScenarios(String query, Pageable pageable) {
        return jpaRepository.searchPublicScenarios(query, pageable);
    }

    @Override
    public long countSearchPublicScenarios(String query) {
        return jpaRepository.countSearchPublicScenarios(query);
    }

    @Override
    public Page<RootUserScenario> filterScenarios(ScenarioCategory category, UUID creatorId, Pageable pageable) {
        return jpaRepository.filterScenarios(category, creatorId, pageable);
    }

    @Override
    public long countFilterScenarios(ScenarioCategory category, UUID creatorId) {
        return jpaRepository.countFilterScenarios(category, creatorId);
    }

    @Override
    public void updateReferenceConversation(UUID scenarioId, UUID conversationId) {
        jpaRepository.updateReferenceConversation(scenarioId, conversationId);
    }

    @Override
    public Page<RootUserScenario> searchWithFilters(String query, ScenarioCategory category, UUID creatorId, Pageable pageable) {
        return jpaRepository.searchWithFilters(query, category, creatorId, pageable);
    }

    @Override
    public long countSearchResults(String query, ScenarioCategory category, UUID creatorId) {
        return jpaRepository.countSearchResults(query, category, creatorId);
    }
}
