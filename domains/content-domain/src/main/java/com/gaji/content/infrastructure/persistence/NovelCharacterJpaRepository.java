package com.gaji.content.infrastructure.persistence;

import com.gaji.content.domain.model.NovelCharacter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface NovelCharacterJpaRepository extends JpaRepository<NovelCharacter, UUID>, QuerydslPredicateExecutor<NovelCharacter> {
    Optional<NovelCharacter> findByVectordbCharacterId(String vectordbCharacterId);
    List<NovelCharacter> findByNovelId(UUID novelId);
    List<NovelCharacter> findByNovelIdAndIsMainCharacterTrue(UUID novelId);
}
