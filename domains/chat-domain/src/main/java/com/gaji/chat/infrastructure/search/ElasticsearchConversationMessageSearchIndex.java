package com.gaji.chat.infrastructure.search;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndex;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndexHit;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientResponseException;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.ConcurrentLinkedQueue;

@Slf4j
@Component
@RequiredArgsConstructor
public class ElasticsearchConversationMessageSearchIndex implements ConversationMessageSearchIndex {

    private final WebClient.Builder webClientBuilder;
    private final ObjectProvider<TaskExecutor> taskExecutorProvider;
    private final ObjectMapper objectMapper;

    @Value("${gaji.search.elasticsearch.enabled:false}")
    private boolean enabled;

    @Value("${gaji.search.elasticsearch.url:http://localhost:9200}")
    private String elasticsearchUrl;

    @Value("${gaji.search.elasticsearch.conversation-message-index:gaji_conversation_messages_v1}")
    private String indexName;

    @Value("${gaji.search.elasticsearch.timeout-ms:1500}")
    private long timeoutMs;

    @Value("${gaji.search.elasticsearch.retry-queue-max-size:1000}")
    private int retryQueueMaxSize;

    private final AtomicBoolean indexReady = new AtomicBoolean(false);
    private final Queue<Runnable> failedOperations = new ConcurrentLinkedQueue<>();

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    @Override
    public void indexMessage(Conversation conversation, Message message) {
        if (!enabled || conversation == null || message == null || message.getId() == null) {
            return;
        }
        dispatchAfterCommit(() -> indexMessageNow(conversation, message));
    }

    @Override
    public void indexMessages(Conversation conversation, List<Message> messages) {
        if (!enabled || conversation == null || messages == null || messages.isEmpty()) {
            return;
        }
        List<Message> indexableMessages = messages.stream()
                .filter(message -> message != null && message.getId() != null)
                .toList();
        if (indexableMessages.isEmpty()) {
            return;
        }
        dispatchAfterCommit(() -> bulkIndexMessagesNow(conversation, indexableMessages));
    }

    @Override
    public void deleteMessage(UUID messageId) {
        if (!enabled || messageId == null) {
            return;
        }
        dispatchAfterCommit(() -> deleteMessageNow(messageId));
    }

    @Override
    public void deleteConversation(UUID conversationId) {
        if (!enabled || conversationId == null) {
            return;
        }
        dispatchAfterCommit(() -> deleteByTermNow("conversation_id", conversationId.toString()));
    }

    @Override
    public void updateConversationTitle(UUID conversationId, String title) {
        if (!enabled || conversationId == null || title == null) {
            return;
        }
        dispatchAfterCommit(() -> updateConversationTitleNow(conversationId, title));
    }

    @Override
    public void updateConversationVisibility(UUID conversationId, boolean isPrivate) {
        if (!enabled || conversationId == null) {
            return;
        }
        dispatchAfterCommit(() -> updateConversationVisibilityNow(conversationId, isPrivate));
    }

    @Override
    public int retryFailedOperations() {
        return retryFailedOperations(Integer.MAX_VALUE);
    }

    @Override
    public List<ConversationMessageSearchIndexHit> searchOwnedConversationMessageCards(
            UUID userId,
            String query,
            int limit
    ) {
        if (!enabled) {
            return List.of();
        }
        ensureIndex();
        JsonNode response = client()
                .post()
                .uri("/{index}/_search", indexName)
                .bodyValue(searchBody(userId, query, limit))
                .retrieve()
                .bodyToMono(JsonNode.class)
                .block(timeout());
        return mapSearchHits(response);
    }

    private void dispatchAfterCommit(Runnable task) {
        if (TransactionSynchronizationManager.isSynchronizationActive()) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() {
                    dispatch(task);
                }
            });
            return;
        }
        dispatch(task);
    }

    private void dispatch(Runnable task) {
        Runnable guardedTask = () -> {
            try {
                retryFailedOperations(10);
                task.run();
            } catch (Exception exc) {
                enqueueRetry(task);
                log.warn("conversation_message_search_index_failed", exc);
            }
        };
        TaskExecutor taskExecutor = taskExecutorProvider.getIfAvailable();
        if (taskExecutor == null) {
            guardedTask.run();
            return;
        }
        taskExecutor.execute(guardedTask);
    }

    private void enqueueRetry(Runnable task) {
        if (failedOperations.size() >= retryQueueMaxSize) {
            log.warn("conversation_message_search_retry_queue_full size={}", failedOperations.size());
            return;
        }
        failedOperations.offer(task);
    }

    private int retryFailedOperations(int maxOperations) {
        int retried = 0;
        while (retried < maxOperations) {
            Runnable task = failedOperations.poll();
            if (task == null) {
                return retried;
            }
            try {
                task.run();
                retried++;
            } catch (Exception exc) {
                enqueueRetry(task);
                log.warn("conversation_message_search_retry_failed", exc);
                return retried;
            }
        }
        return retried;
    }

    private void indexMessageNow(Conversation conversation, Message message) {
        ensureIndex();
        client()
                .put()
                .uri("/{index}/_doc/{id}", indexName, message.getId().toString())
                .bodyValue(indexDocument(conversation, message))
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void bulkIndexMessagesNow(Conversation conversation, List<Message> messages) {
        ensureIndex();
        StringBuilder body = new StringBuilder();
        for (Message message : messages) {
            appendBulkLine(body, Map.of("index", Map.of("_index", indexName, "_id", message.getId().toString())));
            appendBulkLine(body, indexDocument(conversation, message));
        }
        client()
                .post()
                .uri("/_bulk")
                .contentType(MediaType.parseMediaType("application/x-ndjson"))
                .bodyValue(body.toString())
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void deleteMessageNow(UUID messageId) {
        ensureIndex();
        client()
                .delete()
                .uri("/{index}/_doc/{id}", indexName, messageId.toString())
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void deleteByTermNow(String field, String value) {
        ensureIndex();
        client()
                .post()
                .uri("/{index}/_delete_by_query?conflicts=proceed&refresh=true", indexName)
                .bodyValue(Map.of("query", Map.of("term", Map.of(field, value))))
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void updateConversationTitleNow(UUID conversationId, String title) {
        ensureIndex();
        Map<String, Object> script = new HashMap<>();
        script.put("source", "ctx._source.title = params.title");
        script.put("lang", "painless");
        script.put("params", Map.of("title", title));
        client()
                .post()
                .uri("/{index}/_update_by_query?conflicts=proceed&refresh=true", indexName)
                .bodyValue(Map.of(
                        "script", script,
                        "query", Map.of("term", Map.of("conversation_id", conversationId.toString()))
                ))
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void updateConversationVisibilityNow(UUID conversationId, boolean isPrivate) {
        ensureIndex();
        Map<String, Object> script = new HashMap<>();
        script.put("source", "ctx._source.is_private = params.is_private");
        script.put("lang", "painless");
        script.put("params", Map.of("is_private", isPrivate));
        client()
                .post()
                .uri("/{index}/_update_by_query?conflicts=proceed&refresh=true", indexName)
                .bodyValue(Map.of(
                        "script", script,
                        "query", Map.of("term", Map.of("conversation_id", conversationId.toString()))
                ))
                .retrieve()
                .toBodilessEntity()
                .block(timeout());
    }

    private void ensureIndex() {
        if (indexReady.get()) {
            return;
        }
        if (!indexExists()) {
            try {
                client()
                        .put()
                        .uri("/{index}", indexName)
                        .bodyValue(indexBody())
                        .retrieve()
                        .toBodilessEntity()
                        .block(timeout());
            } catch (WebClientResponseException.BadRequest exc) {
                if (!exc.getResponseBodyAsString().contains("resource_already_exists_exception")) {
                    throw exc;
                }
            }
        }
        indexReady.set(true);
    }

    private boolean indexExists() {
        try {
            client()
                    .method(HttpMethod.HEAD)
                    .uri("/{index}", indexName)
                    .retrieve()
                    .toBodilessEntity()
                    .block(timeout());
            return true;
        } catch (WebClientResponseException.NotFound exc) {
            return false;
        }
    }

    private WebClient client() {
        return webClientBuilder.baseUrl(elasticsearchUrl).build();
    }

    private Duration timeout() {
        return Duration.ofMillis(Math.max(100, timeoutMs));
    }

    private Map<String, Object> indexDocument(Conversation conversation, Message message) {
        Map<String, Object> document = new LinkedHashMap<>();
        document.put("message_id", message.getId().toString());
        document.put("conversation_id", conversation.getId().toString());
        document.put("user_id", conversation.getUserId().toString());
        document.put("title", conversation.getTitle());
        document.put("is_private", Boolean.TRUE.equals(conversation.getIsPrivate()));
        document.put("role", message.getRole());
        document.put("content", message.getContent());
        document.put("created_at", message.getCreatedAt() == null ? LocalDateTime.now().toString() : message.getCreatedAt().toString());
        return document;
    }

    private void appendBulkLine(StringBuilder body, Map<String, Object> line) {
        try {
            body.append(objectMapper.writeValueAsString(line)).append('\n');
        } catch (Exception exc) {
            throw new IllegalStateException("Failed to serialize Elasticsearch bulk line", exc);
        }
    }

    private Map<String, Object> indexBody() {
        return Map.of(
                "settings", Map.of(
                        "analysis", Map.of(
                                "analyzer", Map.of(
                                        "gaji_conversation_text", Map.of(
                                                "type", "standard",
                                                "stopwords", "_english_"
                                        )
                                )
                        )
                ),
                "mappings", Map.of(
                        "properties", Map.of(
                                "message_id", Map.of("type", "keyword"),
                                "conversation_id", Map.of("type", "keyword"),
                                "user_id", Map.of("type", "keyword"),
                                "title", Map.of("type", "text", "analyzer", "gaji_conversation_text"),
                                "is_private", Map.of("type", "boolean"),
                                "role", Map.of("type", "keyword"),
                                "content", Map.of("type", "text", "analyzer", "gaji_conversation_text"),
                                "created_at", Map.of("type", "date")
                        )
                )
        );
    }

    private Map<String, Object> searchBody(UUID userId, String query, int limit) {
        return Map.of(
                "size", Math.max(1, Math.min(limit, 20)),
                "query", Map.of(
                        "bool", Map.of(
                                "filter", List.of(Map.of("term", Map.of("user_id", userId.toString()))),
                                "should", List.of(
                                        Map.of("multi_match", Map.of(
                                                "query", query,
                                                "fields", List.of("title^2", "content"),
                                                "operator", "and"
                                        )),
                                        Map.of("match_phrase", Map.of("content", Map.of(
                                                "query", query,
                                                "boost", 2.0
                                        )))
                                ),
                                "minimum_should_match", 1
                        )
                ),
                "collapse", Map.of(
                        "field", "conversation_id",
                        "inner_hits", Map.of(
                                "name", "matching_messages",
                                "size", 1,
                                "sort", List.of(Map.of("created_at", Map.of("order", "desc"))),
                                "_source", List.of("content", "created_at")
                        )
                ),
                "sort", List.of(Map.of("created_at", Map.of("order", "desc"))),
                "highlight", Map.of(
                        "pre_tags", List.of(""),
                        "post_tags", List.of(""),
                        "fields", Map.of(
                                "content", Map.of("fragment_size", 180, "number_of_fragments", 1),
                                "title", Map.of("fragment_size", 120, "number_of_fragments", 1)
                        )
                ),
                "_source", List.of("conversation_id", "title", "content", "created_at")
        );
    }

    private List<ConversationMessageSearchIndexHit> mapSearchHits(JsonNode response) {
        JsonNode hits = response == null ? null : response.path("hits").path("hits");
        if (hits == null || !hits.isArray()) {
            return List.of();
        }
        List<ConversationMessageSearchIndexHit> results = new ArrayList<>();
        for (JsonNode hit : hits) {
            JsonNode source = hit.path("_source");
            UUID conversationId = UUID.fromString(source.path("conversation_id").asText());
            JsonNode matchingMessages = hit.path("inner_hits").path("matching_messages").path("hits");
            JsonNode latestMatch = firstHit(matchingMessages.path("hits"));
            long hitCount = totalHits(matchingMessages.path("total"));
            LocalDateTime lastHitAt = parseDateTime(textFrom(latestMatch.path("_source").path("created_at"), source.path("created_at").asText(null)));
            String matchedContent = firstHighlight(hit.path("highlight"), "content");
            if (matchedContent == null && latestMatch != null) {
                matchedContent = textFrom(latestMatch.path("_source").path("content"), null);
            }
            if (matchedContent == null) {
                matchedContent = source.path("content").asText("");
            }
            results.add(new ConversationMessageSearchIndexHit(
                    conversationId,
                    source.path("title").asText(""),
                    hitCount,
                    lastHitAt,
                    matchedContent
            ));
        }
        return results;
    }

    private JsonNode firstHit(JsonNode hits) {
        return hits != null && hits.isArray() && !hits.isEmpty() ? hits.get(0) : null;
    }

    private long totalHits(JsonNode total) {
        if (total == null || total.isMissingNode()) {
            return 1;
        }
        if (total.isNumber()) {
            return total.asLong(1);
        }
        return Math.max(1, total.path("value").asLong(1));
    }

    private String firstHighlight(JsonNode highlight, String field) {
        JsonNode values = highlight == null ? null : highlight.path(field);
        if (values != null && values.isArray() && !values.isEmpty()) {
            return values.get(0).asText();
        }
        return null;
    }

    private String textFrom(JsonNode node, String fallback) {
        return node == null || node.isMissingNode() || node.isNull() ? fallback : node.asText(fallback);
    }

    private LocalDateTime parseDateTime(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return LocalDateTime.parse(value);
        } catch (Exception ignored) {
            return OffsetDateTime.parse(value).toLocalDateTime();
        }
    }
}
