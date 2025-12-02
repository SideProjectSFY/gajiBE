package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.RootUserScenario;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Repository for root user scenarios (PostgreSQL)
 */
@Repository
public interface RootUserScenarioRepository extends JpaRepository<RootUserScenario, UUID> {

    /**
     * Find scenarios by user ID
     */
    List<RootUserScenario> findByUserId(UUID userId);

    /**
     * Find scenarios by user ID with pagination
     */
    Page<RootUserScenario> findByUserId(UUID userId, Pageable pageable);

    /**
     * Find public scenarios with pagination (public = isPrivate false)
     */
    Page<RootUserScenario> findByIsPrivateFalse(Pageable pageable);

    /**
     * Find scenarios by base scenario ID
     */
    List<RootUserScenario> findByBaseScenarioId(UUID baseScenarioId);

    /**
     * Count scenarios by user ID
     */
    long countByUserId(UUID userId);

    /**
     * Find public scenarios or scenarios by user ID with pagination
     * public = isPrivate false
     */
    @Query("SELECT s FROM RootUserScenario s WHERE s.isPrivate = false OR s.userId = :userId ORDER BY s.createdAt DESC")
    Page<RootUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, Pageable pageable);

    /**
     * Search scenarios by title or description (public only = isPrivate false)
     */
    @Query("SELECT s FROM RootUserScenario s WHERE s.isPrivate = false AND " +
            "(LOWER(s.title) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(s.description) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<RootUserScenario> searchPublicScenarios(@Param("query") String query, Pageable pageable);

    /**
     * Check if scenario with same content exists for a novel
     * Used for duplicate detection
     */
    boolean existsByNovelIdAndContentHash(UUID novelId, String contentHash);

    /**
     * Full-text search with advanced filters using PostgreSQL ts_rank
     * Story 3.6: Scenario Search & Advanced Filtering
     *
     * @param query Search query (converted to tsquery)
     * @param scenarioCategory Optional scenario category filter
     * @param creatorId Optional creator ID filter
     * @param limit Maximum number of results
     * @param offset Starting position
     * @return List of matching scenarios ranked by relevance
     */
    @Query(value = """
        SELECT s.*, 
               ts_rank(s.search_vector, to_tsquery('english', regexp_replace(regexp_replace(:query, '[^a-zA-Z0-9\\s]', '', 'g'), '\\s+', ' & ', 'g') || ':*')) AS rank
        FROM root_user_scenarios s
        WHERE s.search_vector @@ to_tsquery('english', regexp_replace(regexp_replace(:query, '[^a-zA-Z0-9\\s]', '', 'g'), '\\s+', ' & ', 'g') || ':*')
          AND s.is_private = false
          AND (:scenarioCategory IS NULL OR s.scenario_category = :scenarioCategory)
          AND (:creatorId IS NULL OR s.user_id = CAST(:creatorId AS UUID))
        ORDER BY rank DESC, s.created_at DESC
        LIMIT :limit OFFSET :offset
        """,
        nativeQuery = true)
    List<RootUserScenario> searchWithFilters(
            @Param("query") String query,
            @Param("scenarioCategory") String scenarioCategory,
            @Param("creatorId") String creatorId,
            @Param("limit") int limit,
            @Param("offset") int offset);

    /**
     * Count search results for pagination
     */
    @Query(value = """
        SELECT COUNT(*)
        FROM root_user_scenarios s
        WHERE s.search_vector @@ to_tsquery('english', regexp_replace(regexp_replace(:query, '[^a-zA-Z0-9\\s]', '', 'g'), '\\s+', ' & ', 'g') || ':*')
          AND s.is_private = false
          AND (:scenarioCategory IS NULL OR s.scenario_category = :scenarioCategory)
          AND (:creatorId IS NULL OR s.user_id = CAST(:creatorId AS UUID))
        """,
        nativeQuery = true)
    long countSearchResults(
            @Param("query") String query,
            @Param("scenarioCategory") String scenarioCategory,
            @Param("creatorId") String creatorId);

    /**
     * Filter scenarios without text search query
     * public = isPrivate false
     *
     * @param scenarioCategory Optional scenario category filter
     * @param creatorId Optional creator ID filter
     * @param pageable Pagination parameters
     * @return Page of filtered scenarios
     */
    @Query("SELECT s FROM RootUserScenario s " +
            "WHERE s.isPrivate = false " +
            "AND (:#{#scenarioCategory == null} = true OR s.scenarioCategory = :scenarioCategory) " +
            "AND (:#{#creatorId == null} = true OR s.userId = :creatorId) " +
            "ORDER BY s.createdAt DESC")
    Page<RootUserScenario> filterScenarios(
            @Param("scenarioCategory") com.gaji.corebackend.entity.ScenarioCategory scenarioCategory,
            @Param("creatorId") UUID creatorId,
            Pageable pageable);

    /**
     * Search scenarios by JSONB parameter content
     * Example: Find scenarios with "Hermione" in character changes
     *
     * @param parameterQuery JSON path query
     * @param pageable Pagination parameters
     * @return Page of matching scenarios
     */
    @Query(value = """
        SELECT s.*
        FROM root_user_scenarios s
        WHERE s.is_private = false
          AND s.parameters::text ILIKE CONCAT('%', :parameterQuery, '%')
        ORDER BY s.created_at DESC
        """,
        nativeQuery = true)
    Page<RootUserScenario> searchByParameters(
            @Param("parameterQuery") String parameterQuery,
            Pageable pageable);
}
