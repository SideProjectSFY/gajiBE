package com.gaji.content.domain.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "character_aliases")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CharacterAlias {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "character_id", nullable = false)
    private NovelCharacter character;

    @Column(name = "alias", nullable = false, length = 255)
    private String alias;

    @Column(name = "usage_context", columnDefinition = "TEXT")
    private String usageContext;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}
