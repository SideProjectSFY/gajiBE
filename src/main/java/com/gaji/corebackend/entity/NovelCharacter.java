package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * NovelCharacter entity - Character information from novels
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NovelCharacter {

    private UUID id;
    private UUID novelId;
    
    // Character identification
    private String commonName;
    private Boolean isMainCharacter;
    private String[] alternativeNames;
    
    // Character description
    private String description;
    private String portraitPrompt;
    
    // AI persona and speaking style
    private String persona;
    private String personaEn;
    private String personaKo;
    private String speakingStyle;
    private String speakingStyleEn;
    private String speakingStyleKo;
    
    // VectorDB reference
    private String vectordbCharacterId;
    
    // Character graph metadata
    private Integer charGraphId;
    
    // Metadata
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

