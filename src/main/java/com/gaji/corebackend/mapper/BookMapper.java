package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.UUID;

/**
 * MyBatis Mapper for Book operations
 * Uses novels table in PostgreSQL
 */
@Mapper
public interface BookMapper {

    /**
     * Find books with pagination, filtering, and sorting
     * Aggregates scenario and conversation counts
     *
     * @param offset Pagination offset
     * @param limit Pagination limit (page size)
     * @param genre Optional genre filter (null = all genres)
     * @param sort Sort order: "scenarios", "conversations", "newest", "alphabetical"
     * @return List of books with aggregated counts
     */
    List<Book> findBooks(
        @Param("offset") int offset,
        @Param("limit") int limit,
        @Param("genre") String genre,
        @Param("sort") String sort,
        @Param("search") String search
    );

    /**
     * Count total books (for pagination)
     * Applies genre filter if provided
     *
     * @param genre Optional genre filter (null = all genres)
     * @return Total number of books matching filter
     */
    int countBooks(@Param("genre") String genre);

    /**
     * Find book by ID with aggregated counts
     *
     * @param id Book UUID
     * @return Book with counts, or null if not found
     */
    Book findBookById(@Param("id") UUID id);
}
