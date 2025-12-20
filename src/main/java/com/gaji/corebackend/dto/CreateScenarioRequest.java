package com.gaji.corebackend.dto;

import com.gaji.corebackend.dto.scenario.CharacterPropertyChange;
import com.gaji.corebackend.dto.scenario.EventAlteration;
import com.gaji.corebackend.dto.scenario.SettingModification;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

/**
 * Request DTO for creating a new scenario (Unified Modal Design)
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CreateScenarioRequest {

    /**
     * Novel ID (book) this scenario is based on (required)
     */
    @NotNull(message = "Novel ID is required")
    private UUID novelId;

    /**
     * Optional base scenario ID to link to
     */
    private UUID baseScenarioId;

    /**
     * Scenario title (required, max 255 chars)
     */
    @NotBlank(message = "Scenario title is required")
    @Size(max = 255, message = "Scenario title must not exceed 255 characters")
    private String scenarioTitle;

    /**
     * Character Property Changes (캐릭터 속성 변경)
     * 설명: 캐릭터의 속성(성격, 소속, 능력, 배경 등)을 변경하는 방식
     * 예시: "만약 헤르미온이가 슬리데린에 배정되었다면?"
     */
    private List<CharacterPropertyChange> characterPropertyChanges;

    /**
     * Character changes (optional, min 10 chars if provided) - Legacy field
     * Validated in service layer for "at least one type" rule
     */
    private String characterChanges;

    /**
     * Event Alterations (사건 결과 변경)
     * 설명: 스토리의 주요 사건이 다르게 진행되거나 발생하지 않는 방식
     * 예시: "만약 개츠비가 데이지를 다시 만나지 않았다면?"
     */
    private List<EventAlteration> eventAlterationsList;

    /**
     * Event alterations (optional, min 10 chars if provided) - Legacy field
     * Validated in service layer for "at least one type" rule
     */
    private String eventAlterations;

    /**
     * Setting Modifications (배경/세계관 수정)
     * 설명: 스토리의 배경, 시대, 장소, 문화적 맥락을 변경하는 방식
     * 예시: "만약 오만과 편견이 2024년 서울에서 일어났다면?"
     */
    private List<SettingModification> settingModificationsList;

    /**
     * Setting modifications (optional, min 10 chars if provided) - Legacy field
     * Validated in service layer for "at least one type" rule
     */
    private String settingModifications;

    /**
     * Scenario description (optional, for backward compatibility)
     */
    @Size(max = 5000, message = "Description must not exceed 5000 characters")
    private String description;

    /**
     * The "What If?" question for this scenario (optional, auto-generated from types if not provided)
     */
    @Size(max = 2000, message = "What If question must not exceed 2000 characters")
    private String whatIfQuestion;

    /**
     * Whether this scenario is private (default: false, meaning public)
     */
    @Builder.Default
    private Boolean isPrivate = false;

    /**
     * Scenario type (required): CHARACTER_CHANGE, EVENT_ALTERATION, or SETTING_MODIFICATION
     * Auto-determined from provided change types if not explicitly set
     */
    private String scenarioType;
}
