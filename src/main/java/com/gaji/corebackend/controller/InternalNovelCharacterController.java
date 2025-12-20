package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.NovelCharacterResponse;
import com.gaji.corebackend.service.NovelCharacterService;
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
 * Internal API controller for character operations.
 * Called by FastAPI for character information.
 *
 * These endpoints are for internal service-to-service communication only.
 */
@RestController
@RequestMapping("/api/internal/novels/{novelId}/characters")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Internal Novel Character API", description = "Internal API for character operations (FastAPI only)")
public class InternalNovelCharacterController {

    private final NovelCharacterService characterService;

    /**
     * Get all characters by novel ID
     */
    @GetMapping
    @Operation(
            summary = "Get characters by novel ID",
            description = "Returns all characters for a specific novel. Used by FastAPI for AI conversation generation."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Characters found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<List<NovelCharacterResponse>> getCharactersByNovelId(
            @Parameter(description = "Novel UUID") @PathVariable UUID novelId
    ) {
        log.info("[Internal] Fetching characters for novel: {}", novelId);
        List<NovelCharacterResponse> characters = characterService.getCharactersByNovelId(novelId);
        return ResponseEntity.ok(characters);
    }

    /**
     * Get main characters by novel ID
     */
    @GetMapping("/main")
    @Operation(
            summary = "Get main characters by novel ID",
            description = "Returns only main characters (is_main_character = true) for a specific novel."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Main characters found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<List<NovelCharacterResponse>> getMainCharactersByNovelId(
            @Parameter(description = "Novel UUID") @PathVariable UUID novelId
    ) {
        log.info("[Internal] Fetching main characters for novel: {}", novelId);
        List<NovelCharacterResponse> characters = characterService.getMainCharactersByNovelId(novelId);
        return ResponseEntity.ok(characters);
    }
}

