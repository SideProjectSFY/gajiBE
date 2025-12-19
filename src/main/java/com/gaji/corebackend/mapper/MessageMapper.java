package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.Message;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface MessageMapper {

    @Insert("""
        INSERT INTO messages (id, conversation_id, sender_id, role, content, created_at)
        VALUES (#{id}, #{conversationId}, #{senderId}, #{role}, #{content}, NOW())
        """)
    void insert(Message message);

    @Select("""
        SELECT m.id, m.conversation_id, m.sender_id, m.role, m.content, m.created_at
        FROM messages m
        WHERE m.conversation_id = #{conversationId}
        ORDER BY m.created_at ASC
        """)
    @Results(id = "MessageResult", value = {
        @Result(property = "id", column = "id"),
        @Result(property = "conversationId", column = "conversation_id"),
        @Result(property = "senderId", column = "sender_id"),
        @Result(property = "role", column = "role"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at")
    })
    List<Message> findByConversationIdOrderByCreatedAt(@Param("conversationId") UUID conversationId);

    @Select("""
        SELECT m.id, m.conversation_id, m.sender_id, m.role, m.content, m.created_at
        FROM messages m
        WHERE m.conversation_id = #{conversationId} AND m.role = #{role}
        ORDER BY m.created_at DESC
        LIMIT 1
        """)
    @ResultMap("MessageResult")
    Optional<Message> findLatestByConversationAndRole(@Param("conversationId") UUID conversationId, 
                                                       @Param("role") String role);

    @Select("""
        SELECT m.id, m.conversation_id, m.sender_id, m.role, m.content, m.created_at
        FROM messages m
        WHERE m.id = #{id}
        """)
    @ResultMap("MessageResult")
    Optional<Message> findById(@Param("id") UUID id);
}
