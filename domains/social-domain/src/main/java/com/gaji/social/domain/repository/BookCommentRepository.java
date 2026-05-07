package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.BookComment;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface BookCommentRepository {
    
    BookComment save(BookComment bookComment);
    
    Optional<BookComment> findById(UUID id);

    void delete(BookComment bookComment);
    
    void deleteById(UUID id);

    Page<BookComment> findByBookIdOrderByCreatedAtDesc(UUID bookId, Pageable pageable);
}

