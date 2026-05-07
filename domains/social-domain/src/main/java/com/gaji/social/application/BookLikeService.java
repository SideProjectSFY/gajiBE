package com.gaji.social.application;

import com.gaji.shared.contract.dto.BookResponse;
import com.gaji.shared.contract.dto.LikeResponse;
import com.gaji.content.application.ContentFacade;
import com.gaji.social.domain.model.BookLike;
import com.gaji.social.domain.model.BookLikeId;
import com.gaji.social.domain.repository.BookLikeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookLikeService {

    private final BookLikeRepository bookLikeRepository;
    private final ContentFacade contentFacade;

    /**
     * Like a book (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse likeBook(UUID bookId, UUID userId) {
        // Verify book exists
        if (!contentFacade.existsBook(bookId)) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        // Check if already liked
        boolean alreadyLiked = bookLikeRepository.existsByUserIdAndBookId(userId, bookId);

        if (alreadyLiked) {
            log.info("User {} already liked book {}", userId, bookId);
            long likeCount = bookLikeRepository.countByBookId(bookId);
            return LikeResponse.builder()
                .isLiked(true)
                .likeCount((int) likeCount)
                .build();
        }

        // Create like
        BookLike like = BookLike.builder()
            .userId(userId)
            .bookId(bookId)
            // .createdAt handled by Auditing
            .build();

        bookLikeRepository.save(like);

        // Get updated like count
        long likeCount = bookLikeRepository.countByBookId(bookId);

        log.info("User {} liked book {}", userId, bookId);

        return LikeResponse.builder()
            .isLiked(true)
            .likeCount((int) likeCount)
            .build();
    }

    /**
     * Unlike a book (idempotent).
     * Returns like status and current count.
     */
    @Transactional
    public LikeResponse unlikeBook(UUID bookId, UUID userId) {
        // Verify book exists
        if (!contentFacade.existsBook(bookId)) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        boolean existed = bookLikeRepository.existsByUserIdAndBookId(userId, bookId);

        if (!existed) {
            log.info("User {} never liked book {}", userId, bookId);
            long likeCount = bookLikeRepository.countByBookId(bookId);
            return LikeResponse.builder()
                .isLiked(false)
                .likeCount((int) likeCount)
                .build();
        }

        // Delete like
        bookLikeRepository.deleteById(new BookLikeId(userId, bookId));

        // Get updated like count
        long likeCount = bookLikeRepository.countByBookId(bookId);

        log.info("User {} unliked book {}", userId, bookId);

        return LikeResponse.builder()
            .isLiked(false)
            .likeCount((int) likeCount)
            .build();
    }

    /**
     * Toggle like status for a book.
     * If liked, unlike it. If not liked, like it.
     */
    @Transactional
    public LikeResponse toggleLike(UUID bookId, UUID userId) {
        boolean isLiked = bookLikeRepository.existsByUserIdAndBookId(userId, bookId);
        
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
        if (!contentFacade.existsBook(bookId)) {
            throw new IllegalArgumentException("Book not found: " + bookId);
        }

        boolean isLiked = bookLikeRepository.existsByUserIdAndBookId(userId, bookId);
        int likeCount = (int) bookLikeRepository.countByBookId(bookId);

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
        Page<BookLike> likes = bookLikeRepository.findByUserId(userId, pageable);

        List<BookResponse> bookResponses = likes.getContent().stream()
            .map(like -> contentFacade.findBookResponseById(like.getBookId()))
            .flatMap(Optional::stream)
            .collect(Collectors.toList());

        return new PageImpl<>(bookResponses, pageable, likes.getTotalElements());
    }

    /**
     * Get list of book IDs liked by user (for bulk checking).
     */
    @Transactional(readOnly = true)
    public List<UUID> getLikedBookIds(UUID userId) {
        return bookLikeRepository.findByUserId(userId, Pageable.unpaged()).getContent().stream()
                .map(BookLike::getBookId)
                .collect(Collectors.toList());
    }
}
