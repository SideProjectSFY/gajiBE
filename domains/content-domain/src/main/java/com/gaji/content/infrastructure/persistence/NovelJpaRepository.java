package com.gaji.content.infrastructure.persistence;

import com.gaji.content.domain.model.Novel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface NovelJpaRepository extends JpaRepository<Novel, UUID>, QuerydslPredicateExecutor<Novel> {
    
    @Query("SELECT n FROM Novel n WHERE n.gutenbergId = :gutenbergId")
    Optional<Novel> findByGutenbergId(@Param("gutenbergId") Integer gutenbergId);

    @Query("SELECT CASE WHEN COUNT(n) > 0 THEN true ELSE false END FROM Novel n WHERE n.vectordbCollectionId = :vectordbCollectionId")
    boolean existsByVectordbCollectionId(@Param("vectordbCollectionId") String vectordbCollectionId);
}
