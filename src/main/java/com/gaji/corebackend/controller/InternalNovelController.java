package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.CreateNovelRequest;
import com.gaji.corebackend.dto.NovelResponse;
import com.gaji.corebackend.dto.UpdateNovelStatusRequest;
import com.gaji.corebackend.service.NovelService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * Internal API controller for novel metadata operations.
 * Called by FastAPI import script (Pattern B architecture).
 *
 * These endpoints are for internal service-to-service communication only.
 */
@RestController
@RequestMapping("/api/v1/internal/novels")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Internal - Novels", description = "Internal API for novel metadata (FastAPI → Spring Boot)")
public class InternalNovelController {

    private final NovelService novelService;

    /**
     * Create novel metadata from VectorDB import script
     */
    @PostMapping
    @Operation(
            summary = "Create novel metadata",
            description = "Creates novel metadata in PostgreSQL. Called by FastAPI import script after VectorDB import."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "Novel created successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid request or novel already exists"),
            @ApiResponse(responseCode = "409", description = "Novel with vectordb_collection_id already exists")
    })
    public ResponseEntity<NovelResponse> createNovel(
            @Valid @RequestBody CreateNovelRequest request
    ) {
        log.info("[Internal] Creating novel: title={}, vectordbId={}",
                request.getTitle(), request.getVectordbCollectionId());

        try {
            NovelResponse response = novelService.createNovel(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (IllegalArgumentException e) {
            log.warn("[Internal] Novel creation failed: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }

    /**
     * Update novel ingestion status
     */
    @PatchMapping("/{id}")
    @Operation(
            summary = "Update novel ingestion status",
            description = "Updates the ingestion status of a novel (pending, processing, completed, failed)"
    )
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Status updated successfully"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<Void> updateNovelStatus(
            @Parameter(description = "Novel UUID") @PathVariable UUID id,
            @Valid @RequestBody UpdateNovelStatusRequest request
    ) {
        log.info("[Internal] Updating novel status: id={}, status={}", id, request.getIngestionStatus());

        try {
            novelService.updateStatus(id, request.getIngestionStatus());
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException e) {
            log.warn("[Internal] Novel not found: {}", id);
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get novel by ID
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get novel by ID")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Novel found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<NovelResponse> getNovel(
            @Parameter(description = "Novel UUID") @PathVariable UUID id
    ) {
        try {
            NovelResponse response = novelService.getNovel(id);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get novel by VectorDB collection ID
     */
    @GetMapping("/by-vectordb/{vectordbCollectionId}")
    @Operation(summary = "Get novel by VectorDB collection ID")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Novel found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<NovelResponse> getNovelByVectordbId(
            @Parameter(description = "VectorDB collection ID") @PathVariable String vectordbCollectionId
    ) {
        try {
            NovelResponse response = novelService.getNovelByVectordbId(vectordbCollectionId);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get novel by Gutenberg ID
     */
    @GetMapping("/by-gutenberg/{gutenbergId}")
    @Operation(summary = "Get novel by Gutenberg ID")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Novel found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<NovelResponse> getNovelByGutenbergId(
            @Parameter(description = "Project Gutenberg ID") @PathVariable Integer gutenbergId
    ) {
        log.info("[Internal] Getting novel by Gutenberg ID: {}", gutenbergId);
        try {
            NovelResponse response = novelService.getNovelByGutenbergId(gutenbergId);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            log.warn("[Internal] Novel not found with Gutenberg ID: {}", gutenbergId);
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Delete novel by ID (for cleanup/rollback)
     */
    @DeleteMapping("/{id}")
    @Operation(
            summary = "Delete novel",
            description = "Deletes novel metadata. Used for cleanup after failed imports."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Novel deleted successfully"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<Void> deleteNovel(
            @Parameter(description = "Novel UUID") @PathVariable UUID id
    ) {
        log.info("[Internal] Deleting novel: id={}", id);

        try {
            novelService.deleteNovel(id);
            return ResponseEntity.noContent().build();
        } catch (IllegalArgumentException e) {
            log.warn("[Internal] Novel not found for deletion: {}", id);
            return ResponseEntity.notFound().build();
        }
    }
}
