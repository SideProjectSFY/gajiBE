package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.Novel;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface NovelMapper {
    Optional<Novel> findById(UUID id);
    Optional<Novel> findByVectordbCollectionId(String vectordbCollectionId);
    Optional<Novel> findByGutenbergId(Integer gutenbergId);
    boolean existsByVectordbCollectionId(String vectordbCollectionId);
    boolean existsById(UUID id);
    List<Novel> findByIngestionStatus(String ingestionStatus);
    List<Novel> findAll();
    int insert(Novel novel);
    int update(Novel novel);
    int deleteById(UUID id);
}
