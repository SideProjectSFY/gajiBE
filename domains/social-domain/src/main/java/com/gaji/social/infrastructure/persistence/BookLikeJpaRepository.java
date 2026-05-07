package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.BookLike;
import com.gaji.social.domain.model.BookLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface BookLikeJpaRepository extends JpaRepository<BookLike, BookLikeId>, QuerydslPredicateExecutor<BookLike> {
    long countByBookId(UUID bookId);
    boolean existsByUserIdAndBookId(UUID userId, UUID bookId);
    Page<BookLike> findByUserId(UUID userId, Pageable pageable);
}
