package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.NovelCharacter;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface NovelCharacterMapper {
    Optional<NovelCharacter> findById(UUID id);
    List<NovelCharacter> findByNovelId(UUID novelId);
    List<NovelCharacter> findMainCharactersByNovelId(UUID novelId);
    int insert(NovelCharacter character);
    int update(NovelCharacter character);
    int deleteById(UUID id);
}

