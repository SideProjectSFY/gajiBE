package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.BookComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface BookCommentMapper {
    Optional<BookComment> findById(UUID id);
    Optional<BookComment> findByIdWithUser(UUID id);
    Optional<BookComment> findByIdAndUserId(@Param("id") UUID id, @Param("userId") UUID userId);
    List<BookComment> findByBookIdOrderByCreatedAtDesc(@Param("bookId") UUID bookId, @Param("limit") int limit, @Param("offset") long offset);
    long countByBookId(UUID bookId);
    
    int insert(BookComment comment);
    int update(BookComment comment);
    int deleteById(UUID id);
    boolean existsById(UUID id);
}
