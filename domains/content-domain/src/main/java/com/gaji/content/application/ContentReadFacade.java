package com.gaji.content.application;

import com.gaji.shared.contract.dto.NovelCharacterResponse;
import com.gaji.shared.contract.dto.NovelResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ContentReadFacade {

    private final NovelService novelService;
    private final NovelCharacterService novelCharacterService;

    @Transactional(readOnly = true)
    public NovelResponse getNovel(UUID novelId) {
        return novelService.getNovel(novelId);
    }

    @Transactional(readOnly = true)
    public NovelCharacterResponse getCharacterByVectordbId(String vectordbId) {
        return novelCharacterService.getCharacterByVectordbId(vectordbId);
    }
}
