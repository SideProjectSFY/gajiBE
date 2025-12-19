package com.gaji.corebackend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO for creating novel metadata via internal API
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateNovelRequest {

    @NotBlank(message = "Title is required")
    @Size(max = 500, message = "Title must be at most 500 characters")
    private String title;

    @NotBlank(message = "Author is required")
    @Size(max = 200, message = "Author must be at most 200 characters")
    private String author;

    private Integer publicationYear;

    @Size(max = 100, message = "Genre must be at most 100 characters")
    private String genre;

    private String language;

    @NotBlank(message = "VectorDB collection ID is required")
    private String vectordbCollectionId;

    private Integer totalPassagesCount;

    private Integer totalCharactersCount;

    @Size(max = 50, message = "Ingestion status must be at most 50 characters")
    private String ingestionStatus;
}
