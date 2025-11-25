package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.CreateScenarioRequest;
import com.gaji.corebackend.entity.Novel;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.repository.NovelRepository;
import com.gaji.corebackend.repository.RootUserScenarioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.util.retry.Retry;

import java.time.Duration;
import java.util.*;

/**
 * Scenario validation service
 * Validates scenarios before creation:
 * - Basic validation (fast, no AI)
 * - AI validation via FastAPI (Gemini 2.5 Flash)
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ScenarioValidator {

    private final NovelRepository novelRepository;
    private final RootUserScenarioRepository rootScenarioRepository;
    private final WebClient fastApiClient;

    @Value("${fastapi.base-url:http://localhost:8000}")
    private String fastApiUrl;

    private static final Set<String> PROFANITY_LIST = Set.of(
            // Basic profanity filter (expand as needed)
            "damn", "hell", "shit", "fuck", "ass", "bitch", "bastard"
    );

    private static final int MIN_SCENARIO_LENGTH = 10;
    private static final int MAX_TITLE_LENGTH = 100;

    /**
     * Validate scenario before creation
     *
     * @param request Scenario creation request
     * @return ValidationResult with errors if invalid
     */
    public ValidationResult validateScenario(CreateScenarioRequest request) {
        List<String> errors = new ArrayList<>();

        // 1. Basic validation (fast, no AI needed)
        validateTitle(request, errors);
        validateScenarioTypes(request, errors);
        validateNovel(request, errors);
        validateProfanity(request, errors);
        validateDuplicate(request, errors);

        // If basic validation fails, skip AI validation (save API costs)
        if (!errors.isEmpty()) {
            return ValidationResult.invalid(errors);
        }

        // 2. AI validation via FastAPI (Gemini 2.5 Flash)
        try {
            AIValidationResponse aiValidation = callFastApiValidation(request);

            if (!aiValidation.isValid()) {
                errors.addAll(aiValidation.getErrors());
            }

            return errors.isEmpty()
                    ? ValidationResult.valid(aiValidation)
                    : ValidationResult.invalid(errors);
        } catch (Exception e) {
            // AI validation failure - log but don't block (fallback to basic validation)
            log.error("AI validation failed: {}", e.getMessage());
            return ValidationResult.valid(); // Graceful degradation
        }
    }

    /**
     * Validate scenario title
     */
    private void validateTitle(CreateScenarioRequest request, List<String> errors) {
        if (request.getScenarioTitle() == null || request.getScenarioTitle().trim().isEmpty()) {
            errors.add("Scenario title is required");
        } else if (request.getScenarioTitle().length() > MAX_TITLE_LENGTH) {
            errors.add("Scenario title must be " + MAX_TITLE_LENGTH + " characters or less");
        }
    }

    /**
     * Validate scenario types (at least one with min length)
     */
    private void validateScenarioTypes(CreateScenarioRequest request, List<String> errors) {
        String charChanges = request.getCharacterChanges();
        String eventAlters = request.getEventAlterations();
        String settingMods = request.getSettingModifications();

        boolean hasCharChanges = charChanges != null && charChanges.trim().length() >= MIN_SCENARIO_LENGTH;
        boolean hasEventAlters = eventAlters != null && eventAlters.trim().length() >= MIN_SCENARIO_LENGTH;
        boolean hasSettingMods = settingMods != null && settingMods.trim().length() >= MIN_SCENARIO_LENGTH;

        // At least one type must be filled with min length
        if (!hasCharChanges && !hasEventAlters && !hasSettingMods) {
            errors.add("At least one scenario type must have minimum " + MIN_SCENARIO_LENGTH + " characters");
        }

        // Min length validation for FILLED fields
        if (charChanges != null && !charChanges.trim().isEmpty() && charChanges.trim().length() < MIN_SCENARIO_LENGTH) {
            errors.add("Character Changes must be at least " + MIN_SCENARIO_LENGTH + " characters if provided");
        }

        if (eventAlters != null && !eventAlters.trim().isEmpty() && eventAlters.trim().length() < MIN_SCENARIO_LENGTH) {
            errors.add("Event Alterations must be at least " + MIN_SCENARIO_LENGTH + " characters if provided");
        }

        if (settingMods != null && !settingMods.trim().isEmpty() && settingMods.trim().length() < MIN_SCENARIO_LENGTH) {
            errors.add("Setting Modifications must be at least " + MIN_SCENARIO_LENGTH + " characters if provided");
        }
    }

    /**
     * Validate novel exists
     */
    private void validateNovel(CreateScenarioRequest request, List<String> errors) {
        if (request.getNovelId() == null) {
            errors.add("Novel ID is required");
            return;
        }

        Optional<Novel> novel = novelRepository.findById(request.getNovelId());
        if (novel.isEmpty()) {
            errors.add("Novel not found: " + request.getNovelId());
        }
    }

    /**
     * Check for profanity
     */
    private void validateProfanity(CreateScenarioRequest request, List<String> errors) {
        String allText = request.getScenarioTitle() + " " +
                (request.getCharacterChanges() != null ? request.getCharacterChanges() : "") + " " +
                (request.getEventAlterations() != null ? request.getEventAlterations() : "") + " " +
                (request.getSettingModifications() != null ? request.getSettingModifications() : "");

        boolean containsProfanity = PROFANITY_LIST.stream()
                .anyMatch(word -> allText.toLowerCase().contains(word));

        if (containsProfanity) {
            errors.add("Scenario contains inappropriate content");
        }
    }

    /**
     * Check for duplicate scenario
     */
    private void validateDuplicate(CreateScenarioRequest request, List<String> errors) {
        String contentHash = generateContentHash(request);

        boolean exists = rootScenarioRepository.existsByNovelIdAndContentHash(
                request.getNovelId(),
                contentHash
        );

        if (exists) {
            errors.add("A similar scenario already exists");
        }
    }

    /**
     * Generate content hash for duplicate detection
     */
    public String generateContentHash(CreateScenarioRequest request) {
        String content = request.getScenarioTitle() + "|" +
                (request.getCharacterChanges() != null ? request.getCharacterChanges() : "") + "|" +
                (request.getEventAlterations() != null ? request.getEventAlterations() : "") + "|" +
                (request.getSettingModifications() != null ? request.getSettingModifications() : "");
        return DigestUtils.md5DigestAsHex(content.getBytes());
    }

    /**
     * Call FastAPI for AI validation (Gemini 2.5 Flash)
     */
    private AIValidationResponse callFastApiValidation(CreateScenarioRequest request) {
        // Get novel title for validation prompt
        Novel novel = novelRepository.findById(request.getNovelId())
                .orElseThrow(() -> new BadRequestException("Novel not found"));

        // Build filled types map (only include filled fields)
        Map<String, String> filledTypes = new HashMap<>();

        if (request.getCharacterChanges() != null && request.getCharacterChanges().trim().length() >= MIN_SCENARIO_LENGTH) {
            filledTypes.put("character_changes", request.getCharacterChanges());
        }

        if (request.getEventAlterations() != null && request.getEventAlterations().trim().length() >= MIN_SCENARIO_LENGTH) {
            filledTypes.put("event_alterations", request.getEventAlterations());
        }

        if (request.getSettingModifications() != null && request.getSettingModifications().trim().length() >= MIN_SCENARIO_LENGTH) {
            filledTypes.put("setting_modifications", request.getSettingModifications());
        }

        // Call FastAPI endpoint
        return fastApiClient.post()
                .uri("/api/validate-scenario")
                .bodyValue(Map.of(
                        "book_title", novel.getTitle(),
                        "scenario_title", request.getScenarioTitle(),
                        "filled_types", filledTypes
                ))
                .retrieve()
                .bodyToMono(AIValidationResponse.class)
                .timeout(Duration.ofSeconds(10))  // Gemini API can be slow
                .retryWhen(Retry.backoff(3, Duration.ofSeconds(1)))  // 3 retries: 1s, 2s, 4s
                .block();
    }

    /**
     * Validation result
     */
    public static class ValidationResult {
        private final boolean valid;
        private final List<String> errors;
        private final AIValidationResponse aiValidation;

        private ValidationResult(boolean valid, List<String> errors, AIValidationResponse aiValidation) {
            this.valid = valid;
            this.errors = errors;
            this.aiValidation = aiValidation;
        }

        public static ValidationResult valid() {
            return new ValidationResult(true, Collections.emptyList(), null);
        }

        public static ValidationResult valid(AIValidationResponse aiValidation) {
            return new ValidationResult(true, Collections.emptyList(), aiValidation);
        }

        public static ValidationResult invalid(List<String> errors) {
            return new ValidationResult(false, errors, null);
        }

        public boolean isValid() {
            return valid;
        }

        public List<String> getErrors() {
            return errors;
        }

        public AIValidationResponse getAiValidation() {
            return aiValidation;
        }
    }

    /**
     * AI validation response from FastAPI
     */
    public static class AIValidationResponse {
        private boolean isValid;
        private List<String> errors;
        private double creativityScore;
        private String reasoning;

        public AIValidationResponse() {}

        public boolean isValid() {
            return isValid;
        }

        public void setValid(boolean valid) {
            isValid = valid;
        }

        public List<String> getErrors() {
            return errors != null ? errors : Collections.emptyList();
        }

        public void setErrors(List<String> errors) {
            this.errors = errors;
        }

        public double getCreativityScore() {
            return creativityScore;
        }

        public void setCreativityScore(double creativityScore) {
            this.creativityScore = creativityScore;
        }

        public String getReasoning() {
            return reasoning;
        }

        public void setReasoning(String reasoning) {
            this.reasoning = reasoning;
        }
    }
}

