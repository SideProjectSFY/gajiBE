package com.gaji.content.domain.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Novel entity - Metadata only (content stored in pgvector)
 */
@Entity
@Table(name = "novels")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Novel {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "title", nullable = false, length = 500)
    private String title;

    @Column(name = "author", nullable = false, length = 200)
    private String author;

    @Column(name = "publication_year")
    private Integer publicationYear;

    @Column(name = "genre", length = 100)
    private String genre;

    @Column(name = "vectordb_collection_id", length = 255)
    private String vectordbCollectionId;

    @Column(name = "gutenberg_id")
    private Integer gutenbergId;

    @Column(name = "cover_image_url", length = 500)
    private String coverImageUrl;

    @Builder.Default
    @Column(name = "ingestion_status", nullable = false, length = 50)
    private String ingestionStatus = "pending";

    @Column(name = "total_passages_count")
    private Integer totalPassagesCount;

    @Column(name = "total_characters_count")
    private Integer totalCharactersCount;

    @Column(name = "gutenberg_file_path", length = 500)
    private String gutenbergFilePath;

    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
