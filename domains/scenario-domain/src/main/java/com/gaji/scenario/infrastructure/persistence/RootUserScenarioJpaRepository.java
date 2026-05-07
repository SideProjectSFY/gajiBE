package com.gaji.scenario.infrastructure.persistence;

import com.gaji.content.domain.model.ScenarioCategory;
import com.gaji.scenario.domain.model.RootUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface RootUserScenarioJpaRepository extends JpaRepository<RootUserScenario, UUID>, QuerydslPredicateExecutor<RootUserScenario> {
    
    // findByUserId -> using Pageable
    Page<RootUserScenario> findByUserId(UUID userId, Pageable pageable);
    
    // countByUserId provided by Page or explicitly:
    long countByUserId(UUID userId);
    List<RootUserScenario> findByUserId(UUID userId);
    
    // findPublicByUserIdWithPaging -> findByUserIdAndIsPrivateFalse
    @Query("SELECT r FROM RootUserScenario r WHERE r.userId = :userId AND r.isPrivate = false")
    Page<RootUserScenario> findPublicByUserId(@Param("userId") UUID userId, Pageable pageable);

    @Query("SELECT COUNT(r) FROM RootUserScenario r WHERE r.userId = :userId AND r.isPrivate = false")
    long countPublicByUserId(@Param("userId") UUID userId);

    // findByIsPrivateFalse
    @Query("SELECT r FROM RootUserScenario r WHERE r.isPrivate = false")
    Page<RootUserScenario> findByIsPrivateFalse(Pageable pageable);
    
    long countByIsPrivateFalse();
    
    List<RootUserScenario> findByBaseScenarioId(UUID baseScenarioId);
    
    // findAccessibleScenarios: accessible = public OR own
    @Query("SELECT r FROM RootUserScenario r WHERE r.isPrivate = false OR r.userId = :userId")
    Page<RootUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, Pageable pageable);
    
    @Query("SELECT COUNT(r) FROM RootUserScenario r WHERE r.isPrivate = false OR r.userId = :userId")
    long countAccessibleScenarios(@Param("userId") UUID userId);
    
    // existsByNovelIdAndContentHash
    boolean existsByNovelIdAndContentHash(UUID novelId, String contentHash);
    
    // searchPublicScenarios
    @Query("SELECT r FROM RootUserScenario r WHERE r.isPrivate = false AND (LOWER(r.title) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(r.description) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<RootUserScenario> searchPublicScenarios(@Param("query") String query, Pageable pageable);
    
    @Query("SELECT COUNT(r) FROM RootUserScenario r WHERE r.isPrivate = false AND (LOWER(r.title) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(r.description) LIKE LOWER(CONCAT('%', :query, '%')))")
    long countSearchPublicScenarios(@Param("query") String query);
    
    // filterScenarios
    @Query("SELECT r FROM RootUserScenario r WHERE (:category IS NULL OR r.scenarioCategory = :category) AND (:creatorId IS NULL OR r.userId = :creatorId) AND r.isPrivate = false")
    Page<RootUserScenario> filterScenarios(@Param("category") ScenarioCategory category, @Param("creatorId") UUID creatorId, Pageable pageable);
    
    @Query("SELECT COUNT(r) FROM RootUserScenario r WHERE (:category IS NULL OR r.scenarioCategory = :category) AND (:creatorId IS NULL OR r.userId = :creatorId) AND r.isPrivate = false")
    long countFilterScenarios(@Param("category") ScenarioCategory category, @Param("creatorId") UUID creatorId);

    @Modifying
    @Query("UPDATE RootUserScenario r SET r.referenceConversationId = :conversationId, r.updatedAt = CURRENT_TIMESTAMP WHERE r.id = :scenarioId")
    void updateReferenceConversation(@Param("scenarioId") UUID scenarioId, @Param("conversationId") UUID conversationId);
    
    // searchWithFilters
    @Query("SELECT r FROM RootUserScenario r WHERE " +
           "(:query IS NULL OR LOWER(r.title) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(r.description) LIKE LOWER(CONCAT('%', :query, '%'))) AND " +
           "(:category IS NULL OR r.scenarioCategory = :category) AND " + 
           "(:creatorId IS NULL OR r.userId = :creatorId) AND " +
           "r.isPrivate = false")
    Page<RootUserScenario> searchWithFilters(@Param("query") String query, @Param("category") ScenarioCategory category, @Param("creatorId") UUID creatorId, Pageable pageable);

    @Query("SELECT COUNT(r) FROM RootUserScenario r WHERE " +
           "(:query IS NULL OR LOWER(r.title) LIKE LOWER(CONCAT('%', :query, '%')) OR LOWER(r.description) LIKE LOWER(CONCAT('%', :query, '%'))) AND " +
           "(:category IS NULL OR r.scenarioCategory = :category) AND " + 
           "(:creatorId IS NULL OR r.userId = :creatorId) AND " +
           "r.isPrivate = false")
    long countSearchResults(@Param("query") String query, @Param("category") ScenarioCategory category, @Param("creatorId") UUID creatorId);
}
