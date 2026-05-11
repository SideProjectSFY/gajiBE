package com.gaji.content.application;

import com.gaji.shared.contract.dto.NovelCharacterResponse;
import com.gaji.shared.contract.dto.NovelResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class ContentReadFacadeTest {

    private NovelService novelService;
    private NovelCharacterService novelCharacterService;
    private ContentReadFacade contentReadFacade;

    @BeforeEach
    void setUp() {
        novelService = Mockito.mock(NovelService.class);
        novelCharacterService = Mockito.mock(NovelCharacterService.class);
        contentReadFacade = new ContentReadFacade(novelService, novelCharacterService);
    }

    @Test
    void getNovel_delegatesToNovelService() {
        UUID novelId = UUID.randomUUID();
        NovelResponse expected = Mockito.mock(NovelResponse.class);
        when(novelService.getNovel(novelId)).thenReturn(expected);

        NovelResponse actual = contentReadFacade.getNovel(novelId);

        assertSame(expected, actual);
        verify(novelService).getNovel(novelId);
    }

    @Test
    void getCharacterByVectordbId_delegatesToNovelCharacterService() {
        NovelCharacterResponse expected = Mockito.mock(NovelCharacterResponse.class);
        when(novelCharacterService.getCharacterByVectordbId("char-001")).thenReturn(expected);

        NovelCharacterResponse actual = contentReadFacade.getCharacterByVectordbId("char-001");

        assertSame(expected, actual);
        verify(novelCharacterService).getCharacterByVectordbId("char-001");
    }
}
