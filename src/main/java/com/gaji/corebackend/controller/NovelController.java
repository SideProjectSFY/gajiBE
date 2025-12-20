package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.NovelCharacterResponse;
import com.gaji.corebackend.dto.NovelResponse;
import com.gaji.corebackend.service.NovelCharacterService;
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
    private final NovelCharacterService characterService;

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

    /**
     * Get all characters by novel ID (Public API)
     * Called by Vue.js frontend for character selection
     */
    @GetMapping("/{id}/characters")
    @Operation(
            summary = "Get characters by novel ID",
            description = "Returns all characters for a specific novel. Used by frontend for character selection."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Characters found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<List<NovelCharacterResponse>> getCharactersByNovelId(
            @Parameter(description = "Novel UUID") @PathVariable UUID id
    ) {
        log.debug("Fetching characters for novel: {}", id);
        try {
            // Novel 존재 확인
            novelService.getNovel(id);
            
            // 캐릭터 목록 조회
            List<NovelCharacterResponse> characters = characterService.getCharactersByNovelId(id);
            return ResponseEntity.ok(characters);
        } catch (IllegalArgumentException e) {
            log.warn("Novel not found: {}", id);
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get main characters by novel ID (Public API)
     * Called by Vue.js frontend for main character selection
     */
    @GetMapping("/{id}/characters/main")
    @Operation(
            summary = "Get main characters by novel ID",
            description = "Returns only main characters (is_main_character = true) for a specific novel."
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Main characters found"),
            @ApiResponse(responseCode = "404", description = "Novel not found")
    })
    public ResponseEntity<List<NovelCharacterResponse>> getMainCharactersByNovelId(
            @Parameter(description = "Novel UUID") @PathVariable UUID id
    ) {
        log.debug("Fetching main characters for novel: {}", id);
        try {
            // Novel 존재 확인
            novelService.getNovel(id);
            
            // 주인공 캐릭터 목록 조회
            List<NovelCharacterResponse> characters = characterService.getMainCharactersByNovelId(id);
            return ResponseEntity.ok(characters);
        } catch (IllegalArgumentException e) {
            log.warn("Novel not found: {}", id);
            return ResponseEntity.notFound().build();
        }
    }
}
