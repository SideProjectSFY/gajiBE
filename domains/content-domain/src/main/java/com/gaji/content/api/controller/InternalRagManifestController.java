package com.gaji.content.api.controller;

import com.gaji.content.application.PassageManifestService;
import com.gaji.shared.contract.dto.PassageManifestRequest;
import com.gaji.shared.contract.dto.PassageManifestResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/internal/rag/passage-manifests")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Internal - RAG Manifests", description = "Internal API for RAG passage manifest metadata")
public class InternalRagManifestController {

    private final PassageManifestService passageManifestService;

    @PutMapping("/{passageManifestId}")
    public ResponseEntity<PassageManifestResponse> upsert(
            @PathVariable String passageManifestId,
            @Valid @RequestBody PassageManifestRequest request
    ) {
        if (!passageManifestId.equals(request.getPassageManifestId())) {
            return ResponseEntity.badRequest().build();
        }

        try {
            PassageManifestResponse response = passageManifestService.upsert(request);
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException ex) {
            log.warn("[Internal] Passage manifest upsert failed: {}", ex.getMessage());
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{passageManifestId}")
    public ResponseEntity<PassageManifestResponse> get(@PathVariable String passageManifestId) {
        try {
            return ResponseEntity.ok(passageManifestService.get(passageManifestId));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/by-novel/{novelId}")
    public ResponseEntity<List<PassageManifestResponse>> listByNovel(@PathVariable UUID novelId) {
        return ResponseEntity.ok(passageManifestService.listByNovel(novelId));
    }
}
