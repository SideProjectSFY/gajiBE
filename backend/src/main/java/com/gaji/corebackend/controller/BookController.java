package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.BookResponse;
import com.gaji.corebackend.service.BookService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST Controller for Book operations
 * Handles book browsing with filtering, sorting, and pagination
 */
@RestController
@RequestMapping("/api/v1/books")
@Tag(name = "Books", description = "Book browsing and discovery API")
public class BookController {

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    /**
     * Get paginated list of books with optional filtering and sorting
     *
     * @param page Page number (0-indexed, default: 0)
     * @param size Page size (default: 20, max: 100)
     * @param genre Optional genre filter (e.g., "Fantasy", "Sci-Fi")
     * @param sort Sort order: "scenarios" (default), "conversations", "newest", "alphabetical"
     * @return Paginated list of books with metadata
     */
    @GetMapping
    @Operation(
        summary = "Browse books",
        description = "Get paginated list of books with filtering by genre and sorting options. " +
                     "Each book includes aggregated scenario and conversation counts."
    )
    public ResponseEntity<Page<BookResponse>> getBooks(
            @Parameter(description = "Page number (0-indexed)")
            @RequestParam(defaultValue = "0") int page,
            
            @Parameter(description = "Page size (max 100)")
            @RequestParam(defaultValue = "20") int size,
            
            @Parameter(description = "Filter by genre (optional)")
            @RequestParam(required = false) String genre,
            
            @Parameter(description = "Sort order: scenarios, conversations, newest, alphabetical")
            @RequestParam(defaultValue = "scenarios") String sort
    ) {
        Page<BookResponse> books = bookService.findAll(page, size, genre, sort);
        return ResponseEntity.ok(books);
    }

    /**
     * Get book by ID
     *
     * @param id Book UUID
     * @return Book details with aggregated counts
     */
    @GetMapping("/{id}")
    @Operation(
        summary = "Get book by ID",
        description = "Retrieve detailed information about a specific book including scenario and conversation counts"
    )
    public ResponseEntity<BookResponse> getBookById(
            @Parameter(description = "Book UUID")
            @PathVariable UUID id
    ) {
        BookResponse book = bookService.findById(id);
        return ResponseEntity.ok(book);
    }
}
