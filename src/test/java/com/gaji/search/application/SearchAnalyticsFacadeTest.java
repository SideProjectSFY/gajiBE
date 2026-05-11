package com.gaji.search.application;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.UUID;

import static org.mockito.Mockito.verify;

class SearchAnalyticsFacadeTest {

    private SearchAnalyticsService searchAnalyticsService;
    private SearchAnalyticsFacade searchAnalyticsFacade;

    @BeforeEach
    void setUp() {
        searchAnalyticsService = Mockito.mock(SearchAnalyticsService.class);
        searchAnalyticsFacade = new SearchAnalyticsFacade(searchAnalyticsService);
    }

    @Test
    void logSearch_delegatesToSearchAnalyticsService() {
        UUID creatorId = UUID.randomUUID();

        searchAnalyticsFacade.logSearch("query", "CHARACTER_CHANGE", creatorId);

        verify(searchAnalyticsService).logSearch("query", "CHARACTER_CHANGE", creatorId);
    }

    @Test
    void logZeroResults_delegatesToSearchAnalyticsService() {
        searchAnalyticsFacade.logZeroResults("zero-query");

        verify(searchAnalyticsService).logZeroResults("zero-query");
    }
}
