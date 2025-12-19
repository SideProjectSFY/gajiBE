package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.BookCommentResponse;
import com.gaji.corebackend.dto.CreateBookCommentRequest;
import com.gaji.corebackend.dto.UpdateBookCommentRequest;
import com.gaji.corebackend.entity.BookComment;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.exception.ForbiddenException;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.mapper.BookCommentMapper;
import com.gaji.corebackend.mapper.NovelMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookCommentService {

    private final BookCommentMapper bookCommentMapper;
    private final NovelMapper novelMapper;
    private static final int PAGE_SIZE = 20;

    /**
     * Create a new comment on a book
     * Validates book exists and associates comment with current user
     *
     * @param bookId Book UUID
     * @param request Comment creation request
     * @param currentUser Current authenticated user
     * @return Created comment response
     * @throws ResourceNotFoundException if book not found
     */
    @Transactional
    public BookCommentResponse createComment(UUID bookId, CreateBookCommentRequest request, User currentUser) {
        // Validate book exists
        if (!novelMapper.existsById(bookId)) {
            throw new ResourceNotFoundException("Book not found: " + bookId);
        }

        BookComment comment = BookComment.builder()
                .id(UUID.randomUUID())
                .bookId(bookId)
                .userId(currentUser.getId())
                .content(request.getContent())
                .build();

        bookCommentMapper.insert(comment);
        
        // Fetch with user to avoid LazyInitializationException
        BookComment withUser = bookCommentMapper.findByIdWithUser(comment.getId())
                .orElse(comment);
        
        // Manually set user if not fetched (though mapper should fetch it)
        if (withUser.getUser() == null) {
            withUser.setUser(currentUser);
        }
        
        return toResponse(withUser, currentUser);
    }

    /**
     * Get paginated comments for a book
     * Comments are sorted by creation date (newest first)
     *
     * @param bookId Book UUID
     * @param page Page number (0-indexed)
     * @param currentUser Current user (nullable for anonymous access)
     * @return Page of comment responses
     */
    @Transactional(readOnly = true)
    public Page<BookCommentResponse> getCommentsByBookId(UUID bookId, int page, User currentUser) {
        int offset = page * PAGE_SIZE;
        List<BookComment> comments = bookCommentMapper.findByBookIdOrderByCreatedAtDesc(bookId, PAGE_SIZE, offset);
        long total = bookCommentMapper.countByBookId(bookId);

        List<BookCommentResponse> responses = comments.stream()
                .map(comment -> toResponse(comment, currentUser))
                .collect(Collectors.toList());

        Pageable pageable = PageRequest.of(page, PAGE_SIZE);
        return new PageImpl<>(responses, pageable, total);
    }

    /**
     * Update an existing comment
     * Only the comment author can update their comment
     *
     * @param commentId Comment UUID
     * @param request Update request
     * @param currentUser Current authenticated user
     * @return Updated comment response
     * @throws ResourceNotFoundException if comment not found
     * @throws ForbiddenException if user is not the comment author
     */
    @Transactional
    public BookCommentResponse updateComment(UUID commentId, UpdateBookCommentRequest request, User currentUser) {
        BookComment comment = bookCommentMapper.findByIdWithUser(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment not found: " + commentId));

        // Authorization check
        if (!comment.getUserId().equals(currentUser.getId())) {
            throw new ForbiddenException("You can only edit your own comments");
        }

        comment.setContent(request.getContent());
        bookCommentMapper.update(comment);

        return toResponse(comment, currentUser);
    }

    /**
     * Delete a comment
     * Only the comment author can delete their comment
     *
     * @param commentId Comment UUID
     * @param currentUser Current authenticated user
     * @throws ResourceNotFoundException if comment not found
     * @throws ForbiddenException if user is not the comment author
     */
    @Transactional
    public void deleteComment(UUID commentId, User currentUser) {
        BookComment comment = bookCommentMapper.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment not found: " + commentId));

        // Authorization check
        if (!comment.getUserId().equals(currentUser.getId())) {
            throw new ForbiddenException("You can only delete your own comments");
        }

        bookCommentMapper.deleteById(commentId);
    }

    /**
     * Convert BookComment entity to response DTO
     * Includes user information and isAuthor flag
     *
     * @param comment Comment entity
     * @param currentUser Current user (nullable)
     * @return Comment response DTO
     */
    private BookCommentResponse toResponse(BookComment comment, User currentUser) {
        // Get user information from the lazy-loaded relationship
        User commentUser = comment.getUser();
        
        return BookCommentResponse.builder()
                .id(comment.getId())
                .bookId(comment.getBookId())
                .userId(comment.getUserId())
                .username(commentUser != null ? commentUser.getUsername() : "Unknown")
                .userAvatarUrl(commentUser != null ? commentUser.getAvatarUrl() : null)
                .content(comment.getContent())
                .createdAt(comment.getCreatedAt())
                .updatedAt(comment.getUpdatedAt())
                .isAuthor(currentUser != null && comment.getUserId().equals(currentUser.getId()))
                .build();
    }
}
