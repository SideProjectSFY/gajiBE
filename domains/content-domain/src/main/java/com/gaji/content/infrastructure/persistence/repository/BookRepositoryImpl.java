package com.gaji.content.infrastructure.persistence.repository;

import com.gaji.content.domain.model.Book;
import com.gaji.content.domain.model.Novel;
import com.gaji.content.domain.repository.BookRepository;
import com.gaji.content.domain.repository.NovelRepository;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.gaji.content.domain.model.QNovel.novel;

@Repository
@RequiredArgsConstructor
public class BookRepositoryImpl implements BookRepository {

    private final NovelRepository novelRepository;
    private final JPAQueryFactory queryFactory;

    @Override
    public List<Book> findBooks(int offset, int limit, String genre, String sort, String search) {
        
        BooleanExpression predicate = search == null ? null : 
            novel.title.containsIgnoreCase(search).or(novel.author.containsIgnoreCase(search));
        
        if (genre != null && !genre.isEmpty()) {
            predicate = predicate == null ? novel.genre.eq(genre) : predicate.and(novel.genre.eq(genre));
        }

        List<Novel> novels = queryFactory.selectFrom(novel)
                .where(predicate)
                .offset(offset)
                .limit(limit)
                .orderBy(novel.createdAt.desc()) // TODO: implement proper sorting logic based on 'sort'
                .fetch();

        return novels.stream()
                .map(this::mapNovelToBook)
                .collect(Collectors.toList());
    }

    @Override
    public int countBooks(String genre) {
        BooleanExpression predicate = null;
        if (genre != null && !genre.isEmpty()) {
            predicate = novel.genre.eq(genre);
        }
        
        return (int) queryFactory.selectFrom(novel)
                .where(predicate)
                .fetchCount();
    }

    @Override
    public Book findBookById(UUID id) {
        return novelRepository.findById(id)
                .map(this::mapNovelToBook)
                .orElse(null);
    }

    private Book mapNovelToBook(Novel novel) {
        // Since we cannot access social/chat/scenario domains directly, counts are set to 0.
        // In a real application, these would be aggregated via a dedicated service or denormalized.
        return new Book(
                novel.getId(),
                novel.getTitle(),
                novel.getAuthor(),
                novel.getGenre(),
                null, // coverImageUrl not in Novel entity? Let's check Novel.java
                LocalDateTime.now(), // Create/Update from entity auditing if available
                LocalDateTime.now(),
                0, // Scenario Count
                0, // Conversation Count
                0  // Like Count
        ); 
    }
}
