package com.gaji.corebackend.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.dto.scenario.CharacterPropertyChange;
import com.gaji.corebackend.dto.scenario.EventAlteration;
import com.gaji.corebackend.dto.scenario.SettingModification;
import com.gaji.corebackend.entity.LeafUserScenario;
import com.gaji.corebackend.entity.RootUserScenario;
import com.gaji.corebackend.enums.ScenarioType;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.exception.ForbiddenException;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.mapper.LeafUserScenarioMapper;
import com.gaji.corebackend.mapper.RootUserScenarioMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for scenario CRUD operations, forking, and tree retrieval
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ScenarioService {

    private final RootUserScenarioMapper rootScenarioMapper;
    private final LeafUserScenarioMapper leafScenarioMapper;
    private final ScenarioValidator scenarioValidator;
    private final ObjectMapper objectMapper;

    /**
     * Create a new root scenario
     */
    @Transactional
    public ScenarioResponse createScenario(UUID userId, CreateScenarioRequest request) {
        log.info("Creating scenario: userId={}, title={}", userId, request.getScenarioTitle());

        // Validate scenario
        ScenarioValidator.ValidationResult validation = scenarioValidator.validateScenario(request);
        if (!validation.isValid()) {
            String errors = String.join(", ", validation.getErrors());
            throw new BadRequestException("Scenario validation failed: " + errors);
        }

        // Generate what-if question from scenario types if not provided
        String whatIfQuestion = request.getWhatIfQuestion();
        if (whatIfQuestion == null || whatIfQuestion.trim().isEmpty()) {
            whatIfQuestion = generateWhatIfQuestion(request);
        }

        // Generate content hash for duplicate detection
        String contentHash = scenarioValidator.generateContentHash(request);

        // Determine scenario type based on which fields are filled
        ScenarioType scenarioType = determineScenarioType(request);

        // Serialize structured data to JSON strings
        String characterChangesJson = serializeToJson(request.getCharacterPropertyChanges());
        String eventAlterationsJson = serializeToJson(request.getEventAlterationsList());
        String settingModificationsJson = serializeToJson(request.getSettingModificationsList());

        // Use legacy fields if structured data not provided
        String finalCharacterChanges = characterChangesJson != null ? characterChangesJson : request.getCharacterChanges();
        String finalEventAlterations = eventAlterationsJson != null ? eventAlterationsJson : request.getEventAlterations();
        String finalSettingModifications = settingModificationsJson != null ? settingModificationsJson : request.getSettingModifications();

        RootUserScenario scenario = RootUserScenario.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .novelId(request.getNovelId())
                .baseScenarioId(request.getBaseScenarioId())
                .title(request.getScenarioTitle())
                .description(request.getDescription())
                .whatIfQuestion(whatIfQuestion)
                .scenarioType(scenarioType)
                .characterChanges(finalCharacterChanges)
                .eventAlterations(finalEventAlterations)
                .settingModifications(finalSettingModifications)
                .contentHash(contentHash)
                .isPrivate(request.getIsPrivate() != null ? request.getIsPrivate() : false)
                .forkCount(0)
                .build();

        rootScenarioMapper.insert(scenario);
        log.info("Scenario created: id={}", scenario.getId());

        return ScenarioResponse.from(scenario);
    }

    /**
     * Serialize object to JSON string
     */
    private String serializeToJson(Object object) {
        if (object == null) {
            return null;
        }
        
        try {
            String json = objectMapper.writeValueAsString(object);
            // Return null if it's an empty array or object
            if (json.equals("[]") || json.equals("{}")) {
                return null;
            }
            return json;
        } catch (JsonProcessingException e) {
            log.error("Failed to serialize object to JSON", e);
            return null;
        }
    }

    /**
     * Determine scenario type based on which fields are filled
     * Priority: CHARACTER_CHANGE > EVENT_ALTERATION > SETTING_MODIFICATION
     */
    private ScenarioType determineScenarioType(CreateScenarioRequest request) {
        // Check both structured and legacy fields
        boolean hasCharacter = (request.getCharacterPropertyChanges() != null && !request.getCharacterPropertyChanges().isEmpty()) ||
                              (request.getCharacterChanges() != null && !request.getCharacterChanges().trim().isEmpty());
        boolean hasEvent = (request.getEventAlterationsList() != null && !request.getEventAlterationsList().isEmpty()) ||
                          (request.getEventAlterations() != null && !request.getEventAlterations().trim().isEmpty());
        boolean hasSetting = (request.getSettingModificationsList() != null && !request.getSettingModificationsList().isEmpty()) ||
                            (request.getSettingModifications() != null && !request.getSettingModifications().trim().isEmpty());
        
        if (hasCharacter) {
            return ScenarioType.CHARACTER_CHANGE;
        } else if (hasEvent) {
            return ScenarioType.EVENT_ALTERATION;
        } else if (hasSetting) {
            return ScenarioType.SETTING_MODIFICATION;
        }
        
        // Default to CHARACTER_CHANGE if nothing is specified (shouldn't happen due to validation)
        return ScenarioType.CHARACTER_CHANGE;
    }

    /**
     * Generate what-if question from scenario types
     */
    private String generateWhatIfQuestion(CreateScenarioRequest request) {
        List<String> parts = new ArrayList<>();
        
        // Try structured data first
        if (request.getCharacterPropertyChanges() != null && !request.getCharacterPropertyChanges().isEmpty()) {
            parts.add(generateCharacterChangeSummary(request.getCharacterPropertyChanges()));
        } else if (request.getCharacterChanges() != null && !request.getCharacterChanges().trim().isEmpty()) {
            parts.add(request.getCharacterChanges().trim());
        }
        
        if (request.getEventAlterationsList() != null && !request.getEventAlterationsList().isEmpty()) {
            parts.add(generateEventAlterationSummary(request.getEventAlterationsList()));
        } else if (request.getEventAlterations() != null && !request.getEventAlterations().trim().isEmpty()) {
            parts.add(request.getEventAlterations().trim());
        }
        
        if (request.getSettingModificationsList() != null && !request.getSettingModificationsList().isEmpty()) {
            parts.add(generateSettingModificationSummary(request.getSettingModificationsList()));
        } else if (request.getSettingModifications() != null && !request.getSettingModifications().trim().isEmpty()) {
            parts.add(request.getSettingModifications().trim());
        }
        
        return "What if " + String.join(", and ", parts) + "?";
    }

    private String generateCharacterChangeSummary(List<CharacterPropertyChange> changes) {
        return changes.stream()
                .map(c -> c.getCharacterName() + "의 속성이 변경")
                .collect(Collectors.joining(", "));
    }

    private String generateEventAlterationSummary(List<EventAlteration> alterations) {
        return alterations.stream()
                .map(e -> e.getEventName() + "이(가) " + e.getAlterationType().getDescription())
                .collect(Collectors.joining(", "));
    }

    private String generateSettingModificationSummary(List<SettingModification> modifications) {
        List<String> changes = new ArrayList<>();
        for (SettingModification mod : modifications) {
            if (mod.getTimePeriod() != null) {
                changes.add("시간대 변경: " + mod.getTimePeriod().getModifiedPeriod());
            }
            if (mod.getLocation() != null) {
                changes.add("장소 변경: " + mod.getLocation().getModifiedLocation());
            }
        }
        return String.join(", ", changes);
    }

    /**
     * Get scenario by ID (either root or leaf)
     */
    @Transactional(readOnly = true)
    public ScenarioResponse getScenario(UUID id) {
        // Try to find as root scenario first
        return rootScenarioMapper.findById(id)
                .map(ScenarioResponse::from)
                .orElseGet(() ->
                    // Try as leaf scenario
                    leafScenarioMapper.findById(id)
                        .map(ScenarioResponse::from)
                        .orElseThrow(() -> new ResourceNotFoundException("Scenario not found: " + id))
                );
    }

    /**
     * Get root scenario entity (for internal use, e.g., OG image generation)
     */
    @Transactional(readOnly = true)
    public RootUserScenario getRootScenarioEntity(UUID id) {
        return rootScenarioMapper.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Root scenario not found: " + id));
    }

    /**
     * Get scenario by ID, verifying access permissions
     */
    @Transactional(readOnly = true)
    public ScenarioResponse getScenarioWithAccess(UUID id, UUID userId) {
        ScenarioResponse scenario = getScenario(id);

        // Check if user can access this scenario
        if (scenario.getIsPrivate() && !scenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to access this scenario");
        }

        return scenario;
    }

    /**
     * List scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listScenarios(UUID userId, Pageable pageable) {
        log.debug("Listing scenarios for user: {}", userId);

        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();

        List<RootUserScenario> scenarios = rootScenarioMapper.findAccessibleScenarios(userId, limit, offset);
        long total = rootScenarioMapper.countAccessibleScenarios(userId);

        List<ScenarioResponse> responses = scenarios.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * List user's own scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listUserScenarios(UUID userId, Pageable pageable) {
        log.debug("Listing user's scenarios: userId={}", userId);
        
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();

        List<RootUserScenario> scenarios = rootScenarioMapper.findByUserIdWithPaging(userId, limit, offset);
        long total = rootScenarioMapper.countByUserId(userId);

        List<ScenarioResponse> responses = scenarios.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * List user's public scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listUserPublicScenarios(UUID userId, Pageable pageable) {
        log.debug("Listing user's public scenarios: userId={}", userId);
        
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();

        List<RootUserScenario> scenarios = rootScenarioMapper.findPublicByUserIdWithPaging(userId, limit, offset);
        long total = rootScenarioMapper.countPublicByUserId(userId);

        List<ScenarioResponse> responses = scenarios.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * List public scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listPublicScenarios(Pageable pageable) {
        log.debug("Listing public scenarios");
        
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();

        List<RootUserScenario> scenarios = rootScenarioMapper.findByIsPrivateFalse(limit, offset);
        long total = rootScenarioMapper.countByIsPrivateFalse();

        List<ScenarioResponse> responses = scenarios.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * Search public scenarios by title/description
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> searchScenarios(String query, Pageable pageable) {
        log.debug("Searching scenarios: query={}", query);
        
        // Sanitize query: remove all special characters and extra spaces
        String sanitizedQuery = query;
        if (query != null) {
            sanitizedQuery = query.replaceAll("[^a-zA-Z0-9\\s]", "")
                                  .replaceAll("\\s+", " ")
                                  .trim();
        }
        
        // If sanitized query is empty, return empty page
        if (sanitizedQuery == null || sanitizedQuery.isEmpty()) {
            log.debug("Query is empty after sanitization, returning empty page");
            return Page.empty(pageable);
        }
        
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();

        List<RootUserScenario> scenarios = rootScenarioMapper.searchPublicScenarios(sanitizedQuery, limit, offset);
        long total = rootScenarioMapper.countSearchPublicScenarios(sanitizedQuery);

        List<ScenarioResponse> responses = scenarios.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * Update an existing scenario
     */
    @Transactional
    public ScenarioResponse updateScenario(UUID id, UUID userId, UpdateScenarioRequest request) {
        log.info("Updating scenario: id={}, userId={}", id, userId);

        // Try to find as root scenario first
        RootUserScenario rootScenario = rootScenarioMapper.findById(id).orElse(null);

        if (rootScenario != null) {
            // Verify ownership
            if (!rootScenario.getUserId().equals(userId)) {
                throw new ForbiddenException("You don't have permission to update this scenario");
            }

            // Apply updates
            if (request.getTitle() != null) {
                rootScenario.setTitle(request.getTitle());
            }
            if (request.getDescription() != null) {
                rootScenario.setDescription(request.getDescription());
            }
            if (request.getWhatIfQuestion() != null) {
                rootScenario.setWhatIfQuestion(request.getWhatIfQuestion());
            }
            if (request.getIsPrivate() != null) {
                rootScenario.setIsPrivate(request.getIsPrivate());
            }

            rootScenarioMapper.update(rootScenario);
            log.info("Root scenario updated: id={}", rootScenario.getId());
            return ScenarioResponse.from(rootScenario);
        }

        // Try as leaf scenario
        LeafUserScenario leafScenario = leafScenarioMapper.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Scenario not found: " + id));

        // Verify ownership
        if (!leafScenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to update this scenario");
        }

        // Apply updates
        if (request.getTitle() != null) {
            leafScenario.setTitle(request.getTitle());
        }
        if (request.getDescription() != null) {
            leafScenario.setDescription(request.getDescription());
        }
        if (request.getWhatIfQuestion() != null) {
            leafScenario.setWhatIfQuestion(request.getWhatIfQuestion());
        }
        if (request.getIsPrivate() != null) {
            leafScenario.setIsPrivate(request.getIsPrivate());
        }

        leafScenarioMapper.update(leafScenario);
        log.info("Leaf scenario updated: id={}", leafScenario.getId());
        return ScenarioResponse.from(leafScenario);
    }

    /**
     * Delete a scenario (hard delete)
     * Note: Leaf scenarios of a deleted root are CASCADE deleted by DB
     */
    @Transactional
    public void deleteScenario(UUID id, UUID userId) {
        log.info("Deleting scenario: id={}, userId={}", id, userId);

        // Try to find as root scenario first
        RootUserScenario rootScenario = rootScenarioMapper.findById(id).orElse(null);

        if (rootScenario != null) {
            // Verify ownership
            if (!rootScenario.getUserId().equals(userId)) {
                throw new ForbiddenException("You don't have permission to delete this scenario");
            }

            rootScenarioMapper.deleteById(id);
            log.info("Root scenario deleted: id={}", id);
            return;
        }

        // Try as leaf scenario
        LeafUserScenario leafScenario = leafScenarioMapper.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Scenario not found: " + id));

        // Verify ownership
        if (!leafScenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to delete this scenario");
        }

        // Decrement parent's fork count
        rootScenarioMapper.findById(leafScenario.getParentScenarioId())
                .ifPresent(parent -> {
                    parent.setForkCount(Math.max(0, parent.getForkCount() - 1));
                    rootScenarioMapper.update(parent);
                });

        leafScenarioMapper.deleteById(id);
        log.info("Leaf scenario deleted: id={}", id);
    }

    /**
     * Fork a root scenario to create a leaf scenario
     * Only root scenarios can be forked (max depth = 1)
     */
    @Transactional
    public ScenarioResponse forkScenario(UUID parentId, UUID userId, ForkScenarioRequest request) {
        log.info("Forking scenario: parentId={}, userId={}", parentId, userId);

        // Check if it's a leaf scenario first
        if (leafScenarioMapper.existsById(parentId)) {
            throw new BadRequestException("Cannot fork a leaf scenario. Only root scenarios can be forked.");
        }

        // Find parent root scenario
        RootUserScenario parentScenario = rootScenarioMapper.findById(parentId)
                .orElseThrow(() -> new ResourceNotFoundException("Parent scenario not found: " + parentId));

        // Check if parent is public or owned by user
        if (parentScenario.getIsPrivate() && !parentScenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to fork this scenario");
        }

        // Check if user already forked this scenario
        if (leafScenarioMapper.existsByParentScenarioIdAndUserId(parentId, userId)) {
            throw new BadRequestException("You have already forked this scenario");
        }

        // Create leaf scenario
        String title = request.getTitle() != null ?
                request.getTitle() :
                "Fork of " + parentScenario.getTitle();

        String whatIfQuestion = request.getWhatIfQuestion() != null ?
                request.getWhatIfQuestion() :
                parentScenario.getWhatIfQuestion();

        LeafUserScenario leafScenario = LeafUserScenario.builder()
                .id(UUID.randomUUID())
                .userId(userId)
                .parentScenarioId(parentId)
                .title(title)
                .description(request.getDescription())
                .whatIfQuestion(whatIfQuestion)
                .scenarioType(parentScenario.getScenarioType())
                .isPrivate(request.getIsPrivate() != null ? request.getIsPrivate() : false)
                .build();

        leafScenarioMapper.insert(leafScenario);

        // Increment parent's fork count
        parentScenario.incrementForkCount();
        rootScenarioMapper.update(parentScenario);

        log.info("Scenario forked: parentId={}, newId={}", parentId, leafScenario.getId());
        return ScenarioResponse.from(leafScenario);
    }

    /**
     * Get scenario tree (root with all its leaf children)
     */
    @Transactional(readOnly = true)
    public ScenarioTreeResponse getScenarioTree(UUID rootId) {
        log.debug("Getting scenario tree: rootId={}", rootId);

        // Verify root scenario exists
        RootUserScenario rootScenario = rootScenarioMapper.findById(rootId)
                .orElseThrow(() -> new ResourceNotFoundException("Root scenario not found: " + rootId));

        // Get all leaf children
        List<LeafUserScenario> children = leafScenarioMapper.findByParentScenarioId(rootId);

        List<ScenarioResponse> childResponses = children.stream()
                .map(ScenarioResponse::from)
                .collect(Collectors.toList());

        return ScenarioTreeResponse.builder()
                .root(ScenarioResponse.from(rootScenario))
                .children(childResponses)
                .totalCount(1 + childResponses.size())
                .maxDepth(childResponses.isEmpty() ? 0 : 1)
                .build();
    }

    /**
     * Get scenario tree using recursive CTE (for complex tree queries)
     * Note: Current design only allows depth 1, but this supports future expansion
     */
    @Transactional(readOnly = true)
    public ScenarioTreeResponse getScenarioTreeRecursive(UUID rootId) {
        log.debug("Getting scenario tree (recursive CTE): rootId={}", rootId);

        List<java.util.Map<String, Object>> results = leafScenarioMapper.findScenarioTree(rootId);

        if (results.isEmpty()) {
            throw new ResourceNotFoundException("Scenario not found: " + rootId);
        }

        ScenarioResponse root = null;
        List<ScenarioResponse> children = new ArrayList<>();

        for (java.util.Map<String, Object> row : results) {
            ScenarioResponse scenario = mapRowToScenarioResponse(row);

            if ("root".equals(row.get("scenario_type"))) { // scenario_type column
                root = scenario;
            } else {
                children.add(scenario);
            }
        }

        if (root == null) {
            throw new ResourceNotFoundException("Root scenario not found: " + rootId);
        }

        return ScenarioTreeResponse.builder()
                .root(root)
                .children(children)
                .totalCount(1 + children.size())
                .maxDepth(children.isEmpty() ? 0 : 1)
                .build();
    }

    /**
     * Map native query result row to ScenarioResponse
     */
    private ScenarioResponse mapRowToScenarioResponse(java.util.Map<String, Object> row) {
        return ScenarioResponse.builder()
                .id((UUID) row.get("id"))
                .userId((UUID) row.get("user_id"))
                .baseScenarioId((UUID) row.get("base_scenario_id"))
                .title((String) row.get("title"))
                .description((String) row.get("description"))
                .whatIfQuestion((String) row.get("what_if_question"))
                .isPrivate((Boolean) row.get("is_private"))
                .forkCount(row.get("fork_count") != null ? ((Number) row.get("fork_count")).intValue() : null)
                .createdAt(row.get("created_at") != null ? ((java.sql.Timestamp) row.get("created_at")).toLocalDateTime() : null)
                .updatedAt(row.get("updated_at") != null ? ((java.sql.Timestamp) row.get("updated_at")).toLocalDateTime() : null)
                .parentScenarioId((UUID) row.get("parent_scenario_id"))
                .scenarioType("root".equals(row.get("scenario_type")) ?
                        ScenarioResponse.ScenarioType.ROOT :
                        ScenarioResponse.ScenarioType.LEAF)
                .build();
    }

    /**
     * Count user's scenarios
     */
    @Transactional(readOnly = true)
    public long countUserScenarios(UUID userId) {
        return rootScenarioMapper.countByUserId(userId);
    }

    /**
     * Advanced search with filters
     * Story 3.6: Scenario Search & Advanced Filtering
     *
     * @param query Search query text
     * @param scenarioCategory Optional scenario category filter
     * @param creatorId Optional creator ID filter
     * @param pageable Pagination parameters
     * @return Page of matching scenarios
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> searchWithAdvancedFilters(
            String query,
            String scenarioCategory,
            UUID creatorId,
            Pageable pageable) {

        log.debug("Advanced search: query={}, category={}, creator={}",
                query, scenarioCategory, creatorId);

        // Sanitize query: remove all special characters and extra spaces
        String sanitizedQuery = query;
        if (query != null) {
            sanitizedQuery = query.replaceAll("[^a-zA-Z0-9\\s]", "")
                                  .replaceAll("\\s+", " ")
                                  .trim();
        }

        Page<RootUserScenario> results;

        if (sanitizedQuery != null && !sanitizedQuery.isEmpty()) {
            // Full-text search with filters
            String creatorIdStr = creatorId != null ? creatorId.toString() : null;
            int limit = pageable.getPageSize();
            int offset = (int) pageable.getOffset();
            
            List<RootUserScenario> content = rootScenarioMapper.searchWithFilters(
                    sanitizedQuery,
                    scenarioCategory,
                    creatorIdStr,
                    limit,
                    offset
            );
            
            long total = rootScenarioMapper.countSearchResults(
                    sanitizedQuery,
                    scenarioCategory,
                    creatorIdStr
            );
            
            results = new PageImpl<>(content, pageable, total);
        } else {
            // Filter-only search (no text query)
            com.gaji.corebackend.entity.ScenarioCategory category = null;
            if (scenarioCategory != null) {
                try {
                    category = com.gaji.corebackend.entity.ScenarioCategory.valueOf(scenarioCategory);
                } catch (IllegalArgumentException e) {
                    log.warn("Invalid scenario category: {}", scenarioCategory);
                }
            }

            int limit = pageable.getPageSize();
            int offset = (int) pageable.getOffset();

            List<RootUserScenario> content = rootScenarioMapper.filterScenarios(
                    category,
                    creatorId,
                    limit,
                    offset
            );
            
            long total = rootScenarioMapper.countFilterScenarios(
                    category,
                    creatorId
            );
            
            results = new PageImpl<>(content, pageable, total);
        }

        return results.map(ScenarioResponse::from);
    }
}
