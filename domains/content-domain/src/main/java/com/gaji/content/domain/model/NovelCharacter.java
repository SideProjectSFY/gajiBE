package com.gaji.content.domain.model;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * NovelCharacter entity - Character information from novels
 */
@Entity
@Table(name = "characters")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class NovelCharacter {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @Column(name = "novel_id", nullable = false)
    private UUID novelId;
    
    // Character identification
    @Column(name = "common_name", nullable = false, length = 255)
    private String commonName;

    @Column(name = "is_main_character")
    private Boolean isMainCharacter;

    // Use ElementCollection for aliases if supported, otherwise separate entity.
    // For now, mapping as simple strings to avoid complex migration within this step if possible.
    // But request was "Full Refactor".
    // I already decided on CharacterAlias entity.
    
    @OneToMany(mappedBy = "character", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<CharacterAlias> alternativeNames = new ArrayList<>();
    
    // Character description
    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "portrait_prompt", columnDefinition = "TEXT")
    private String portraitPrompt;
    
    // AI persona and speaking style
    @Column(name = "persona", columnDefinition = "TEXT")
    private String persona;
    
    @Column(name = "persona_en", columnDefinition = "TEXT")
    private String personaEn;
    
    @Column(name = "persona_ko", columnDefinition = "TEXT")
    private String personaKo;

    @Column(name = "speaking_style", columnDefinition = "TEXT")
    private String speakingStyle;

    @Column(name = "speaking_style_en", columnDefinition = "TEXT")
    private String speakingStyleEn;
    
    @Column(name = "speaking_style_ko", columnDefinition = "TEXT")
    private String speakingStyleKo;
    
    // pgvector reference
    @Column(name = "pgvector_character_id")
    private String pgvectorCharacterId;
    
    // Character graph metadata
    @Column(name = "char_graph_id")
    private Integer charGraphId;
    
    // Metadata
    @CreatedDate
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
