package com.gaji.scenario.infrastructure.persistence;

import com.gaji.scenario.domain.model.LeafUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;
import java.util.UUID;

public interface LeafUserScenarioJpaRepository extends JpaRepository<LeafUserScenario, UUID>, QuerydslPredicateExecutor<LeafUserScenario> {
    
    List<LeafUserScenario> findByParentScenarioId(UUID parentScenarioId);
    
    List<LeafUserScenario> findByUserId(UUID userId);
    
    Page<LeafUserScenario> findByUserId(UUID userId, Pageable pageable);

    long countByParentScenarioId(UUID parentScenarioId);
    
    @Query("SELECT l FROM LeafUserScenario l WHERE l.isPrivate = false")
    Page<LeafUserScenario> findByIsPrivateFalse(Pageable pageable);
    
    long countByIsPrivateFalse();
    
    boolean existsByParentScenarioIdAndUserId(UUID parentScenarioId, UUID userId);
    
    @Query("SELECT l FROM LeafUserScenario l WHERE l.isPrivate = false OR l.userId = :userId")
    Page<LeafUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, Pageable pageable);

    @Query("SELECT COUNT(l) FROM LeafUserScenario l WHERE l.isPrivate = false OR l.userId = :userId")
    long countAccessibleScenarios(@Param("userId") UUID userId);
    
    @Query(value = "WITH RECURSIVE scenario_tree AS (" +
            "SELECT " +
            "CAST(id AS VARCHAR) as id, CAST(user_id AS VARCHAR) as user_id, CAST(base_scenario_id AS VARCHAR) as base_scenario_id, title, description, what_if_question, " +
            "is_private, fork_count, created_at, updated_at, " +
            "CAST(NULL AS VARCHAR) as parent_scenario_id, " +
            "0 as depth, " +
            "'root' as scenario_type " +
            "FROM root_user_scenarios " +
            "WHERE id = :rootId " +
            "UNION ALL " +
            "SELECT " +
            "CAST(l.id AS VARCHAR) as id, CAST(l.user_id AS VARCHAR) as user_id, CAST(NULL AS VARCHAR) as base_scenario_id, l.title, l.description, l.what_if_question, " +
            "l.is_private, 0 as fork_count, l.created_at, l.updated_at, " +
            "CAST(l.parent_scenario_id AS VARCHAR) as parent_scenario_id, " +
            "st.depth + 1, " +
            "'leaf' as scenario_type " +
            "FROM leaf_user_scenarios l " +
            "INNER JOIN scenario_tree st ON CAST(l.parent_scenario_id AS VARCHAR) = st.id" +
            ") SELECT * FROM scenario_tree", nativeQuery = true)
    List<Map<String, Object>> findScenarioTree(@Param("rootId") UUID rootId);
}
