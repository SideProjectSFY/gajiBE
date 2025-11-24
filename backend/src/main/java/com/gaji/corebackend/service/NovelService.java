package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.CreateNovelRequest;
import com.gaji.corebackend.dto.NovelResponse;
import com.gaji.corebackend.entity.Novel;
import com.gaji.corebackend.repository.NovelRepository;
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

    private final NovelRepository novelRepository;

    /**
     * Create novel metadata from FastAPI import script
     */
    @Transactional
    public NovelResponse createNovel(CreateNovelRequest request) {
        log.info("Creating novel metadata: title={}, vectordbId={}",
                request.getTitle(), request.getVectordbCollectionId());

        // Check if already exists
        if (novelRepository.existsByVectordbCollectionId(request.getVectordbCollectionId())) {
            log.warn("Novel already exists with vectordb_collection_id: {}",
                    request.getVectordbCollectionId());
            throw new IllegalArgumentException(
                    "Novel already exists with vectordb_collection_id: " + request.getVectordbCollectionId());
        }

        Novel novel = Novel.builder()
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

        Novel saved = novelRepository.save(novel);
        log.info("Novel created: id={}, title={}", saved.getId(), saved.getTitle());

        return NovelResponse.from(saved);
    }

    /**
     * Update novel ingestion status
     */
    @Transactional
    public void updateStatus(UUID id, String ingestionStatus) {
        log.info("Updating novel status: id={}, status={}", id, ingestionStatus);

        Novel novel = novelRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Novel not found: " + id));

        novel.setIngestionStatus(ingestionStatus);
        novelRepository.save(novel);

        log.info("Novel status updated: id={}, newStatus={}", id, ingestionStatus);
    }

    /**
     * Get novel by ID
     */
    @Transactional(readOnly = true)
    public NovelResponse getNovel(UUID id) {
        Novel novel = novelRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Novel not found: " + id));
        return NovelResponse.from(novel);
    }

    /**
     * Get novel by VectorDB collection ID
     */
    @Transactional(readOnly = true)
    public NovelResponse getNovelByVectordbId(String vectordbCollectionId) {
        Novel novel = novelRepository.findByVectordbCollectionId(vectordbCollectionId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Novel not found with vectordb_collection_id: " + vectordbCollectionId));
        return NovelResponse.from(novel);
    }

    /**
     * Get all novels
     */
    @Transactional(readOnly = true)
    public List<NovelResponse> getAllNovels() {
        return novelRepository.findAll().stream()
                .map(NovelResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Delete novel by ID
     */
    @Transactional
    public void deleteNovel(UUID id) {
        log.info("Deleting novel: id={}", id);

        if (!novelRepository.existsById(id)) {
            throw new IllegalArgumentException("Novel not found: " + id);
        }

        novelRepository.deleteById(id);
        log.info("Novel deleted: id={}", id);
    }
}
