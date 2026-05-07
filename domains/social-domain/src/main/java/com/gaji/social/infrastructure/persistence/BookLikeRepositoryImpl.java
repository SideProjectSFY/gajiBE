package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.BookLike;
import com.gaji.social.domain.model.BookLikeId;
import com.gaji.social.domain.repository.BookLikeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class BookLikeRepositoryImpl implements BookLikeRepository {

    private final BookLikeJpaRepository jpaRepository;

    @Override
    public BookLike save(BookLike bookLike) {
        return jpaRepository.save(bookLike);
    }

    @Override
    public Optional<BookLike> findById(BookLikeId id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(BookLikeId id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public long countByBookId(UUID bookId) {
        return jpaRepository.countByBookId(bookId);
    }

    @Override
    public boolean existsByUserIdAndBookId(UUID userId, UUID bookId) {
        return jpaRepository.existsByUserIdAndBookId(userId, bookId);
    }

    @Override
    public Page<BookLike> findByUserId(UUID userId, Pageable pageable) {
        return jpaRepository.findByUserId(userId, pageable);
    }
}
