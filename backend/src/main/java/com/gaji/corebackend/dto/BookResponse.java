package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.Book;
import java.util.UUID;

/**
 * Response DTO for Book API
 * Returns book metadata with aggregated counts
 */
public class BookResponse {
    private UUID id;
    private String title;
    private String author;
    private String genre;
    private String coverImageUrl;
    private Integer scenarioCount;
    private Integer conversationCount;

    // Constructors
    public BookResponse() {}

    public BookResponse(UUID id, String title, String author, String genre,
                       String coverImageUrl, Integer scenarioCount, Integer conversationCount) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.coverImageUrl = coverImageUrl;
        this.scenarioCount = scenarioCount;
        this.conversationCount = conversationCount;
    }

    // Factory method to create from Book entity
    public static BookResponse from(Book book) {
        return new BookResponse(
            book.getId(),
            book.getTitle(),
            book.getAuthor(),
            book.getGenre(),
            book.getCoverImageUrl(),
            book.getScenarioCount(),
            book.getConversationCount()
        );
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getCoverImageUrl() {
        return coverImageUrl;
    }

    public void setCoverImageUrl(String coverImageUrl) {
        this.coverImageUrl = coverImageUrl;
    }

    public Integer getScenarioCount() {
        return scenarioCount;
    }

    public void setScenarioCount(Integer scenarioCount) {
        this.scenarioCount = scenarioCount;
    }

    public Integer getConversationCount() {
        return conversationCount;
    }

    public void setConversationCount(Integer conversationCount) {
        this.conversationCount = conversationCount;
    }
}
