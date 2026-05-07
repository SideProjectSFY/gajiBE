package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.Conversation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.UUID;

public interface ConversationJpaRepository extends JpaRepository<Conversation, UUID>, QuerydslPredicateExecutor<Conversation> {

    @Query("SELECT c FROM Conversation c LEFT JOIN FETCH c.messages WHERE c.id = :id")
    Optional<Conversation> findByIdWithMessages(@Param("id") UUID id);

    Page<Conversation> findByUserId(UUID userId, Pageable pageable);

    @Query("SELECT c FROM Conversation c WHERE c.userId = :userId AND c.isPrivate = false")
    Page<Conversation> findPublicByUserId(@Param("userId") UUID userId, Pageable pageable);

    @Query("SELECT c FROM Conversation c WHERE c.isPrivate = false")
    Page<Conversation> findPublicAll(Pageable pageable);

    @Modifying
    @Query("UPDATE Conversation c SET c.messageCount = c.messageCount + 1, c.updatedAt = CURRENT_TIMESTAMP WHERE c.id = :id")
    void incrementMessageCount(@Param("id") UUID id);

    @Modifying
    @Query("UPDATE Conversation c SET c.messageCount = :count, c.updatedAt = CURRENT_TIMESTAMP WHERE c.id = :id")
    void updateMessageCount(@Param("id") UUID id, @Param("count") int count);

    @Modifying
    @Query("UPDATE Conversation c SET c.hasBeenForked = :hasBeenForked, c.updatedAt = CURRENT_TIMESTAMP WHERE c.id = :id")
    void updateHasBeenForked(@Param("id") UUID id, @Param("hasBeenForked") boolean hasBeenForked);

    @Modifying
    @Query("UPDATE Conversation c SET c.likeCount = :count, c.updatedAt = CURRENT_TIMESTAMP WHERE c.id = :id")
    void updateLikeCount(@Param("id") UUID id, @Param("count") int count);

    @Modifying
    @Query("UPDATE Conversation c SET c.likeCount = c.likeCount + 1 WHERE c.id = :id")
    void incrementLikeCount(@Param("id") UUID id);

    @Modifying
    @Query("UPDATE Conversation c SET c.likeCount = c.likeCount - 1 WHERE c.id = :id AND c.likeCount > 0")
    void decrementLikeCount(@Param("id") UUID id);

    Optional<Conversation> findFirstByScenarioIdOrderByCreatedAtAsc(UUID scenarioId);
}
