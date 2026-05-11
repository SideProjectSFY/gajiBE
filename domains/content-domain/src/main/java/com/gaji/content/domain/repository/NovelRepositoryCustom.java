package com.gaji.content.domain.repository;

import com.gaji.content.domain.model.Novel;

import java.util.List;
import java.util.Optional;

public interface NovelRepositoryCustom {
    List<Novel> findByIngestionStatus(String ingestionStatus);
    Optional<Novel> findByPgvectorCollectionId(String pgvectorCollectionId);
    // Add new methods as needed for complex queries involving dynamic parameters
}
