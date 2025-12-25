package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.Conversation;
import com.gaji.corebackend.entity.Message;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface ConversationMapper {
    void insert(Conversation conversation);
    Optional<Conversation> findById(@Param("id") UUID id);
    Optional<Conversation> findByIdWithMessages(@Param("id") UUID id);
    List<Conversation> findByUserId(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") int offset);
    List<Conversation> findPublicByUserId(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") int offset);
    List<Conversation> findPublicAll(@Param("limit") int limit, @Param("offset") int offset);
    List<Conversation> findPublicAllWithFilters(
            @Param("search") String search,
            @Param("genre") String genre,
            @Param("sort") String sort,
            @Param("limit") int limit,
            @Param("offset") int offset
    );
    List<Conversation> findAll(@Param("limit") int limit, @Param("offset") int offset);
    int update(Conversation conversation);
    int delete(@Param("id") UUID id);
    List<Message> findMessagesByConversationId(@Param("conversationId") UUID conversationId);
    void insertMessage(Message message);
    void updateMessageCount(@Param("conversationId") UUID conversationId);
    int countByUserId(@Param("userId") UUID userId);
    void updateHasBeenForked(@Param("conversationId") UUID conversationId, @Param("hasBeenForked") boolean hasBeenForked);
    List<Conversation> findLikedByUserId(
        @Param("userId") UUID userId, 
        @Param("includePrivate") boolean includePrivate,
        @Param("limit") int limit, 
        @Param("offset") int offset
    );
    
    // Added methods
    default int deleteById(UUID id) { return delete(id); }
    boolean existsById(UUID id);
    
    /**
     * 시나리오 ID로 첫 번째 대화 조회 (가장 오래된 대화)
     * 시나리오 포크 시 원본 캐릭터 정보를 가져오기 위해 사용
     */
    Optional<Conversation> findFirstByScenarioId(@Param("scenarioId") UUID scenarioId);
}
