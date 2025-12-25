package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.RootUserScenario;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface RootUserScenarioMapper {
    Optional<RootUserScenario> findById(UUID id);
    List<RootUserScenario> findByUserId(@Param("userId") UUID userId);
    List<RootUserScenario> findByUserIdWithPaging(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countByUserId(UUID userId);
    
    List<RootUserScenario> findPublicByUserIdWithPaging(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countPublicByUserId(UUID userId);

    List<RootUserScenario> findByIsPrivateFalse(@Param("limit") int limit, @Param("offset") long offset);
    long countByIsPrivateFalse();
    List<RootUserScenario> findByBaseScenarioId(UUID baseScenarioId);
    List<RootUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countAccessibleScenarios(@Param("userId") UUID userId);
    
    boolean existsByNovelIdAndContentHash(@Param("novelId") UUID novelId, @Param("contentHash") String contentHash);
    
    List<RootUserScenario> searchPublicScenarios(@Param("query") String query, @Param("limit") int limit, @Param("offset") long offset);
    long countSearchPublicScenarios(@Param("query") String query);

    List<RootUserScenario> searchWithFilters(
            @Param("query") String query,
            @Param("category") String category,
            @Param("creatorId") String creatorId,
            @Param("limit") int limit,
            @Param("offset") long offset
    );

    long countSearchResults(
            @Param("query") String query,
            @Param("category") String category,
            @Param("creatorId") String creatorId
    );

    List<RootUserScenario> filterScenarios(
            @Param("category") com.gaji.corebackend.entity.ScenarioCategory category,
            @Param("creatorId") UUID creatorId,
            @Param("limit") int limit,
            @Param("offset") long offset
    );

    long countFilterScenarios(
            @Param("category") com.gaji.corebackend.entity.ScenarioCategory category,
            @Param("creatorId") UUID creatorId
    );
    
    int insert(RootUserScenario scenario);
    int update(RootUserScenario scenario);
    int deleteById(UUID id);
    boolean existsById(UUID id);
    
    /**
     * 기준 대화 설정
     * @param scenarioId 시나리오 ID
     * @param conversationId 기준 대화 ID
     */
    int updateReferenceConversation(@Param("scenarioId") UUID scenarioId, @Param("conversationId") UUID conversationId);
}
