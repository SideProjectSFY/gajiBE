package com.gaji.content.domain.repository;

import com.gaji.content.domain.model.Novel;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface NovelRepository {
    
    Novel save(Novel novel);
    
    Optional<Novel> findById(UUID id);

    boolean existsById(UUID id);
    
    List<Novel> findAll();

    List<Novel> findAllById(Iterable<UUID> ids);
    
    void deleteById(UUID id);
    
    Optional<Novel> findByGutenbergId(Integer gutenbergId);

    boolean existsByVectordbCollectionId(String vectordbCollectionId);
    
    List<Novel> findByIngestionStatus(String ingestionStatus);
    
    Optional<Novel> findByVectordbCollectionId(String vectordbCollectionId);
}

