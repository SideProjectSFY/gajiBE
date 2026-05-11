package com.gaji.content.application;

import com.gaji.shared.contract.dto.NovelCharacterResponse;
import com.gaji.content.domain.model.NovelCharacter;
import com.gaji.content.domain.repository.NovelCharacterRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class NovelCharacterService {

    private final NovelCharacterRepository characterRepository;

    /**
     * Get all characters by novel ID
     */
    @Transactional(readOnly = true)
    public List<NovelCharacterResponse> getCharactersByNovelId(UUID novelId) {
        log.debug("Fetching characters for novel: {}", novelId);
        List<NovelCharacter> characters = characterRepository.findByNovelId(novelId);
        return characters.stream()
                .map(NovelCharacterResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Get main characters by novel ID
     */
    @Transactional(readOnly = true)
    public List<NovelCharacterResponse> getMainCharactersByNovelId(UUID novelId) {
        log.debug("Fetching main characters for novel: {}", novelId);
        List<NovelCharacter> characters = characterRepository.findMainCharactersByNovelId(novelId);
        return characters.stream()
                .map(NovelCharacterResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Get character by ID
     */
    @Transactional(readOnly = true)
    public NovelCharacterResponse getCharacterById(UUID id) {
        return characterRepository.findById(id)
                .map(NovelCharacterResponse::from)
                .orElseThrow(() -> new IllegalArgumentException("Character not found: " + id));
    }

    /**
     * Get character by pgvector character ID
     */
    @Transactional(readOnly = true)
    public NovelCharacterResponse getCharacterByPgvectorId(String pgvectorCharacterId) {
        log.debug("Fetching character by pgvector ID: {}", pgvectorCharacterId);
        return characterRepository.findByPgvectorCharacterId(pgvectorCharacterId)
                .map(NovelCharacterResponse::from)
                .orElse(null); // Return null if not found (for optional data)
    }
}

