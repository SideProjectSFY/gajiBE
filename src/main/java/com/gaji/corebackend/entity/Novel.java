package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Novel entity - Metadata only (content stored in VectorDB)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Novel {

    private UUID id;
    private String title;
    private String author;
    private Integer publicationYear;
    private String genre;
    private String vectordbCollectionId;

    @Builder.Default
    private String ingestionStatus = "pending";

    private Integer totalPassagesCount;
    private Integer totalCharactersCount;
    private String gutenbergFilePath;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
