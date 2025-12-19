package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.BookResponse;
import com.gaji.corebackend.dto.LikeResponse;
import com.gaji.corebackend.security.CurrentUser;
import com.gaji.corebackend.security.UserPrincipal;
import com.gaji.corebackend.service.BookLikeService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST API for book like operations
 */
@RestController
@RequestMapping("/api/v1/books")
@RequiredArgsConstructor
@Tag(name = "Book Likes", description = "Book like/unlike API")
public class BookLikeController {

    private final BookLikeService bookLikeService;

    /**
     * Like a book.
     * POST /api/v1/books/{id}/like
     */
    @PostMapping("/{id}/like")
    @Operation(summary = "Like a book", description = "Like a book. Idempotent - calling twice won't double-like.")
    public ResponseEntity<LikeResponse> likeBook(
        @Parameter(description = "Book UUID") @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = bookLikeService.likeBook(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Unlike a book.
     * DELETE /api/v1/books/{id}/like
     */
    @DeleteMapping("/{id}/like")
    @Operation(summary = "Unlike a book", description = "Remove like from a book. Idempotent.")
    public ResponseEntity<LikeResponse> unlikeBook(
        @Parameter(description = "Book UUID") @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = bookLikeService.unlikeBook(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Toggle like status for a book.
     * POST /api/v1/books/{id}/like/toggle
     */
    @PostMapping("/{id}/like/toggle")
    @Operation(summary = "Toggle book like", description = "Toggle like status. If liked, unlike. If not liked, like.")
    public ResponseEntity<LikeResponse> toggleLike(
        @Parameter(description = "Book UUID") @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = bookLikeService.toggleLike(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Check if user liked a book.
     * GET /api/v1/books/{id}/liked
     */
    @GetMapping("/{id}/liked")
    @Operation(summary = "Check if liked", description = "Check if current user has liked a book")
    public ResponseEntity<LikeResponse> isLiked(
        @Parameter(description = "Book UUID") @PathVariable UUID id,
        @CurrentUser UserPrincipal currentUser
    ) {
        LikeResponse response = bookLikeService.isLiked(id, currentUser.getUserId());
        return ResponseEntity.ok(response);
    }

    /**
     * Get user's liked books.
     * GET /api/v1/books/liked
     */
    @GetMapping("/liked")
    @Operation(summary = "Get liked books", description = "Get paginated list of books liked by user. If userId is not provided, returns current user's liked books.")
    public ResponseEntity<Page<BookResponse>> getLikedBooks(
        @CurrentUser UserPrincipal currentUser,
        @Parameter(description = "Target User ID") @RequestParam(required = false) UUID userId,
        @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        UUID targetUserId = (userId != null) ? userId : currentUser.getUserId();
        Page<BookResponse> books = bookLikeService.getLikedBooks(targetUserId, pageable);
        return ResponseEntity.ok(books);
    }

    /**
     * Get list of book IDs liked by user (for bulk checking).
     * GET /api/v1/books/liked/ids
     */
    @GetMapping("/liked/ids")
    @Operation(summary = "Get liked book IDs", description = "Get list of book IDs liked by current user for efficient bulk checking")
    public ResponseEntity<List<UUID>> getLikedBookIds(
        @CurrentUser UserPrincipal currentUser
    ) {
        List<UUID> bookIds = bookLikeService.getLikedBookIds(currentUser.getUserId());
        return ResponseEntity.ok(bookIds);
    }
}
