package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.LeafUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repository for leaf user scenarios (forked from root scenarios)
 */
@Repository
public interface LeafUserScenarioRepository extends JpaRepository<LeafUserScenario, UUID> {

    /**
     * Find leaf scenarios by parent scenario ID
     */
    List<LeafUserScenario> findByParentScenarioId(UUID parentScenarioId);

    /**
     * Find leaf scenarios by user ID
     */
    List<LeafUserScenario> findByUserId(UUID userId);

    /**
     * Find leaf scenarios by user ID with pagination
     */
    Page<LeafUserScenario> findByUserId(UUID userId, Pageable pageable);

    /**
     * Count forks of a parent scenario
     */
    long countByParentScenarioId(UUID parentScenarioId);

    /**
     * Find public leaf scenarios with pagination
     */
    Page<LeafUserScenario> findByIsPrivateFalse(Pageable pageable);

    /**
     * Check if user has already forked a specific root scenario
     */
    boolean existsByParentScenarioIdAndUserId(UUID parentScenarioId, UUID userId);

    /**
     * Find scenario tree: root scenario with all its leaf children
     * Using native query with recursive CTE
     */
    @Query(value = """
            WITH RECURSIVE scenario_tree AS (
                -- Base case: the root scenario
                SELECT
                    r.id,
                    r.user_id,
                    r.base_scenario_id,
                    r.title,
                    r.description,
                    r.what_if_question,
                    r.is_private,
                    r.fork_count,
                    r.created_at,
                    r.updated_at,
                    NULL::uuid as parent_scenario_id,
                    0 as depth,
                    'root' as scenario_type
                FROM root_user_scenarios r
                WHERE r.id = :rootId

                UNION ALL

                -- Recursive case: leaf scenarios
                SELECT
                    l.id,
                    l.user_id,
                    NULL::uuid as base_scenario_id,
                    l.title,
                    l.description,
                    l.what_if_question,
                    l.is_private,
                    NULL as fork_count,
                    l.created_at,
                    l.updated_at,
                    l.parent_scenario_id,
                    1 as depth,
                    'leaf' as scenario_type
                FROM leaf_user_scenarios l
                WHERE l.parent_scenario_id = :rootId
            )
            SELECT * FROM scenario_tree ORDER BY depth, created_at DESC
            """, nativeQuery = true)
    List<Object[]> findScenarioTree(@Param("rootId") UUID rootId);
}
