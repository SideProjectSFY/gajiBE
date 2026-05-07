package com.gaji.search.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SearchAnalyticsFacade {

    private final SearchAnalyticsService searchAnalyticsService;

    public void logSearch(String query, String scenarioType, UUID creatorId) {
        searchAnalyticsService.logSearch(query, scenarioType, creatorId);
    }

    public void logZeroResults(String query) {
        searchAnalyticsService.logZeroResults(query);
    }
}
