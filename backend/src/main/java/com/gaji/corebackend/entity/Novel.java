package com.gaji.corebackend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Novel entity - Metadata only (content stored in VectorDB)
 */
@Entity
@Table(name = "novels")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Novel {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, length = 500)
    private String title;

    @Column(nullable = false, length = 200)
    private String author;

    @Column(name = "publication_year")
    private Integer publicationYear;

    @Column(length = 100)
    private String genre;

    @Column(name = "vectordb_collection_id", nullable = false, unique = true)
    private String vectordbCollectionId;

    @Column(name = "ingestion_status", length = 50)
    @Builder.Default
    private String ingestionStatus = "pending";

    @Column(name = "total_passages_count")
    private Integer totalPassagesCount;

    @Column(name = "total_characters_count")
    private Integer totalCharactersCount;

    @Column(name = "gutenberg_file_path", length = 500)
    private String gutenbergFilePath;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
