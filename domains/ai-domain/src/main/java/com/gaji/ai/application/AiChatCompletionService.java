package com.gaji.ai.application;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.gaji.ai.api.dto.AiChatCompletionRequest;
import com.gaji.common.exception.BadRequestException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class AiChatCompletionService {

    private static final int DEFAULT_TOP_K = 6;
    private static final int DEFAULT_MAX_CONTEXT_PASSAGES = 4;
    private static final int EMBEDDING_DIMENSIONS = 768;

    private final ObjectMapper objectMapper;
    private final JdbcTemplate jdbcTemplate;
    private final WebClient.Builder webClientBuilder;

    @Value("${gaji.ai.provider.gemini.api-key:${GEMINI_API_KEY:}}")
    private String geminiApiKey;

    @Value("${gaji.ai.provider.gemini.api-keys:${GEMINI_API_KEYS:}}")
    private String geminiApiKeys;

    @Value("${gaji.ai.provider.gemini.base-url:https://generativelanguage.googleapis.com}")
    private String geminiBaseUrl;

    @Value("${gaji.ai.provider.gemini.embedding-model:gemini-embedding-001}")
    private String embeddingModel;

    @Value("${gaji.ai.rag.pgvector.enabled:true}")
    private boolean pgvectorEnabled;

    @Value("${gaji.ai.rag.pgvector.table-name:rag_passages}")
    private String ragPassageTableName;

    @Value("${gaji.ai.rag.elasticsearch.enabled:${RAG_ELASTICSEARCH_ENABLED:true}}")
    private boolean elasticsearchEnabled;

    @Value("${gaji.ai.rag.elasticsearch.url:${ELASTICSEARCH_URL:http://localhost:9200}}")
    private String elasticsearchUrl;

    @Value("${gaji.ai.rag.elasticsearch.index:${RAG_ELASTICSEARCH_INDEX:gaji_novel_passages_v1}}")
    private String elasticsearchIndex;

    @Value("${gaji.ai.rag.timeout-ms:5000}")
    private long ragTimeoutMs;

    @Value("${gaji.ai.provider.timeout-ms:30000}")
    private long providerTimeoutMs;

    public JsonNode complete(AiChatCompletionRequest request, List<String> authorizedNovelIds) {
        long startedAt = System.nanoTime();
        RagSearchResult ragResult = retrieveRagContext(request, authorizedNovelIds);
        ProviderResult providerResult = generateAnswer(request, ragResult);

        ObjectNode response = objectMapper.createObjectNode();
        response.put("answer", providerResult.answer());
        response.put("model", request.resolvedModel());
        response.put("provider", providerResult.provider());
        if (providerResult.tokenUsage() != null) {
            response.put("token_usage", providerResult.tokenUsage());
        }
        if (ragResult.enabled()) {
            ObjectNode rag = buildRagMetadata(ragResult, elapsedMs(startedAt));
            response.set("rag", rag);
        }
        return response;
    }

    public JsonNode lookupPassageSources(UUID novelId, List<String> passageIds) {
        if (novelId == null || passageIds == null || passageIds.isEmpty()) {
            ObjectNode empty = objectMapper.createObjectNode();
            empty.putArray("passages");
            return empty;
        }

        String inSql = String.join(",", passageIds.stream().map(_id -> "?").toList());
        List<Object> args = new ArrayList<>();
        args.add(novelId);
        args.addAll(passageIds);

        String sql = """
                SELECT passage_id, novel_id, passage_manifest_id, chapter, text, character_names,
                       ordinal, chunk_index, word_count, start_word, end_word
                FROM %s
                WHERE novel_id = ? AND passage_id IN (%s)
                """.formatted(safeTableName(), inSql);

        Map<String, PassageHit> byId = new LinkedHashMap<>();
        jdbcTemplate.query(sql, (rs) -> {
            PassageHit hit = new PassageHit(
                    rs.getString("passage_id"),
                    rs.getObject("novel_id", UUID.class),
                    rs.getString("passage_manifest_id"),
                    rs.getString("chapter"),
                    rs.getString("text"),
                    rs.getString("character_names"),
                    rs.getObject("ordinal", Integer.class),
                    rs.getObject("chunk_index", Integer.class),
                    rs.getObject("word_count", Integer.class),
                    rs.getObject("start_word", Integer.class),
                    rs.getObject("end_word", Integer.class),
                    null,
                    null,
                    null
            );
            byId.put(hit.passageId(), hit);
        }, args.toArray());

        ObjectNode response = objectMapper.createObjectNode();
        ArrayNode passages = response.putArray("passages");
        for (String passageId : passageIds) {
            PassageHit hit = byId.get(passageId);
            if (hit != null) {
                passages.add(toSourceJson(hit));
            }
        }
        return response;
    }

    private RagSearchResult retrieveRagContext(
            AiChatCompletionRequest request,
            List<String> authorizedNovelIds
    ) {
        AiChatCompletionRequest.RagOptions rag = request.rag();
        if (rag == null || !rag.isEnabled()) {
            return RagSearchResult.disabled();
        }
        UUID novelId = parseNovelId(rag.novelId());
        if (authorizedNovelIds != null && !authorizedNovelIds.isEmpty()
                && !authorizedNovelIds.contains(novelId.toString())) {
            throw new BadRequestException("RAG novel is not authorized for this request");
        }

        long startedAt = System.nanoTime();
        String query = firstNonBlank(rag.query(), request.prompt());
        int topK = bounded(rag.topK(), DEFAULT_TOP_K, 1, 12);
        int maxContext = bounded(rag.maxContextPassages(), DEFAULT_MAX_CONTEXT_PASSAGES, 1, 8);

        List<PassageHit> vectorHits = List.of();
        Double embeddingMs = null;
        Double vectorSearchMs = null;
        if (pgvectorEnabled) {
            long embeddingStartedAt = System.nanoTime();
            List<Double> embedding = embedQuery(query);
            embeddingMs = elapsedMs(embeddingStartedAt);
            if (!embedding.isEmpty()) {
                long vectorStartedAt = System.nanoTime();
                vectorHits = searchPgvector(novelId, embedding, topK);
                vectorSearchMs = elapsedMs(vectorStartedAt);
            }
        }

        long bm25StartedAt = System.nanoTime();
        List<PassageHit> bm25Hits = elasticsearchEnabled ? searchElasticsearch(novelId, query, topK) : List.of();
        Double bm25SearchMs = elasticsearchEnabled ? elapsedMs(bm25StartedAt) : null;

        long fusionStartedAt = System.nanoTime();
        List<PassageHit> fused = fuse(vectorHits, bm25Hits, topK);
        Double fusionMs = elapsedMs(fusionStartedAt);
        List<PassageHit> contextHits = fused.stream().limit(maxContext).toList();

        return new RagSearchResult(
                true,
                novelId,
                query,
                firstNonBlank(rag.mode(), "hybrid"),
                contextHits,
                fused,
                elapsedMs(startedAt),
                embeddingMs,
                vectorSearchMs,
                bm25SearchMs,
                fusionMs
        );
    }

    private ProviderResult generateAnswer(AiChatCompletionRequest request, RagSearchResult ragResult) {
        if (activeGeminiApiKey() == null) {
            return new ProviderResult(
                    fallbackAnswer(ragResult),
                    "spring-fallback",
                    estimateTokens(request.prompt()),
                    true
            );
        }

        ObjectNode body = objectMapper.createObjectNode();
        ObjectNode systemInstruction = body.putObject("systemInstruction");
        systemInstruction.putArray("parts").addObject().put("text", systemInstruction(ragResult));
        ArrayNode contents = body.putArray("contents");
        ObjectNode userContent = contents.addObject();
        userContent.put("role", "user");
        userContent.putArray("parts").addObject().put("text", promptWithRagContext(request.prompt(), ragResult));

        ObjectNode generationConfig = body.putObject("generationConfig");
        generationConfig.put("temperature", request.temperature() == null ? 0.7 : request.temperature());
        generationConfig.put("maxOutputTokens", request.maxOutputTokens() == null ? 1024 : request.maxOutputTokens());
        if (request.thinkingBudget() != null) {
            generationConfig.putObject("thinkingConfig").put("thinkingBudget", request.thinkingBudget());
        }

        try {
            JsonNode response = webClientBuilder.build()
                    .post()
                    .uri(geminiEndpoint(request.resolvedModel(), "generateContent"))
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(JsonNode.class)
                    .block(Duration.ofMillis(providerTimeoutMs));
            String answer = extractGeminiText(response);
            if (answer == null || answer.isBlank()) {
                return new ProviderResult(fallbackAnswer(ragResult), "spring-fallback", estimateTokens(request.prompt()), true);
            }
            Integer tokenUsage = response == null || !response.path("usageMetadata").has("totalTokenCount")
                    ? null
                    : response.path("usageMetadata").path("totalTokenCount").asInt();
            return new ProviderResult(answer, "gemini", tokenUsage, false);
        } catch (Exception exc) {
            log.warn("spring_ai_gemini_generation_failed", exc);
            return new ProviderResult(fallbackAnswer(ragResult), "spring-fallback", estimateTokens(request.prompt()), true);
        }
    }

    private List<Double> embedQuery(String query) {
        if (activeGeminiApiKey() == null || query == null || query.isBlank()) {
            return List.of();
        }

        ObjectNode body = objectMapper.createObjectNode();
        body.put("model", "models/" + normalizeModelName(embeddingModel));
        ObjectNode content = body.putObject("content");
        content.putArray("parts").addObject().put("text", query);
        body.put("taskType", "RETRIEVAL_QUERY");
        body.put("outputDimensionality", EMBEDDING_DIMENSIONS);

        try {
            JsonNode response = webClientBuilder.build()
                    .post()
                    .uri(geminiEndpoint(embeddingModel, "embedContent"))
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(JsonNode.class)
                    .block(Duration.ofMillis(ragTimeoutMs));
            JsonNode values = response == null ? null : response.path("embedding").path("values");
            if (values == null || !values.isArray()) {
                return List.of();
            }
            List<Double> embedding = new ArrayList<>();
            values.forEach(value -> embedding.add(value.asDouble()));
            return embedding;
        } catch (Exception exc) {
            log.warn("spring_ai_embedding_failed", exc);
            return List.of();
        }
    }

    private List<PassageHit> searchPgvector(UUID novelId, List<Double> embedding, int limit) {
        if (embedding.isEmpty()) {
            return List.of();
        }
        String vectorLiteral = toPgvectorLiteral(embedding);
        String sql = """
                SELECT passage_id, novel_id, passage_manifest_id, chapter, text, character_names,
                       ordinal, chunk_index, word_count, start_word, end_word,
                       embedding <=> CAST(? AS vector) AS distance
                FROM %s
                WHERE novel_id = ?
                ORDER BY embedding <=> CAST(? AS vector)
                LIMIT ?
                """.formatted(safeTableName());

        return jdbcTemplate.query(sql, (rs, rowNum) -> new PassageHit(
                rs.getString("passage_id"),
                rs.getObject("novel_id", UUID.class),
                rs.getString("passage_manifest_id"),
                rs.getString("chapter"),
                rs.getString("text"),
                rs.getString("character_names"),
                rs.getObject("ordinal", Integer.class),
                rs.getObject("chunk_index", Integer.class),
                rs.getObject("word_count", Integer.class),
                rs.getObject("start_word", Integer.class),
                rs.getObject("end_word", Integer.class),
                rowNum + 1,
                null,
                rs.getDouble("distance")
        ), vectorLiteral, novelId, vectorLiteral, limit);
    }

    private List<PassageHit> searchElasticsearch(UUID novelId, String query, int limit) {
        if (query == null || query.isBlank()) {
            return List.of();
        }
        ObjectNode body = objectMapper.createObjectNode();
        body.put("size", limit);
        ObjectNode bool = body.putObject("query").putObject("bool");
        ArrayNode must = bool.putArray("must");
        ObjectNode multiMatch = must.addObject().putObject("multi_match");
        multiMatch.put("query", query);
        multiMatch.putArray("fields").add("text^3").add("chapter").add("character_names");
        ArrayNode filter = bool.putArray("filter");
        ObjectNode term = filter.addObject().putObject("term");
        term.put("novel_id.keyword", novelId.toString());

        try {
            JsonNode response = webClientBuilder.build()
                    .post()
                    .uri(elasticsearchUrl + "/" + elasticsearchIndex + "/_search")
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(JsonNode.class)
                    .block(Duration.ofMillis(ragTimeoutMs));
            JsonNode hits = response == null ? null : response.path("hits").path("hits");
            if (hits == null || !hits.isArray()) {
                return List.of();
            }
            List<PassageHit> results = new ArrayList<>();
            int rank = 1;
            for (JsonNode hit : hits) {
                JsonNode source = hit.path("_source");
                String passageId = firstNonBlank(textOrNull(source.get("passage_id")), textOrNull(source.get("id")));
                if (passageId == null) {
                    continue;
                }
                results.add(new PassageHit(
                        passageId,
                        novelId,
                        textOrNull(source.get("passage_manifest_id")),
                        textOrNull(source.get("chapter")),
                        textOrNull(source.get("text")),
                        textOrNull(source.get("character_names")),
                        intOrNull(source.get("ordinal")),
                        intOrNull(source.get("chunk_index")),
                        intOrNull(source.get("word_count")),
                        intOrNull(source.get("start_word")),
                        intOrNull(source.get("end_word")),
                        null,
                        rank++,
                        null
                ));
            }
            return results;
        } catch (Exception exc) {
            log.warn("spring_ai_elasticsearch_rag_search_failed", exc);
            return List.of();
        }
    }

    private List<PassageHit> fuse(List<PassageHit> vectorHits, List<PassageHit> bm25Hits, int limit) {
        Map<String, FusedHit> byPassageId = new LinkedHashMap<>();
        for (PassageHit hit : vectorHits) {
            byPassageId.computeIfAbsent(hit.passageId(), _id -> new FusedHit(hit)).vectorRank = hit.vectorRank();
        }
        for (PassageHit hit : bm25Hits) {
            FusedHit fused = byPassageId.computeIfAbsent(hit.passageId(), _id -> new FusedHit(hit));
            fused.bm25Rank = hit.bm25Rank();
            if (fused.hit.text() == null || fused.hit.text().isBlank()) {
                fused.hit = hit;
            }
        }
        return byPassageId.values().stream()
                .peek(FusedHit::score)
                .sorted(Comparator.comparingDouble((FusedHit hit) -> hit.score).reversed())
                .limit(limit)
                .map(FusedHit::toPassageHit)
                .toList();
    }

    private ObjectNode buildRagMetadata(RagSearchResult result, double totalElapsedMs) {
        ObjectNode rag = objectMapper.createObjectNode();
        rag.put("enabled", true);
        rag.put("novel_id", result.novelId().toString());
        rag.put("mode", result.mode());
        rag.put("query", result.query());
        rag.put("grounding_status", result.contextPassages().isEmpty() ? "fallback_ungrounded" : "grounded");
        rag.put("fallback_used", result.contextPassages().isEmpty());
        if (result.contextPassages().isEmpty()) {
            rag.put("fallback_reason", "no_rag_passages_found");
        }
        rag.put("ranking_policy", "spring_pgvector_elasticsearch_rrf");
        rag.put("query_source", "user_message");
        rag.put("passage_count", result.contextPassages().size());
        ObjectNode timing = rag.putObject("timing_ms");
        timing.put("total_ms", totalElapsedMs);
        putNullable(timing, "embedding_ms", result.embeddingMs());
        putNullable(timing, "vector_search_ms", result.vectorSearchMs());
        putNullable(timing, "bm25_search_ms", result.bm25SearchMs());
        putNullable(timing, "fusion_ms", result.fusionMs());

        ArrayNode citations = rag.putArray("citations");
        int finalRank = 1;
        for (PassageHit hit : result.fusedPassages()) {
            ObjectNode citation = citations.addObject();
            citation.put("passage_id", hit.passageId());
            citation.put("final_rank", finalRank++);
            putNullable(citation, "vector_rank", hit.vectorRank());
            putNullable(citation, "bm25_rank", hit.bm25Rank());
            putNullable(citation, "manifest_id", hit.manifestId());
            putNullable(citation, "chapter", hit.chapter());
        }
        return rag;
    }

    private String promptWithRagContext(String prompt, RagSearchResult ragResult) {
        if (!ragResult.enabled() || ragResult.contextPassages().isEmpty()) {
            return prompt;
        }
        StringBuilder builder = new StringBuilder();
        builder.append("Use the following retrieved source passages when they are relevant. ")
                .append("Do not invent source details that are not supported.\n\n");
        int index = 1;
        for (PassageHit hit : ragResult.contextPassages()) {
            builder.append("[Source ").append(index++).append(" | ").append(hit.passageId()).append("]\n")
                    .append(truncate(hit.text(), 1200))
                    .append("\n\n");
        }
        builder.append("User prompt\n").append(prompt);
        return builder.toString();
    }

    private String systemInstruction(RagSearchResult ragResult) {
        if (ragResult.enabled()) {
            return "You are Gaji's in-app literary conversation AI. Stay in character when a character persona is supplied. "
                    + "Ground answers in the provided passages and clearly avoid unsupported claims.";
        }
        return "You are Gaji's in-app literary conversation AI. Stay in character when a character persona is supplied.";
    }

    private String fallbackAnswer(RagSearchResult ragResult) {
        if (ragResult.enabled() && !ragResult.contextPassages().isEmpty()) {
            PassageHit first = ragResult.contextPassages().get(0);
            return "I found relevant story context, but the AI provider is not available right now. "
                    + "The strongest retrieved passage begins: \"" + truncate(first.text(), 240) + "\"";
        }
        return "AI generation is currently unavailable, and no grounded passage context was found for this turn.";
    }

    private ObjectNode toSourceJson(PassageHit hit) {
        ObjectNode node = objectMapper.createObjectNode();
        node.put("passage_id", hit.passageId());
        node.put("novel_id", hit.novelId().toString());
        putNullable(node, "manifest_id", hit.manifestId());
        putNullable(node, "chapter", hit.chapter());
        putNullable(node, "text", hit.text());
        ObjectNode metadata = node.putObject("metadata");
        putNullable(metadata, "character_names", hit.characterNames());
        putNullable(metadata, "ordinal", hit.ordinal());
        putNullable(metadata, "chunk_index", hit.chunkIndex());
        putNullable(metadata, "word_count", hit.wordCount());
        putNullable(metadata, "start_word", hit.startWord());
        putNullable(metadata, "end_word", hit.endWord());
        return node;
    }

    private String extractGeminiText(JsonNode response) {
        JsonNode parts = response == null
                ? null
                : response.path("candidates").path(0).path("content").path("parts");
        if (parts == null || !parts.isArray()) {
            return null;
        }
        StringBuilder builder = new StringBuilder();
        for (JsonNode part : parts) {
            String text = textOrNull(part.get("text"));
            if (text != null) {
                builder.append(text);
            }
        }
        return builder.toString().trim();
    }

    private String geminiEndpoint(String model, String method) {
        String normalizedModel = normalizeModelName(model);
        return geminiBaseUrl + "/v1beta/models/" + normalizedModel + ":" + method
                + "?key=" + URLEncoder.encode(activeGeminiApiKey(), StandardCharsets.UTF_8);
    }

    private String activeGeminiApiKey() {
        if (geminiApiKey != null && !geminiApiKey.isBlank()) {
            return geminiApiKey.trim();
        }
        if (geminiApiKeys == null || geminiApiKeys.isBlank()) {
            return null;
        }
        for (String key : geminiApiKeys.split(",")) {
            if (!key.isBlank()) {
                return key.trim();
            }
        }
        return null;
    }

    private String normalizeModelName(String model) {
        String value = model == null || model.isBlank() ? "gemini-2.5-flash" : model.trim();
        return value.startsWith("models/") ? value.substring("models/".length()) : value;
    }

    private String safeTableName() {
        if (!ragPassageTableName.matches("[A-Za-z0-9_]+")) {
            throw new BadRequestException("Invalid RAG passage table configuration");
        }
        return ragPassageTableName;
    }

    private UUID parseNovelId(String rawNovelId) {
        if (rawNovelId == null || rawNovelId.isBlank()) {
            throw new BadRequestException("rag.novelId is required when rag.enabled=true");
        }
        try {
            return UUID.fromString(rawNovelId.trim());
        } catch (IllegalArgumentException ex) {
            throw new BadRequestException("rag.novelId must be a valid UUID");
        }
    }

    private String toPgvectorLiteral(List<Double> values) {
        StringBuilder builder = new StringBuilder("[");
        for (int i = 0; i < values.size(); i++) {
            if (i > 0) {
                builder.append(',');
            }
            builder.append(values.get(i));
        }
        return builder.append(']').toString();
    }

    private int bounded(Integer value, int fallback, int min, int max) {
        int resolved = value == null ? fallback : value;
        return Math.max(min, Math.min(max, resolved));
    }

    private double elapsedMs(long startedAt) {
        return (System.nanoTime() - startedAt) / 1_000_000.0;
    }

    private int estimateTokens(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        return Math.max(1, value.length() / 4);
    }

    private String truncate(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        String normalized = value.replaceAll("\\s+", " ").trim();
        if (normalized.length() <= maxLength) {
            return normalized;
        }
        return normalized.substring(0, maxLength) + "...";
    }

    private String firstNonBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) {
                return value.trim();
            }
        }
        return null;
    }

    private String textOrNull(JsonNode node) {
        if (node == null || node.isNull()) {
            return null;
        }
        String value = node.asText(null);
        return value == null || value.isBlank() ? null : value;
    }

    private Integer intOrNull(JsonNode node) {
        if (node == null || node.isNull() || !node.canConvertToInt()) {
            return null;
        }
        return node.asInt();
    }

    private void putNullable(ObjectNode node, String field, String value) {
        if (value != null) {
            node.put(field, value);
        }
    }

    private void putNullable(ObjectNode node, String field, Integer value) {
        if (value != null) {
            node.put(field, value);
        }
    }

    private void putNullable(ObjectNode node, String field, Double value) {
        if (value != null) {
            node.put(field, value);
        }
    }

    private record ProviderResult(String answer, String provider, Integer tokenUsage, boolean fallbackUsed) {
    }

    private record RagSearchResult(
            boolean enabled,
            UUID novelId,
            String query,
            String mode,
            List<PassageHit> contextPassages,
            List<PassageHit> fusedPassages,
            Double totalMs,
            Double embeddingMs,
            Double vectorSearchMs,
            Double bm25SearchMs,
            Double fusionMs
    ) {
        static RagSearchResult disabled() {
            return new RagSearchResult(false, null, null, null, List.of(), List.of(), null, null, null, null, null);
        }
    }

    private record PassageHit(
            String passageId,
            UUID novelId,
            String manifestId,
            String chapter,
            String text,
            String characterNames,
            Integer ordinal,
            Integer chunkIndex,
            Integer wordCount,
            Integer startWord,
            Integer endWord,
            Integer vectorRank,
            Integer bm25Rank,
            Double vectorDistance
    ) {
    }

    private static final class FusedHit {
        private PassageHit hit;
        private Integer vectorRank;
        private Integer bm25Rank;
        private double score;

        private FusedHit(PassageHit hit) {
            this.hit = hit;
            this.vectorRank = hit.vectorRank();
            this.bm25Rank = hit.bm25Rank();
        }

        private void score() {
            double value = 0.0;
            if (vectorRank != null) {
                value += 2.0 / (60.0 + vectorRank);
            }
            if (bm25Rank != null) {
                value += 1.0 / (60.0 + bm25Rank);
            }
            this.score = value;
        }

        private PassageHit toPassageHit() {
            return new PassageHit(
                    hit.passageId(),
                    hit.novelId(),
                    hit.manifestId(),
                    hit.chapter(),
                    hit.text(),
                    hit.characterNames(),
                    hit.ordinal(),
                    hit.chunkIndex(),
                    hit.wordCount(),
                    hit.startWord(),
                    hit.endWord(),
                    vectorRank,
                    bm25Rank,
                    hit.vectorDistance()
            );
        }
    }
}
