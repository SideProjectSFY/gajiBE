package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.Novel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * Novel repository for PostgreSQL metadata access
 */
@Repository
public interface NovelRepository extends JpaRepository<Novel, UUID> {

    /**
     * Find novel by VectorDB collection ID
     */
    Optional<Novel> findByVectordbCollectionId(String vectordbCollectionId);

    /**
     * Check if novel exists by VectorDB collection ID
     */
    boolean existsByVectordbCollectionId(String vectordbCollectionId);

    /**
     * Find novels by ingestion status
     */
    java.util.List<Novel> findByIngestionStatus(String ingestionStatus);
}
