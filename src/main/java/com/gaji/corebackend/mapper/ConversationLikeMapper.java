package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.ConversationLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.UUID;

@Mapper
public interface ConversationLikeMapper {
    boolean existsByUserIdAndConversationId(@Param("userId") UUID userId, @Param("conversationId") UUID conversationId);
    List<Conversation> findLikedConversationsByUserId(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countLikedConversationsByUserId(UUID userId);
    long countByConversationId(UUID conversationId);
    
    int insert(ConversationLike like);
    int deleteByUserIdAndConversationId(@Param("userId") UUID userId, @Param("conversationId") UUID conversationId);
}
