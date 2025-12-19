package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Response DTO for scenario tree (root with children)
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScenarioTreeResponse {

    /**
     * The root scenario
     */
    private ScenarioResponse root;

    /**
     * List of leaf (forked) scenarios
     */
    private List<ScenarioResponse> children;

    /**
     * Total number of nodes in the tree
     */
    private int totalCount;

    /**
     * Maximum depth of the tree (always 1 for current design)
     */
    private int maxDepth;
}
