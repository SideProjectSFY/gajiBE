package com.gaji.social.application;

import com.gaji.shared.contract.dto.BookCommentResponse;
import com.gaji.shared.contract.dto.CreateBookCommentRequest;
import com.gaji.shared.contract.dto.UpdateBookCommentRequest;
import com.gaji.content.application.ContentFacade;
import com.gaji.social.domain.model.BookComment;
import com.gaji.social.domain.repository.BookCommentRepository;
import com.gaji.auth.application.UserFacade;
import com.gaji.auth.domain.model.User;
import com.gaji.common.exception.ForbiddenException;
import com.gaji.common.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookCommentService {

    private final BookCommentRepository bookCommentRepository;
    private final ContentFacade contentFacade;
    private final UserFacade userFacade;
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
        if (!contentFacade.existsNovel(bookId)) {
            throw new ResourceNotFoundException("Book not found: " + bookId);
        }

        BookComment comment = BookComment.builder()
                .bookId(bookId)
                .userId(currentUser.getId())
                .content(request.getContent())
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();

        comment = bookCommentRepository.save(comment);
        
        // Manually set user for response
        comment.setUser(currentUser);
        
        return toResponse(comment, currentUser);
    }

    /**
     * Get paginated comments for a book
     * Comments are sorted by creation date (newest first)
     *
     * @param bookId Book UUID
     * @param page Page number (0-indexed)
     * @param size Page size
     * @param currentUser Current user (nullable for anonymous access)
     * @return Page of comment responses
     */
    @Transactional(readOnly = true)
    public Page<BookCommentResponse> getCommentsByBookId(UUID bookId, int page, int size, User currentUser) {
        Pageable pageable = PageRequest.of(page, size);
        Page<BookComment> commentsPage = bookCommentRepository.findByBookIdOrderByCreatedAtDesc(bookId, pageable);

        List<UUID> userIds = commentsPage.getContent().stream()
                .map(BookComment::getUserId)
                .distinct()
                .collect(Collectors.toList());

        Map<UUID, User> userMap = userFacade.findAllById(userIds).stream()
                .collect(Collectors.toMap(User::getId, Function.identity()));

        List<BookCommentResponse> responses = commentsPage.getContent().stream()
                .map(comment -> {
                    comment.setUser(userMap.get(comment.getUserId()));
                    return toResponse(comment, currentUser);
                })
                .collect(Collectors.toList());

        return new PageImpl<>(responses, pageable, commentsPage.getTotalElements());
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
        BookComment comment = bookCommentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment not found: " + commentId));

        // Authorization check
        if (!comment.getUserId().equals(currentUser.getId())) {
            throw new ForbiddenException("You can only edit your own comments");
        }

        comment.setContent(request.getContent());
        // repository.save not strictly needed with @Transactional and managed entity, but safe to call
        comment = bookCommentRepository.save(comment);

        // Manually set user for response if needed (it's currentUser)
        comment.setUser(currentUser);

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
        BookComment comment = bookCommentRepository.findById(commentId)
                .orElseThrow(() -> new ResourceNotFoundException("Comment not found: " + commentId));

        // Authorization check
        if (!comment.getUserId().equals(currentUser.getId())) {
            throw new ForbiddenException("You can only delete your own comments");
        }

        bookCommentRepository.delete(comment);
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
