package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.BookComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface BookCommentJpaRepository extends JpaRepository<BookComment, UUID>, QuerydslPredicateExecutor<BookComment> {
    Page<BookComment> findByBookIdOrderByCreatedAtDesc(UUID bookId, Pageable pageable);
}
