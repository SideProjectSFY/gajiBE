package com.gaji.content.infrastructure.persistence;

import com.gaji.content.domain.model.NovelCharacter;
import com.gaji.content.domain.repository.NovelCharacterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class NovelCharacterRepositoryImpl implements NovelCharacterRepository {

    private final NovelCharacterJpaRepository jpaRepository;

    @Override
    public NovelCharacter save(NovelCharacter novelCharacter) {
        return jpaRepository.save(novelCharacter);
    }

    @Override
    public Optional<NovelCharacter> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Optional<NovelCharacter> findByPgvectorCharacterId(String pgvectorCharacterId) {
        return jpaRepository.findByPgvectorCharacterId(pgvectorCharacterId);
    }

    @Override
    public List<NovelCharacter> findByNovelId(UUID novelId) {
        return jpaRepository.findByNovelId(novelId);
    }

    @Override
    public List<NovelCharacter> findByNovelIdAndIsMainCharacterTrue(UUID novelId) {
        return jpaRepository.findByNovelIdAndIsMainCharacterTrue(novelId);
    }
}
