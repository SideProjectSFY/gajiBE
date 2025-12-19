package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.ConversationMemo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Optional;
import java.util.UUID;

@Mapper
public interface ConversationMemoMapper {
    Optional<ConversationMemo> findById(UUID id);
    Optional<ConversationMemo> findByUserIdAndConversationId(@Param("userId") UUID userId, @Param("conversationId") UUID conversationId);
    boolean existsByUserIdAndConversationId(@Param("userId") UUID userId, @Param("conversationId") UUID conversationId);
    int deleteByUserIdAndConversationId(@Param("userId") UUID userId, @Param("conversationId") UUID conversationId);
    
    int insert(ConversationMemo memo);
    int update(ConversationMemo memo);
    int deleteById(UUID id);
    boolean existsById(UUID id);
}
