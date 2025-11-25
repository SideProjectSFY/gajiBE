package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.service.ScenarioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST API Controller for Scenario CRUD operations
 *
 * Endpoints:
 * - POST /api/scenarios - Create new scenario
 * - GET /api/scenarios/{id} - Get scenario by ID
 * - GET /api/scenarios - List scenarios with pagination
 * - PUT /api/scenarios/{id} - Update scenario
 * - DELETE /api/scenarios/{id} - Delete scenario
 * - POST /api/scenarios/{id}/fork - Fork a scenario
 * - GET /api/scenarios/{id}/tree - Get scenario tree
 */
@RestController
@RequestMapping("/api/scenarios")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Scenarios", description = "What If Scenario Management API")
public class ScenarioController {

    private final ScenarioService scenarioService;

    /**
     * Create a new scenario
     *
     * Note: In production, userId should come from authenticated user context.
     * For MVP, we accept it as a header parameter.
     */
    @PostMapping
    @Operation(summary = "Create a new scenario", description = "Creates a new root 'What If?' scenario")
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "Scenario created successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid request data"),
            @ApiResponse(responseCode = "401", description = "User not authenticated")
    })
    public ResponseEntity<ScenarioResponse> createScenario(
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody CreateScenarioRequest request) {

        log.info("Creating scenario: userId={}, title={}", userId, request.getScenarioTitle());

        ScenarioResponse response = scenarioService.createScenario(userId, request);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Get scenario by ID
     */
    @GetMapping("/{id}")
    @Operation(summary = "Get scenario by ID", description = "Retrieves a scenario by its unique identifier")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Scenario retrieved successfully"),
            @ApiResponse(responseCode = "404", description = "Scenario not found"),
            @ApiResponse(responseCode = "403", description = "Access forbidden")
    })
    public ResponseEntity<ScenarioResponse> getScenario(
            @PathVariable UUID id,
            @RequestHeader(value = "X-User-Id", required = false) UUID userId) {

        log.debug("Getting scenario: id={}", id);

        ScenarioResponse response;
        if (userId != null) {
            response = scenarioService.getScenarioWithAccess(id, userId);
        } else {
            response = scenarioService.getScenario(id);
            // For unauthenticated requests, only return public scenarios
            if (response != null && !response.getIsPublic()) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
        }

        return ResponseEntity.ok(response);
    }

    /**
     * List scenarios with pagination
     */
    @GetMapping
    @Operation(summary = "List scenarios", description = "Lists scenarios with pagination. Returns public scenarios and user's own scenarios.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Scenarios retrieved successfully")
    })
    public ResponseEntity<Page<ScenarioResponse>> listScenarios(
            @RequestHeader(value = "X-User-Id", required = false) UUID userId,
            @Parameter(description = "Filter: 'my' for user's scenarios, 'public' for public only")
            @RequestParam(value = "filter", required = false) String filter,
            @Parameter(description = "Search query for title/description")
            @RequestParam(value = "q", required = false) String query,
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC)
            Pageable pageable) {

        log.debug("Listing scenarios: userId={}, filter={}, query={}", userId, filter, query);

        Page<ScenarioResponse> response;

        if (query != null && !query.isBlank()) {
            // Search mode
            response = scenarioService.searchScenarios(query, pageable);
        } else if ("my".equals(filter) && userId != null) {
            // User's own scenarios
            response = scenarioService.listUserScenarios(userId, pageable);
        } else if ("public".equals(filter) || userId == null) {
            // Public scenarios only
            response = scenarioService.listPublicScenarios(pageable);
        } else {
            // Authenticated user: public + own scenarios
            response = scenarioService.listScenarios(userId, pageable);
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Update a scenario
     */
    @PutMapping("/{id}")
    @Operation(summary = "Update scenario", description = "Updates an existing scenario. User must be the owner.")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Scenario updated successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid request data"),
            @ApiResponse(responseCode = "403", description = "Not authorized to update this scenario"),
            @ApiResponse(responseCode = "404", description = "Scenario not found")
    })
    public ResponseEntity<ScenarioResponse> updateScenario(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody UpdateScenarioRequest request) {

        log.info("Updating scenario: id={}, userId={}", id, userId);

        ScenarioResponse response = scenarioService.updateScenario(id, userId, request);

        return ResponseEntity.ok(response);
    }

    /**
     * Delete a scenario
     */
    @DeleteMapping("/{id}")
    @Operation(summary = "Delete scenario", description = "Deletes a scenario. User must be the owner. Leaf scenarios are cascade deleted.")
    @ApiResponses({
            @ApiResponse(responseCode = "204", description = "Scenario deleted successfully"),
            @ApiResponse(responseCode = "403", description = "Not authorized to delete this scenario"),
            @ApiResponse(responseCode = "404", description = "Scenario not found")
    })
    public ResponseEntity<Void> deleteScenario(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId) {

        log.info("Deleting scenario: id={}, userId={}", id, userId);

        scenarioService.deleteScenario(id, userId);

        return ResponseEntity.noContent().build();
    }

    /**
     * Fork a scenario
     * Only root scenarios can be forked (max depth = 1)
     */
    @PostMapping("/{id}/fork")
    @Operation(summary = "Fork a scenario", description = "Creates a new leaf scenario forked from a root scenario. Only root scenarios can be forked.")
    @ApiResponses({
            @ApiResponse(responseCode = "201", description = "Scenario forked successfully"),
            @ApiResponse(responseCode = "400", description = "Cannot fork (already forked or is a leaf scenario)"),
            @ApiResponse(responseCode = "403", description = "Not authorized to fork this scenario"),
            @ApiResponse(responseCode = "404", description = "Parent scenario not found")
    })
    public ResponseEntity<ScenarioResponse> forkScenario(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID userId,
            @Valid @RequestBody(required = false) ForkScenarioRequest request) {

        log.info("Forking scenario: parentId={}, userId={}", id, userId);

        // Use empty request if none provided
        ForkScenarioRequest forkRequest = request != null ? request : new ForkScenarioRequest();

        ScenarioResponse response = scenarioService.forkScenario(id, userId, forkRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Get scenario tree (root with all leaf children)
     */
    @GetMapping("/{id}/tree")
    @Operation(summary = "Get scenario tree", description = "Retrieves the complete scenario tree including root and all forked leaf scenarios")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Scenario tree retrieved successfully"),
            @ApiResponse(responseCode = "404", description = "Root scenario not found")
    })
    public ResponseEntity<ScenarioTreeResponse> getScenarioTree(
            @PathVariable UUID id) {

        log.debug("Getting scenario tree: rootId={}", id);

        ScenarioTreeResponse response = scenarioService.getScenarioTree(id);

        return ResponseEntity.ok(response);
    }

    /**
     * Get user's scenario count
     */
    @GetMapping("/count")
    @Operation(summary = "Get scenario count", description = "Returns the number of scenarios created by the user")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Count retrieved successfully")
    })
    public ResponseEntity<Long> getScenarioCount(
            @RequestHeader("X-User-Id") UUID userId) {

        log.debug("Getting scenario count: userId={}", userId);

        long count = scenarioService.countUserScenarios(userId);

        return ResponseEntity.ok(count);
    }
}
