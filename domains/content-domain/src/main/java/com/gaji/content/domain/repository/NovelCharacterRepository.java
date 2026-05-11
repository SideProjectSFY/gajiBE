package com.gaji.content.domain.repository;

import com.gaji.content.domain.model.NovelCharacter;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface NovelCharacterRepository {

    NovelCharacter save(NovelCharacter novelCharacter);

    Optional<NovelCharacter> findById(UUID id);

    void deleteById(UUID id);

    Optional<NovelCharacter> findByPgvectorCharacterId(String pgvectorCharacterId);

    List<NovelCharacter> findByNovelId(UUID novelId);

    List<NovelCharacter> findByNovelIdAndIsMainCharacterTrue(UUID novelId);

    // Legacy support via default method
    default List<NovelCharacter> findMainCharactersByNovelId(UUID novelId) {
        return findByNovelIdAndIsMainCharacterTrue(novelId);
    }
}

