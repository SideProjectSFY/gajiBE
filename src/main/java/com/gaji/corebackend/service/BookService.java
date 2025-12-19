package com.gaji.corebackend.service;

import com.gaji.corebackend.dto.BookResponse;
import com.gaji.corebackend.entity.Book;
import com.gaji.corebackend.mapper.BookMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for Book operations
 * Handles business logic for book browsing with filtering, sorting, and pagination
 */
@Service
@Transactional(readOnly = true)
public class BookService {

    private final BookMapper bookMapper;

    public BookService(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    /**
     * Find all books with pagination, filtering, and sorting
     *
     * @param page Page number (0-indexed)
     * @param size Page size
     * @param genre Optional genre filter (null = all genres)
     * @param sort Sort order: "scenarios", "conversations", "newest", "alphabetical"
     * @return Page of BookResponse DTOs
     */
    public Page<BookResponse> findAll(int page, int size, String genre, String sort) {
        // Validate and set defaults
        int validatedPage = Math.max(0, page);
        int validatedSize = Math.max(1, Math.min(100, size)); // Max 100 per page
        String validatedSort = validateSort(sort);
        
        // Calculate offset
        int offset = validatedPage * validatedSize;
        
        // Fetch books from database
        List<Book> books = bookMapper.findBooks(offset, validatedSize, genre, validatedSort);
        
        // Convert to DTOs
        List<BookResponse> bookResponses = books.stream()
                .map(BookResponse::from)
                .collect(Collectors.toList());
        
        // Get total count for pagination
        int totalElements = bookMapper.countBooks(genre);
        
        // Create pageable
        Pageable pageable = PageRequest.of(validatedPage, validatedSize);
        
        // Return Page object
        return new PageImpl<>(bookResponses, pageable, totalElements);
    }

    /**
     * Find book by ID
     *
     * @param id Book UUID
     * @return BookResponse DTO
     * @throws IllegalArgumentException if book not found
     */
    public BookResponse findById(UUID id) {
        Book book = bookMapper.findBookById(id);
        if (book == null) {
            throw new IllegalArgumentException("Book not found with id: " + id);
        }
        return BookResponse.from(book);
    }

    /**
     * Validate and normalize sort parameter
     *
     * @param sort User-provided sort parameter
     * @return Validated sort parameter (defaults to "scenarios")
     */
    private String validateSort(String sort) {
        if (sort == null) {
            return "scenarios";
        }
        
        switch (sort.toLowerCase()) {
            case "scenarios":
            case "conversations":
            case "newest":
            case "alphabetical":
                return sort.toLowerCase();
            default:
                return "scenarios"; // Default fallback
        }
    }
}
