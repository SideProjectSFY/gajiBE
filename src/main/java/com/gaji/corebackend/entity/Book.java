package com.gaji.corebackend.entity;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Book Entity (maps to novels table in PostgreSQL)
 * Stores metadata only - novel content is in VectorDB
 */
public class Book {
    private UUID id;
    private String title;
    private String author;
    private String genre;
    private String coverImageUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Aggregated fields (not in database, calculated at runtime)
    private Integer scenarioCount;
    private Integer conversationCount;
    private Integer likeCount;

    // Constructors
    public Book() {}

    public Book(UUID id, String title, String author, String genre, String coverImageUrl,
                LocalDateTime createdAt, LocalDateTime updatedAt,
                Integer scenarioCount, Integer conversationCount, Integer likeCount) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.genre = genre;
        this.coverImageUrl = coverImageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.scenarioCount = scenarioCount;
        this.conversationCount = conversationCount;
        this.likeCount = likeCount;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
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

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }
}
