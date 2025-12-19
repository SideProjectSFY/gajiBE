package com.gaji.corebackend.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Service for tracking search analytics
 * Story 3.6: Scenario Search & Advanced Filtering
 *
 * In production, this should persist to a dedicated analytics database
 * For MVP, we use in-memory tracking with logging
 */
@Service
@Slf4j
public class SearchAnalyticsService {

    // In-memory analytics (replace with database in production)
    private final ConcurrentHashMap<String, AtomicLong> searchQueries = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, AtomicLong> zeroResultQueries = new ConcurrentHashMap<>();
    private final AtomicLong totalSearches = new AtomicLong(0);
    private final AtomicLong totalZeroResults = new AtomicLong(0);

    /**
     * Log a search query
     *
     * @param query Search query text
     * @param scenarioType Optional scenario type filter
     * @param creatorId Optional creator ID filter
     */
    public void logSearch(String query, String scenarioType, UUID creatorId) {
        totalSearches.incrementAndGet();

        String logKey = buildLogKey(query, scenarioType);
        searchQueries.computeIfAbsent(logKey, k -> new AtomicLong(0)).incrementAndGet();

        log.info("Search logged: query='{}', scenarioType={}, creatorId={}, timestamp={}",
                query, scenarioType, creatorId, LocalDateTime.now());

        // Log top searches periodically
        if (totalSearches.get() % 100 == 0) {
            logTopSearches();
        }
    }

    /**
     * Log a search query that returned zero results
     *
     * @param query Search query text
     */
    public void logZeroResults(String query) {
        totalZeroResults.incrementAndGet();

        zeroResultQueries.computeIfAbsent(query, k -> new AtomicLong(0)).incrementAndGet();

        log.warn("Zero-result search: query='{}', timestamp={}", query, LocalDateTime.now());

        // Alert on frequent zero-result queries
        long zeroCount = zeroResultQueries.get(query).get();
        if (zeroCount >= 10) {
            log.error("ALERT: Query '{}' has returned zero results {} times. Consider improving search index or adding content.",
                    query, zeroCount);
        }
    }

    /**
     * Get total search count
     */
    public long getTotalSearches() {
        return totalSearches.get();
    }

    /**
     * Get total zero-result count
     */
    public long getTotalZeroResults() {
        return totalZeroResults.get();
    }

    /**
     * Get zero-result percentage
     */
    public double getZeroResultPercentage() {
        long total = totalSearches.get();
        if (total == 0) return 0.0;
        return (totalZeroResults.get() * 100.0) / total;
    }

    /**
     * Build log key for tracking
     */
    private String buildLogKey(String query, String scenarioType) {
        String normalizedQuery = query != null ? query.trim().toLowerCase() : "";
        String typeFilter = scenarioType != null ? scenarioType : "ALL";
        return normalizedQuery + "|" + typeFilter;
    }

    /**
     * Log top 10 search queries
     */
    private void logTopSearches() {
        log.info("=== Top 10 Search Queries (Total: {}) ===", totalSearches.get());

        searchQueries.entrySet().stream()
                .sorted((e1, e2) -> Long.compare(e2.getValue().get(), e1.getValue().get()))
                .limit(10)
                .forEach(entry -> log.info("  {} : {} searches", entry.getKey(), entry.getValue().get()));

        log.info("Zero-result rate: {}/{} ({:.2f}%)",
                totalZeroResults.get(), totalSearches.get(), getZeroResultPercentage());
    }

    /**
     * Clear analytics (for testing)
     */
    public void clearAnalytics() {
        searchQueries.clear();
        zeroResultQueries.clear();
        totalSearches.set(0);
        totalZeroResults.set(0);
        log.info("Search analytics cleared");
    }
}
