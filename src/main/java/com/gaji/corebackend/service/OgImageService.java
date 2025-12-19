package com.gaji.corebackend.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaji.corebackend.entity.RootUserScenario;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service for generating dynamic Open Graph images for scenario sharing
 * Uses Puppeteer to render custom HTML templates
 */
@Service
@Slf4j
public class OgImageService {

    private static final String IMAGE_DIR = "public/og-images/";
    private static final String PUPPETEER_SCRIPT = "scripts/generate-og-image.js";

    @Value("${app.base-url:http://localhost:8080}")
    private String baseUrl;

    private final ObjectMapper objectMapper;

    public OgImageService(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        // Ensure image directory exists
        try {
            Files.createDirectories(Paths.get(IMAGE_DIR));
        } catch (Exception e) {
            log.error("Failed to create OG image directory", e);
        }
    }

    /**
     * Generate Open Graph image for a scenario
     * @param scenario The scenario to generate image for
     * @return URL to the generated image
     */
    public String generateOgImage(RootUserScenario scenario) {
        String filename = scenario.getId().toString() + ".png";
        String outputPath = IMAGE_DIR + filename;

        // Check if image already exists
        File imageFile = new File(outputPath);
        if (imageFile.exists()) {
            log.debug("Using cached OG image for scenario {}", scenario.getId());
            return baseUrl + "/og-images/" + filename;
        }

        try {
            // Prepare data for Puppeteer script
            Map<String, Object> scenarioData = new HashMap<>();
            scenarioData.put("title", buildScenarioTitle(scenario));
            scenarioData.put("baseStory", scenario.getTitle());
            scenarioData.put("whatIfQuestion", scenario.getWhatIfQuestion());
            scenarioData.put("scenarioCategory", scenario.getScenarioCategory() != null ? 
                scenario.getScenarioCategory().toString() : "GENERAL");
            scenarioData.put("forkCount", scenario.getForkCount());
            scenarioData.put("createdBy", "User-" + scenario.getUserId().toString().substring(0, 8));

            String scenarioJson = objectMapper.writeValueAsString(scenarioData);

            // Execute Puppeteer script
            ProcessBuilder pb = new ProcessBuilder(
                "node",
                PUPPETEER_SCRIPT,
                scenarioJson,
                outputPath
            );
            pb.redirectErrorStream(true);
            Process process = pb.start();

            // Read output for debugging
            String output = new BufferedReader(new InputStreamReader(process.getInputStream()))
                .lines().collect(Collectors.joining("\n"));

            int exitCode = process.waitFor();
            if (exitCode != 0) {
                log.error("Puppeteer failed with exit code {}: {}", exitCode, output);
                return getFallbackImageUrl();
            }

            log.info("Successfully generated OG image for scenario {}", scenario.getId());
            return baseUrl + "/og-images/" + filename;

        } catch (Exception e) {
            log.error("Failed to generate OG image for scenario {}", scenario.getId(), e);
            return getFallbackImageUrl();
        }
    }

    /**
     * Build scenario title for OG image
     */
    private String buildScenarioTitle(RootUserScenario scenario) {
        if (scenario.getScenarioCategory() != null) {
            String type = scenario.getScenarioCategory().toString()
                .replace("_", " ")
                .toLowerCase();
            return "What if... [" + capitalize(type) + "]";
        }
        return "What if...";
    }

    /**
     * Capitalize first letter of each word
     */
    private String capitalize(String text) {
        String[] words = text.split(" ");
        StringBuilder result = new StringBuilder();
        for (String word : words) {
            if (word.length() > 0) {
                result.append(Character.toUpperCase(word.charAt(0)))
                      .append(word.substring(1).toLowerCase())
                      .append(" ");
            }
        }
        return result.toString().trim();
    }

    /**
     * Get fallback image URL when generation fails
     */
    private String getFallbackImageUrl() {
        return baseUrl + "/og-images/default.png";
    }

    /**
     * Delete cached OG image for a scenario (called on scenario update)
     */
    public void deleteCachedImage(String scenarioId) {
        try {
            String filename = scenarioId + ".png";
            Path imagePath = Paths.get(IMAGE_DIR, filename);
            Files.deleteIfExists(imagePath);
            log.info("Deleted cached OG image for scenario {}", scenarioId);
        } catch (Exception e) {
            log.error("Failed to delete cached OG image for scenario {}", scenarioId, e);
        }
    }
}
