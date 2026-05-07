package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.BookLike;
import com.gaji.social.domain.model.BookLikeId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface BookLikeRepository {
    
    BookLike save(BookLike bookLike);
    
    Optional<BookLike> findById(BookLikeId id);
    
    void deleteById(BookLikeId id);

    long countByBookId(UUID bookId);
    
    boolean existsByUserIdAndBookId(UUID userId, UUID bookId);
    
    Page<BookLike> findByUserId(UUID userId, Pageable pageable);
}

