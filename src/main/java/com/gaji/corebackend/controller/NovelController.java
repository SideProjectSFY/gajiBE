package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.NovelResponse;
import com.gaji.corebackend.service.NovelService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * Public API controller for novel browsing.
 * Called by frontend for novel discovery and selection.
 */
@RestController
@RequestMapping("/api/v1/novels")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Novels", description = "Public API for novel browsing")
public class NovelController {

    private final NovelService novelService;

    /**
     * Get all novels
     */
    @GetMapping
    @Operation(summary = "Get all novels", description = "Returns list of all available novels")
    @ApiResponse(responseCode = "200", description = "List of novels")
    public ResponseEntity<List<NovelResponse>> getAllNovels() {
        log.debug("Fetching all novels");
        List<NovelResponse> novels = novelService.getAllNovels();
        return ResponseEntity.ok(novels);
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
}
