package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.ConversationMessageSearchResult;
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.chat.domain.repository.MessageSearchResult;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class MessageRepositoryImpl implements MessageRepository {

    private final MessageJpaRepository jpaRepository;

    @PersistenceContext
    private EntityManager entityManager;

    private static final String OWNED_CONVERSATION_MESSAGE_CARD_SEARCH_SQL = """
            WITH body_hits AS MATERIALIZED (
                SELECT m.conversation_id, m.content, m.created_at
                FROM messages m
                WHERE lower(m.content) LIKE concat('%', lower(CAST(:query AS text)), '%')
            ),
            message_hits AS (
                SELECT h.conversation_id,
                       count(*) AS message_hit_count,
                       max(h.created_at) AS last_hit_at,
                       (array_agg(h.content ORDER BY h.created_at DESC))[1] AS matched_content
                FROM body_hits h
                JOIN conversations c ON c.id = h.conversation_id
                WHERE c.user_id = CAST(:userId AS uuid)
                GROUP BY h.conversation_id
            ),
            title_hits AS (
                SELECT c.id AS conversation_id,
                       CAST(0 AS bigint) AS message_hit_count,
                       c.updated_at AS last_hit_at,
                       CAST(NULL AS text) AS matched_content
                FROM conversations c
                WHERE c.user_id = CAST(:userId AS uuid)
                  AND lower(c.title) LIKE concat('%', lower(CAST(:query AS text)), '%')
            ),
            candidate_conversations AS (
                SELECT conversation_id,
                       CAST(sum(message_hit_count) AS bigint) AS message_hit_count,
                       max(last_hit_at) AS last_hit_at,
                       max(matched_content) AS matched_content
                FROM (
                    SELECT * FROM message_hits
                    UNION ALL
                    SELECT * FROM title_hits
                ) candidates
                GROUP BY conversation_id
                ORDER BY max(last_hit_at) DESC
                LIMIT :limit
            )
            SELECT c.id AS conversation_id,
                   c.title AS conversation_title,
                   cc.message_hit_count,
                   cc.last_hit_at,
                   cc.matched_content,
                   recent_message.id AS recent_message_id,
                   recent_message.role AS recent_message_role,
                   left(recent_message.content, 80) AS recent_message_snippet,
                   recent_message.created_at AS recent_message_created_at
            FROM candidate_conversations cc
            JOIN conversations c ON c.id = cc.conversation_id
            LEFT JOIN LATERAL (
                SELECT rm.id, rm.role, rm.content, rm.created_at
                FROM messages rm
                WHERE rm.conversation_id = cc.conversation_id
                ORDER BY rm.created_at DESC
                LIMIT 3
            ) recent_message ON true
            ORDER BY cc.last_hit_at DESC, recent_message.created_at DESC
            """;

    @Override
    public Message save(Message message) {
        return jpaRepository.save(message);
    }

    @Override
    public List<Message> saveAll(Iterable<Message> messages) {
        return jpaRepository.saveAll(messages);
    }

    @Override
    public Optional<Message> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public List<Message> findByConversationId(UUID conversationId) {
        return jpaRepository.findByConversationId(conversationId);
    }

    @Override
    public List<Message> findRecentByConversationId(UUID conversationId, Pageable pageable) {
        return jpaRepository.findRecentByConversationId(conversationId, pageable);
    }

    @Override
    public List<MessageSearchResult> searchOwnedMessages(UUID userId, String query, Pageable pageable) {
        return jpaRepository.searchOwnedMessages(userId, query, pageable);
    }

    @Override
    public List<MessageSearchResult> searchOwnedMessagesInConversation(
            UUID userId,
            UUID conversationId,
            String query,
            Pageable pageable
    ) {
        return jpaRepository.searchOwnedMessagesInConversation(userId, conversationId, query, pageable);
    }

    @Override
    public List<ConversationMessageSearchResult> searchOwnedConversationMessageCards(
            UUID userId,
            String query,
            int limit
    ) {
        @SuppressWarnings("unchecked")
        List<Object[]> rows = entityManager
                .createNativeQuery(OWNED_CONVERSATION_MESSAGE_CARD_SEARCH_SQL)
                .setParameter("userId", userId)
                .setParameter("query", query)
                .setParameter("limit", limit)
                .getResultList();

        Map<UUID, ConversationMessageSearchAccumulator> grouped = new LinkedHashMap<>();
        for (Object[] row : rows) {
            UUID conversationId = toUuid(row[0]);
            ConversationMessageSearchAccumulator accumulator = grouped.computeIfAbsent(
                    conversationId,
                    ignored -> new ConversationMessageSearchAccumulator(
                            conversationId,
                            (String) row[1],
                            toLong(row[2]),
                            toLocalDateTime(row[3]),
                            (String) row[4]
                    )
            );

            if (row[5] != null) {
                accumulator.recentMessages().add(new ConversationMessageSearchResult.RecentMessage(
                        toUuid(row[5]),
                        (String) row[6],
                        (String) row[7],
                        toLocalDateTime(row[8])
                ));
            }
        }

        return grouped.values().stream()
                .map(ConversationMessageSearchAccumulator::toResult)
                .toList();
    }

    private UUID toUuid(Object value) {
        if (value instanceof UUID uuid) {
            return uuid;
        }
        return UUID.fromString(value.toString());
    }

    private long toLong(Object value) {
        if (value instanceof Number number) {
            return number.longValue();
        }
        return Long.parseLong(value.toString());
    }

    private LocalDateTime toLocalDateTime(Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof LocalDateTime localDateTime) {
            return localDateTime;
        }
        if (value instanceof Timestamp timestamp) {
            return timestamp.toLocalDateTime();
        }
        return LocalDateTime.parse(value.toString().replace(" ", "T"));
    }

    private record ConversationMessageSearchAccumulator(
            UUID conversationId,
            String conversationTitle,
            long messageHitCount,
            LocalDateTime lastHitAt,
            String matchedContent,
            List<ConversationMessageSearchResult.RecentMessage> recentMessages
    ) {
        private ConversationMessageSearchAccumulator(
                UUID conversationId,
                String conversationTitle,
                long messageHitCount,
                LocalDateTime lastHitAt,
                String matchedContent
        ) {
            this(
                    conversationId,
                    conversationTitle,
                    messageHitCount,
                    lastHitAt,
                    matchedContent,
                    new ArrayList<>()
            );
        }

        private ConversationMessageSearchResult toResult() {
            return new ConversationMessageSearchResult(
                    conversationId,
                    conversationTitle,
                    messageHitCount,
                    lastHitAt,
                    matchedContent,
                    List.copyOf(recentMessages)
            );
        }
    }
}
