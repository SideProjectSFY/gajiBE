package com.gaji.corebackend.dto;

import com.gaji.corebackend.entity.NovelCharacter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * Response DTO for character data
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NovelCharacterResponse {

    private UUID id;
    private UUID novelId;
    private String commonName;
    private Boolean isMainCharacter;
    private String[] alternativeNames;
    private String description;
    private String portraitPrompt;
    private String persona;
    private String personaEn;
    private String personaKo;
    private String speakingStyle;
    private String speakingStyleEn;
    private String speakingStyleKo;
    private String vectordbCharacterId;
    private Integer charGraphId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Create response from entity
     */
    public static NovelCharacterResponse from(NovelCharacter character) {
        return NovelCharacterResponse.builder()
                .id(character.getId())
                .novelId(character.getNovelId())
                .commonName(character.getCommonName())
                .isMainCharacter(character.getIsMainCharacter())
                .alternativeNames(character.getAlternativeNames())
                .description(character.getDescription())
                .portraitPrompt(character.getPortraitPrompt())
                .persona(character.getPersona())
                .personaEn(character.getPersonaEn())
                .personaKo(character.getPersonaKo())
                .speakingStyle(character.getSpeakingStyle())
                .speakingStyleEn(character.getSpeakingStyleEn())
                .speakingStyleKo(character.getSpeakingStyleKo())
                .vectordbCharacterId(character.getVectordbCharacterId())
                .charGraphId(character.getCharGraphId())
                .createdAt(character.getCreatedAt())
                .updatedAt(character.getUpdatedAt())
                .build();
    }
}

