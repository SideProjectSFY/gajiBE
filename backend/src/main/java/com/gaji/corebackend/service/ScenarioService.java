package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.*;
import com.gaji.corebackend.entity.LeafUserScenario;
import com.gaji.corebackend.entity.RootUserScenario;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.exception.ForbiddenException;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.repository.LeafUserScenarioRepository;
import com.gaji.corebackend.repository.RootUserScenarioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
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

    private final RootUserScenarioRepository rootScenarioRepository;
    private final LeafUserScenarioRepository leafScenarioRepository;

    /**
     * Create a new root scenario
     */
    @Transactional
    public ScenarioResponse createScenario(UUID userId, CreateScenarioRequest request) {
        log.info("Creating scenario: userId={}, title={}", userId, request.getTitle());

        RootUserScenario scenario = RootUserScenario.builder()
                .userId(userId)
                .baseScenarioId(request.getBaseScenarioId())
                .title(request.getTitle())
                .description(request.getDescription())
                .whatIfQuestion(request.getWhatIfQuestion())
                .isPublic(request.getIsPublic() != null ? request.getIsPublic() : false)
                .forkCount(0)
                .build();

        RootUserScenario saved = rootScenarioRepository.save(scenario);
        log.info("Scenario created: id={}", saved.getId());

        return ScenarioResponse.from(saved);
    }

    /**
     * Get scenario by ID (either root or leaf)
     */
    @Transactional(readOnly = true)
    public ScenarioResponse getScenario(UUID id) {
        // Try to find as root scenario first
        return rootScenarioRepository.findById(id)
                .map(ScenarioResponse::from)
                .orElseGet(() ->
                    // Try as leaf scenario
                    leafScenarioRepository.findById(id)
                        .map(ScenarioResponse::from)
                        .orElseThrow(() -> new ResourceNotFoundException("Scenario not found: " + id))
                );
    }

    /**
     * Get scenario by ID, verifying access permissions
     */
    @Transactional(readOnly = true)
    public ScenarioResponse getScenarioWithAccess(UUID id, UUID userId) {
        ScenarioResponse scenario = getScenario(id);

        // Check if user can access this scenario
        if (!scenario.getIsPublic() && !scenario.getUserId().equals(userId)) {
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

        // Get accessible scenarios (public + user's own)
        return rootScenarioRepository.findAccessibleScenarios(userId, pageable)
                .map(ScenarioResponse::from);
    }

    /**
     * List user's own scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listUserScenarios(UUID userId, Pageable pageable) {
        log.debug("Listing user's scenarios: userId={}", userId);
        return rootScenarioRepository.findByUserId(userId, pageable)
                .map(ScenarioResponse::from);
    }

    /**
     * List public scenarios with pagination
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> listPublicScenarios(Pageable pageable) {
        log.debug("Listing public scenarios");
        return rootScenarioRepository.findByIsPublicTrue(pageable)
                .map(ScenarioResponse::from);
    }

    /**
     * Search public scenarios by title/description
     */
    @Transactional(readOnly = true)
    public Page<ScenarioResponse> searchScenarios(String query, Pageable pageable) {
        log.debug("Searching scenarios: query={}", query);
        return rootScenarioRepository.searchPublicScenarios(query, pageable)
                .map(ScenarioResponse::from);
    }

    /**
     * Update an existing scenario
     */
    @Transactional
    public ScenarioResponse updateScenario(UUID id, UUID userId, UpdateScenarioRequest request) {
        log.info("Updating scenario: id={}, userId={}", id, userId);

        // Try to find as root scenario first
        RootUserScenario rootScenario = rootScenarioRepository.findById(id).orElse(null);

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
            if (request.getIsPublic() != null) {
                rootScenario.setIsPublic(request.getIsPublic());
            }

            RootUserScenario saved = rootScenarioRepository.save(rootScenario);
            log.info("Root scenario updated: id={}", saved.getId());
            return ScenarioResponse.from(saved);
        }

        // Try as leaf scenario
        LeafUserScenario leafScenario = leafScenarioRepository.findById(id)
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
        if (request.getIsPublic() != null) {
            leafScenario.setIsPublic(request.getIsPublic());
        }

        LeafUserScenario saved = leafScenarioRepository.save(leafScenario);
        log.info("Leaf scenario updated: id={}", saved.getId());
        return ScenarioResponse.from(saved);
    }

    /**
     * Delete a scenario (hard delete)
     * Note: Leaf scenarios of a deleted root are CASCADE deleted by DB
     */
    @Transactional
    public void deleteScenario(UUID id, UUID userId) {
        log.info("Deleting scenario: id={}, userId={}", id, userId);

        // Try to find as root scenario first
        RootUserScenario rootScenario = rootScenarioRepository.findById(id).orElse(null);

        if (rootScenario != null) {
            // Verify ownership
            if (!rootScenario.getUserId().equals(userId)) {
                throw new ForbiddenException("You don't have permission to delete this scenario");
            }

            rootScenarioRepository.delete(rootScenario);
            log.info("Root scenario deleted: id={}", id);
            return;
        }

        // Try as leaf scenario
        LeafUserScenario leafScenario = leafScenarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Scenario not found: " + id));

        // Verify ownership
        if (!leafScenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to delete this scenario");
        }

        // Decrement parent's fork count
        rootScenarioRepository.findById(leafScenario.getParentScenarioId())
                .ifPresent(parent -> {
                    parent.setForkCount(Math.max(0, parent.getForkCount() - 1));
                    rootScenarioRepository.save(parent);
                });

        leafScenarioRepository.delete(leafScenario);
        log.info("Leaf scenario deleted: id={}", id);
    }

    /**
     * Fork a root scenario to create a leaf scenario
     * Only root scenarios can be forked (max depth = 1)
     */
    @Transactional
    public ScenarioResponse forkScenario(UUID parentId, UUID userId, ForkScenarioRequest request) {
        log.info("Forking scenario: parentId={}, userId={}", parentId, userId);

        // Find parent root scenario
        RootUserScenario parentScenario = rootScenarioRepository.findById(parentId)
                .orElseThrow(() -> new ResourceNotFoundException("Parent scenario not found: " + parentId));

        // Check if parent is public or owned by user
        if (!parentScenario.getIsPublic() && !parentScenario.getUserId().equals(userId)) {
            throw new ForbiddenException("You don't have permission to fork this scenario");
        }

        // Check if user already forked this scenario
        if (leafScenarioRepository.existsByParentScenarioIdAndUserId(parentId, userId)) {
            throw new BadRequestException("You have already forked this scenario");
        }

        // Cannot fork a leaf scenario (check if this ID exists as a leaf)
        if (leafScenarioRepository.existsById(parentId)) {
            throw new BadRequestException("Cannot fork a leaf scenario. Only root scenarios can be forked.");
        }

        // Create leaf scenario
        String title = request.getTitle() != null ?
                request.getTitle() :
                "Fork of " + parentScenario.getTitle();

        String whatIfQuestion = request.getWhatIfQuestion() != null ?
                request.getWhatIfQuestion() :
                parentScenario.getWhatIfQuestion();

        LeafUserScenario leafScenario = LeafUserScenario.builder()
                .userId(userId)
                .parentScenarioId(parentId)
                .title(title)
                .description(request.getDescription())
                .whatIfQuestion(whatIfQuestion)
                .isPublic(request.getIsPublic() != null ? request.getIsPublic() : false)
                .build();

        LeafUserScenario saved = leafScenarioRepository.save(leafScenario);

        // Increment parent's fork count
        parentScenario.incrementForkCount();
        rootScenarioRepository.save(parentScenario);

        log.info("Scenario forked: parentId={}, newId={}", parentId, saved.getId());
        return ScenarioResponse.from(saved);
    }

    /**
     * Get scenario tree (root with all its leaf children)
     */
    @Transactional(readOnly = true)
    public ScenarioTreeResponse getScenarioTree(UUID rootId) {
        log.debug("Getting scenario tree: rootId={}", rootId);

        // Verify root scenario exists
        RootUserScenario rootScenario = rootScenarioRepository.findById(rootId)
                .orElseThrow(() -> new ResourceNotFoundException("Root scenario not found: " + rootId));

        // Get all leaf children
        List<LeafUserScenario> children = leafScenarioRepository.findByParentScenarioId(rootId);

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

        List<Object[]> results = leafScenarioRepository.findScenarioTree(rootId);

        if (results.isEmpty()) {
            throw new ResourceNotFoundException("Scenario not found: " + rootId);
        }

        ScenarioResponse root = null;
        List<ScenarioResponse> children = new ArrayList<>();

        for (Object[] row : results) {
            ScenarioResponse scenario = mapRowToScenarioResponse(row);

            if ("root".equals(row[12])) { // scenario_type column
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
    private ScenarioResponse mapRowToScenarioResponse(Object[] row) {
        return ScenarioResponse.builder()
                .id((UUID) row[0])
                .userId((UUID) row[1])
                .baseScenarioId((UUID) row[2])
                .title((String) row[3])
                .description((String) row[4])
                .whatIfQuestion((String) row[5])
                .isPublic((Boolean) row[6])
                .forkCount(row[7] != null ? ((Number) row[7]).intValue() : null)
                .createdAt(row[8] != null ? ((java.sql.Timestamp) row[8]).toLocalDateTime() : null)
                .updatedAt(row[9] != null ? ((java.sql.Timestamp) row[9]).toLocalDateTime() : null)
                .parentScenarioId((UUID) row[10])
                .scenarioType("root".equals(row[12]) ?
                        ScenarioResponse.ScenarioType.ROOT :
                        ScenarioResponse.ScenarioType.LEAF)
                .build();
    }

    /**
     * Count user's scenarios
     */
    @Transactional(readOnly = true)
    public long countUserScenarios(UUID userId) {
        return rootScenarioRepository.countByUserId(userId);
    }
}
