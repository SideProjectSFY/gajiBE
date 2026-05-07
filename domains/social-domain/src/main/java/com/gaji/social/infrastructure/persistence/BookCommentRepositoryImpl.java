package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.BookComment;
import com.gaji.social.domain.repository.BookCommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class BookCommentRepositoryImpl implements BookCommentRepository {

    private final BookCommentJpaRepository jpaRepository;

    @Override
    public BookComment save(BookComment bookComment) {
        return jpaRepository.save(bookComment);
    }

    @Override
    public Optional<BookComment> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void delete(BookComment bookComment) {
        jpaRepository.delete(bookComment);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public Page<BookComment> findByBookIdOrderByCreatedAtDesc(UUID bookId, Pageable pageable) {
        return jpaRepository.findByBookIdOrderByCreatedAtDesc(bookId, pageable);
    }
}
