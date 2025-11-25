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
     * Find public scenarios with pagination
     */
    Page<RootUserScenario> findByIsPublicTrue(Pageable pageable);

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
     */
    @Query("SELECT s FROM RootUserScenario s WHERE s.isPublic = true OR s.userId = :userId ORDER BY s.createdAt DESC")
    Page<RootUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, Pageable pageable);

    /**
     * Search scenarios by title or description (public only)
     */
    @Query("SELECT s FROM RootUserScenario s WHERE s.isPublic = true AND " +
            "(LOWER(s.title) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(s.description) LIKE LOWER(CONCAT('%', :query, '%')))")
    Page<RootUserScenario> searchPublicScenarios(@Param("query") String query, Pageable pageable);

    /**
     * Check if scenario with same content exists for a novel
     * Used for duplicate detection
     */
    boolean existsByNovelIdAndContentHash(UUID novelId, String contentHash);
}
