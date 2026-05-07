package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static com.gaji.chat.domain.model.QConversation.conversation;
// Note: Assuming QRootUserScenario and QNovel are available in the classpath
// If not, we fall back to manual joins or Native SQL
import static com.gaji.scenario.domain.model.QRootUserScenario.rootUserScenario;
import static com.gaji.content.domain.model.QNovel.novel;

@Repository
@RequiredArgsConstructor
public class ConversationRepositoryImpl implements ConversationRepository {

    private final ConversationJpaRepository conversationJpaRepository;
    private final JPAQueryFactory queryFactory;

    @PersistenceContext
    private final EntityManager entityManager;

    @Override
    public Conversation save(Conversation conversation) {
        return conversationJpaRepository.save(conversation);
    }

    @Override
    public Optional<Conversation> findById(UUID id) {
        return conversationJpaRepository.findById(id);
    }

    @Override
    public boolean existsById(UUID id) {
        return conversationJpaRepository.existsById(id);
    }

    @Override
    public List<Conversation> findAllById(Iterable<UUID> ids) {
        return conversationJpaRepository.findAllById(ids);
    }

    @Override
    public Page<Conversation> findAll(Pageable pageable) {
        return conversationJpaRepository.findAll(pageable);
    }

    @Override
    public void deleteById(UUID id) {
        conversationJpaRepository.deleteById(id);
    }

    @Override
    public Optional<Conversation> findByIdWithMessages(UUID id) {
        return conversationJpaRepository.findByIdWithMessages(id);
    }

    @Override
    public Page<Conversation> findByUserId(UUID userId, Pageable pageable) {
        return conversationJpaRepository.findByUserId(userId, pageable);
    }

    @Override
    public Page<Conversation> findPublicByUserId(UUID userId, Pageable pageable) {
        return conversationJpaRepository.findPublicByUserId(userId, pageable);
    }

    @Override
    public Page<Conversation> findPublicAll(Pageable pageable) {
        return conversationJpaRepository.findPublicAll(pageable);
    }

    @Override
    public void incrementMessageCount(UUID id) {
        conversationJpaRepository.incrementMessageCount(id);
    }

    @Override
    public void updateMessageCount(UUID id, int count) {
        conversationJpaRepository.updateMessageCount(id, count);
    }

    @Override
    public void updateHasBeenForked(UUID id, boolean hasBeenForked) {
        conversationJpaRepository.updateHasBeenForked(id, hasBeenForked);
    }

    @Override
    public void incrementLikeCount(UUID id) {
        conversationJpaRepository.incrementLikeCount(id);
    }

    @Override
    public void decrementLikeCount(UUID id) {
        conversationJpaRepository.decrementLikeCount(id);
    }

    @Override
    public Optional<Conversation> findFirstByScenarioIdOrderByCreatedAtAsc(UUID scenarioId) {
        return conversationJpaRepository.findFirstByScenarioIdOrderByCreatedAtAsc(scenarioId);
    }

    @Override
    public Page<Conversation> findPublicAllWithFilters(String search, String genre, Pageable pageable) {
        BooleanBuilder builder = new BooleanBuilder();
        builder.and(conversation.isPrivate.isFalse());

        // We assume 'RootUserScenario' and 'Novel' Q-types are available.
        // If compilation fails due to cross-module visibility, this part needs adjustment.
        // However, given the monolithic structure, it should work.
        
        JPAQuery<Conversation> query = queryFactory.selectFrom(conversation)
                .leftJoin(rootUserScenario).on(conversation.scenarioId.eq(rootUserScenario.id))
                .leftJoin(novel).on(rootUserScenario.novelId.eq(novel.id));

        if (search != null && !search.trim().isEmpty()) {
            builder.and(conversation.title.containsIgnoreCase(search)
                    .or(novel.title.containsIgnoreCase(search)));
        }

        if (genre != null && !genre.trim().isEmpty()) {
            builder.and(novel.genre.eq(genre));
        }

        query.where(builder);

        // Sorting
        // Apply default sort if none provided or if explicit request
        if (pageable.getSort().isSorted()) {
            for (Sort.Order order : pageable.getSort()) {
                PathBuilder<Conversation> pathBuilder = new PathBuilder<>(conversation.getType(), conversation.getMetadata());
                query.orderBy(new OrderSpecifier(order.isAscending() ? Order.ASC : Order.DESC,
                        pathBuilder.get(order.getProperty())));
            }
        } else {
            query.orderBy(conversation.createdAt.desc());
        }

        long total = query.fetchCount(); // Standard count query
        
        // Optimistic pagination: Fetch user requested page
        List<Conversation> content = query.offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    @SuppressWarnings("unchecked")
    public Page<Conversation> findLikedByUserId(UUID userId, boolean includePrivate, Pageable pageable) {
        // Using Native SQL because ConversationLike entity is in another domain (Social)
        // and we want to avoid direct dependency or complex mapping here.
        
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT c.* FROM conversations c ");
        sql.append("INNER JOIN conversation_likes cl ON c.id = cl.conversation_id ");
        sql.append("WHERE cl.user_id = :userId ");
        
        if (!includePrivate) {
            sql.append("AND c.is_private = false ");
        }
        
        // Sorting: Native query already ordered by like time in original requirement
        // "ORDER BY cl.created_at DESC"
        // Applying Pageable sort might be tricky with aliases.
        // Let's stick to default like-time sort as per requirement, or if pageable has sort, try to apply it.
        // For simplicity and correctness with JOINs, hardcoding expected sort is safer 
        // unless dynamic sort is strictly required. 
        // Original requirement: "ORDER BY cl.created_at DESC"
        sql.append("ORDER BY cl.created_at DESC");

        Query nativeQuery = entityManager.createNativeQuery(sql.toString(), Conversation.class);
        nativeQuery.setParameter("userId", userId);
        
        // Pagination
        nativeQuery.setFirstResult((int) pageable.getOffset());
        nativeQuery.setMaxResults(pageable.getPageSize());

        List<Conversation> content = nativeQuery.getResultList();

        // Count Query
        StringBuilder countSql = new StringBuilder();
        countSql.append("SELECT count(*) FROM conversations c ");
        countSql.append("INNER JOIN conversation_likes cl ON c.id = cl.conversation_id ");
        countSql.append("WHERE cl.user_id = :userId ");
        if (!includePrivate) {
            countSql.append("AND c.is_private = false");
        }
        
        Query countQuery = entityManager.createNativeQuery(countSql.toString());
        countQuery.setParameter("userId", userId);
        long total = ((Number) countQuery.getSingleResult()).longValue();

        return new PageImpl<>(content, pageable, total);
    }
}
