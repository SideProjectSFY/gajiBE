package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.MessageSearchResult;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface MessageJpaRepository extends JpaRepository<Message, UUID>, QuerydslPredicateExecutor<Message> {

    @Query("SELECT m FROM Message m WHERE m.conversationId = :conversationId ORDER BY m.createdAt ASC")
    List<Message> findByConversationId(@Param("conversationId") UUID conversationId);

    @Query("SELECT m FROM Message m WHERE m.conversationId = :conversationId ORDER BY m.createdAt DESC")
    List<Message> findRecentByConversationId(@Param("conversationId") UUID conversationId, Pageable pageable);

    @Query("""
            SELECT new com.gaji.chat.domain.repository.MessageSearchResult(
                m.id,
                m.conversationId,
                c.title,
                m.role,
                m.content,
                m.createdAt
            )
            FROM Message m, Conversation c
            WHERE c.id = m.conversationId
              AND c.userId = :userId
              AND LOWER(m.content) LIKE LOWER(CONCAT('%', :query, '%'))
            ORDER BY m.createdAt DESC
            """)
    List<MessageSearchResult> searchOwnedMessages(
            @Param("userId") UUID userId,
            @Param("query") String query,
            Pageable pageable
    );

    @Query("""
            SELECT new com.gaji.chat.domain.repository.MessageSearchResult(
                m.id,
                m.conversationId,
                c.title,
                m.role,
                m.content,
                m.createdAt
            )
            FROM Message m, Conversation c
            WHERE c.id = m.conversationId
              AND c.userId = :userId
              AND m.conversationId = :conversationId
              AND LOWER(m.content) LIKE LOWER(CONCAT('%', :query, '%'))
            ORDER BY m.createdAt DESC
            """)
    List<MessageSearchResult> searchOwnedMessagesInConversation(
            @Param("userId") UUID userId,
            @Param("conversationId") UUID conversationId,
            @Param("query") String query,
            Pageable pageable
    );
}
