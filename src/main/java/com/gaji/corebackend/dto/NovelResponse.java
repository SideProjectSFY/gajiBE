package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.Novel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for novel data
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NovelResponse {

    private UUID id;
    private String title;
    private String author;
    private Integer publicationYear;
    private String genre;
    private String vectordbCollectionId;
    private String ingestionStatus;
    private Integer totalPassagesCount;
    private Integer totalCharactersCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Create response from entity
     */
    public static NovelResponse from(Novel novel) {
        return NovelResponse.builder()
                .id(novel.getId())
                .title(novel.getTitle())
                .author(novel.getAuthor())
                .publicationYear(novel.getPublicationYear())
                .genre(novel.getGenre())
                .vectordbCollectionId(novel.getVectordbCollectionId())
                .ingestionStatus(novel.getIngestionStatus())
                .totalPassagesCount(novel.getTotalPassagesCount())
                .totalCharactersCount(novel.getTotalCharactersCount())
                .createdAt(novel.getCreatedAt())
                .updatedAt(novel.getUpdatedAt())
                .build();
    }
}
