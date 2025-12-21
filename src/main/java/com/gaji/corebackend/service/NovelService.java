package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.CreateNovelRequest;
import com.gaji.corebackend.dto.NovelResponse;
import com.gaji.corebackend.entity.Novel;
import com.gaji.corebackend.mapper.NovelMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for novel metadata operations
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class NovelService {

    private final NovelMapper novelMapper;

    /**
     * Create novel metadata from FastAPI import script
     */
    @Transactional
    public NovelResponse createNovel(CreateNovelRequest request) {
        log.info("Creating novel metadata: title={}, vectordbId={}",
                request.getTitle(), request.getVectordbCollectionId());

        // Check if already exists
        if (novelMapper.existsByVectordbCollectionId(request.getVectordbCollectionId())) {
            log.warn("Novel already exists with vectordb_collection_id: {}",
                    request.getVectordbCollectionId());
            throw new IllegalArgumentException(
                    "Novel already exists with vectordb_collection_id: " + request.getVectordbCollectionId());
        }

        Novel novel = Novel.builder()
                .id(UUID.randomUUID())
                .title(request.getTitle())
                .author(request.getAuthor())
                .publicationYear(request.getPublicationYear())
                .genre(request.getGenre())
                .vectordbCollectionId(request.getVectordbCollectionId())
                .totalPassagesCount(request.getTotalPassagesCount())
                .totalCharactersCount(request.getTotalCharactersCount())
                .ingestionStatus(request.getIngestionStatus() != null ?
                        request.getIngestionStatus() : "pending")
                .build();

        novelMapper.insert(novel);
        log.info("Novel created: id={}, title={}", novel.getId(), novel.getTitle());

        return NovelResponse.from(novel);
    }

    /**
     * Update novel ingestion status
     */
    @Transactional
    public void updateStatus(UUID id, String ingestionStatus) {
        log.info("Updating novel status: id={}, status={}", id, ingestionStatus);

        Novel novel = novelMapper.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Novel not found: " + id));

        novel.setIngestionStatus(ingestionStatus);
        novelMapper.update(novel);

        log.info("Novel status updated: id={}, newStatus={}", id, ingestionStatus);
    }

    /**
     * Get novel by ID
     */
    @Transactional(readOnly = true)
    public NovelResponse getNovel(UUID id) {
        Novel novel = novelMapper.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Novel not found: " + id));
        return NovelResponse.from(novel);
    }

    /**
     * Get novel by VectorDB collection ID
     */
    @Transactional(readOnly = true)
    public NovelResponse getNovelByVectordbId(String vectordbCollectionId) {
        Novel novel = novelMapper.findByVectordbCollectionId(vectordbCollectionId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Novel not found with vectordb_collection_id: " + vectordbCollectionId));
        return NovelResponse.from(novel);
    }

    /**
     * Get novel by Gutenberg ID
     */
    @Transactional(readOnly = true)
    public NovelResponse getNovelByGutenbergId(Integer gutenbergId) {
        Novel novel = novelMapper.findByGutenbergId(gutenbergId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Novel not found with gutenberg_id: " + gutenbergId));
        return NovelResponse.from(novel);
    }

    /**
     * Get all novels
     */
    @Transactional(readOnly = true)
    public List<NovelResponse> getAllNovels() {
        return novelMapper.findAll().stream()
                .map(NovelResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Delete novel by ID
     */
    @Transactional
    public void deleteNovel(UUID id) {
        log.info("Deleting novel: id={}", id);

        if (!novelMapper.existsById(id)) {
            throw new IllegalArgumentException("Novel not found: " + id);
        }

        novelMapper.deleteById(id);
        log.info("Novel deleted: id={}", id);
    }
}
