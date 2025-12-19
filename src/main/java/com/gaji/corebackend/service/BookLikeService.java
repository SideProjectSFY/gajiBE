package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.BookResponse;
import com.gaji.corebackend.dto.LikeResponse;
import com.gaji.corebackend.entity.Book;
import com.gaji.corebackend.entity.BookLike;
import com.gaji.corebackend.mapper.BookLikeMapper;
import com.gaji.corebackend.mapper.BookMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookLikeService {

    private final BookLikeMapper bookLikeMapper;
    private final BookMapper bookMapper;

    /**
     * Like a book (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse likeBook(UUID bookId, UUID userId) {
        // Verify book exists
        Book book = bookMapper.findBookById(bookId);
        if (book == null) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        // Check if already liked
        boolean alreadyLiked = bookLikeMapper.existsByUserIdAndBookId(userId, bookId);

        if (alreadyLiked) {
            log.info("User {} already liked book {}", userId, bookId);
            int likeCount = (int) bookLikeMapper.countByBookId(bookId);
            return LikeResponse.builder()
                .isLiked(true)
                .likeCount(likeCount)
                .build();
        }

        // Create like
        BookLike like = BookLike.builder()
            .userId(userId)
            .bookId(bookId)
            .build();

        bookLikeMapper.insert(like);

        // Get updated like count
        int likeCount = (int) bookLikeMapper.countByBookId(bookId);

        log.info("User {} liked book {}", userId, bookId);

        return LikeResponse.builder()
            .isLiked(true)
            .likeCount(likeCount)
            .build();
    }

    /**
     * Unlike a book (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse unlikeBook(UUID bookId, UUID userId) {
        // Verify book exists
        Book book = bookMapper.findBookById(bookId);
        if (book == null) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        boolean existed = bookLikeMapper.existsByUserIdAndBookId(userId, bookId);

        if (!existed) {
            log.info("User {} never liked book {}", userId, bookId);
            int likeCount = (int) bookLikeMapper.countByBookId(bookId);
            return LikeResponse.builder()
                .isLiked(false)
                .likeCount(likeCount)
                .build();
        }

        // Delete like
        bookLikeMapper.deleteByUserIdAndBookId(userId, bookId);

        // Get updated like count
        int likeCount = (int) bookLikeMapper.countByBookId(bookId);

        log.info("User {} unliked book {}", userId, bookId);

        return LikeResponse.builder()
            .isLiked(false)
            .likeCount(likeCount)
            .build();
    }

    /**
     * Toggle like status for a book.
     * If liked, unlike it. If not liked, like it.
     */
    @Transactional
    public LikeResponse toggleLike(UUID bookId, UUID userId) {
        boolean isLiked = bookLikeMapper.existsByUserIdAndBookId(userId, bookId);
        
        if (isLiked) {
            return unlikeBook(bookId, userId);
        } else {
            return likeBook(bookId, userId);
        }
    }

    /**
     * Check if user liked a book.
     */
    @Transactional(readOnly = true)
    public LikeResponse isLiked(UUID bookId, UUID userId) {
        Book book = bookMapper.findBookById(bookId);
        if (book == null) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        boolean isLiked = bookLikeMapper.existsByUserIdAndBookId(userId, bookId);
        int likeCount = (int) bookLikeMapper.countByBookId(bookId);

        return LikeResponse.builder()
            .isLiked(isLiked)
            .likeCount(likeCount)
            .build();
    }

    /**
     * Get paginated list of books liked by user.
     */
    @Transactional(readOnly = true)
    public Page<BookResponse> getLikedBooks(UUID userId, Pageable pageable) {
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();
        
        List<UUID> bookIds = bookLikeMapper.findBookIdsByUserIdPaged(userId, limit, offset);
        long total = bookLikeMapper.countByUserId(userId);
        
        List<BookResponse> bookResponses = bookIds.stream()
            .map(bookMapper::findBookById)
            .filter(book -> book != null)
            .map(BookResponse::from)
            .collect(Collectors.toList());

        return new PageImpl<>(bookResponses, pageable, total);
    }

    /**
     * Get list of book IDs liked by user (for bulk checking).
     */
    @Transactional(readOnly = true)
    public List<UUID> getLikedBookIds(UUID userId) {
        return bookLikeMapper.findBookIdsByUserId(userId);
    }
}
