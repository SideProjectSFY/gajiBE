package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.BookCommentResponse;
import com.gaji.corebackend.dto.CreateBookCommentRequest;
import com.gaji.corebackend.dto.UpdateBookCommentRequest;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.security.CurrentUser;
import com.gaji.corebackend.service.BookCommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
@Tag(name = "Book Comments", description = "Book comment management APIs")
public class BookCommentController {

    private final BookCommentService bookCommentService;

    @PostMapping("/books/{bookId}/comments")
    @Operation(
        summary = "Create a comment on a book",
        description = "Authenticated users can post comments on books. Content must be 1-1000 characters.",
        security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponse(responseCode = "201", description = "Comment created successfully")
    @ApiResponse(responseCode = "400", description = "Invalid request (validation error)")
    @ApiResponse(responseCode = "401", description = "Unauthorized - authentication required")
    @ApiResponse(responseCode = "404", description = "Book not found")
    public ResponseEntity<BookCommentResponse> createComment(
            @Parameter(description = "Book ID", required = true)
            @PathVariable UUID bookId,
            @Valid @RequestBody CreateBookCommentRequest request,
            @CurrentUser User currentUser) {

        BookCommentResponse response = bookCommentService.createComment(bookId, request, currentUser);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/books/{bookId}/comments")
    @Operation(
        summary = "Get comments for a book",
        description = "Retrieve paginated list of comments for a book, sorted by newest first. Public endpoint."
    )
    @ApiResponse(responseCode = "200", description = "Comments retrieved successfully")
    @ApiResponse(responseCode = "404", description = "Book not found")
    public ResponseEntity<Page<BookCommentResponse>> getComments(
            @Parameter(description = "Book ID", required = true)
            @PathVariable UUID bookId,
            @Parameter(description = "Page number (0-indexed)", example = "0")
            @RequestParam(defaultValue = "0") int page,
            @CurrentUser(required = false) User currentUser) {

        Page<BookCommentResponse> comments = bookCommentService.getCommentsByBookId(bookId, page, currentUser);
        return ResponseEntity.ok(comments);
    }

    @PutMapping("/comments/{commentId}")
    @Operation(
        summary = "Update a comment",
        description = "Update your own comment. Only the comment author can edit.",
        security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponse(responseCode = "200", description = "Comment updated successfully")
    @ApiResponse(responseCode = "400", description = "Invalid request (validation error)")
    @ApiResponse(responseCode = "401", description = "Unauthorized - authentication required")
    @ApiResponse(responseCode = "403", description = "Forbidden - not the comment author")
    @ApiResponse(responseCode = "404", description = "Comment not found")
    public ResponseEntity<BookCommentResponse> updateComment(
            @Parameter(description = "Comment ID", required = true)
            @PathVariable UUID commentId,
            @Valid @RequestBody UpdateBookCommentRequest request,
            @CurrentUser User currentUser) {

        BookCommentResponse response = bookCommentService.updateComment(commentId, request, currentUser);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/comments/{commentId}")
    @Operation(
        summary = "Delete a comment",
        description = "Delete your own comment. Only the comment author can delete.",
        security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponse(responseCode = "204", description = "Comment deleted successfully")
    @ApiResponse(responseCode = "401", description = "Unauthorized - authentication required")
    @ApiResponse(responseCode = "403", description = "Forbidden - not the comment author")
    @ApiResponse(responseCode = "404", description = "Comment not found")
    public ResponseEntity<Void> deleteComment(
            @Parameter(description = "Comment ID", required = true)
            @PathVariable UUID commentId,
            @CurrentUser User currentUser) {

        bookCommentService.deleteComment(commentId, currentUser);
        return ResponseEntity.noContent().build();
    }
}
