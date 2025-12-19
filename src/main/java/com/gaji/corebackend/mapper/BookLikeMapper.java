package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.BookLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.UUID;

@Mapper
public interface BookLikeMapper {
    boolean existsByUserIdAndBookId(@Param("userId") UUID userId, @Param("bookId") UUID bookId);
    List<UUID> findBookIdsByUserId(@Param("userId") UUID userId);
    List<UUID> findBookIdsByUserIdPaged(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countByBookId(UUID bookId);
    long countByUserId(UUID userId);
    
    int insert(BookLike like);
    int deleteByUserIdAndBookId(@Param("userId") UUID userId, @Param("bookId") UUID bookId);
}
