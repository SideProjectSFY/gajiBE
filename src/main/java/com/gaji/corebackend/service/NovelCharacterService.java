package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.NovelCharacterResponse;
import com.gaji.corebackend.entity.NovelCharacter;
import com.gaji.corebackend.mapper.NovelCharacterMapper;
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

    private final NovelCharacterMapper characterMapper;

    /**
     * Get all characters by novel ID
     */
    @Transactional(readOnly = true)
    public List<NovelCharacterResponse> getCharactersByNovelId(UUID novelId) {
        log.debug("Fetching characters for novel: {}", novelId);
        List<NovelCharacter> characters = characterMapper.findByNovelId(novelId);
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
        List<NovelCharacter> characters = characterMapper.findMainCharactersByNovelId(novelId);
        return characters.stream()
                .map(NovelCharacterResponse::from)
                .collect(Collectors.toList());
    }

    /**
     * Get character by ID
     */
    @Transactional(readOnly = true)
    public NovelCharacterResponse getCharacterById(UUID id) {
        return characterMapper.findById(id)
                .map(NovelCharacterResponse::from)
                .orElseThrow(() -> new IllegalArgumentException("Character not found: " + id));
    }
}

