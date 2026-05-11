package com.gaji.scenario.application;

import com.gaji.shared.contract.dto.CreateScenarioRequest;
import com.gaji.content.application.ContentFacade;
import com.gaji.scenario.domain.repository.RootUserScenarioRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.*;

/**
 * Scenario validation service
 * Validates scenarios before creation:
 * - Basic validation only
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class ScenarioValidator {

    private final ContentFacade contentFacade;
    private final RootUserScenarioRepository rootScenarioRepository;

    private static final Set<String> PROFANITY_LIST = Set.of(
            // Basic profanity filter (expand as needed)
            "damn", "hell", "shit", "fuck", "ass", "bitch", "bastard"
    );

    private static final int MAX_TITLE_LENGTH = 255;

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

        return ValidationResult.valid();
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

        boolean hasCharChanges = charChanges != null && !charChanges.trim().isEmpty();
        boolean hasEventAlters = eventAlters != null && !eventAlters.trim().isEmpty();
        boolean hasSettingMods = settingMods != null && !settingMods.trim().isEmpty();

        // At least one type must be filled
        if (!hasCharChanges && !hasEventAlters && !hasSettingMods) {
            errors.add("At least one scenario type is required");
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

        if (contentFacade.findNovelResponseById(request.getNovelId()).isEmpty()) {
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
     * Legacy AI validation response shape kept for API compatibility.
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
