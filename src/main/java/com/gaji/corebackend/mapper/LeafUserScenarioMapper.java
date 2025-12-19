package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.LeafUserScenario;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Mapper
public interface LeafUserScenarioMapper {
    Optional<LeafUserScenario> findById(UUID id);
    List<LeafUserScenario> findByParentScenarioId(UUID parentScenarioId);
    List<LeafUserScenario> findByUserId(@Param("userId") UUID userId);
    List<LeafUserScenario> findByUserIdWithPaging(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countByParentScenarioId(UUID parentScenarioId);
    List<LeafUserScenario> findByIsPrivateFalse(@Param("limit") int limit, @Param("offset") long offset);
    long countByIsPrivateFalse();
    boolean existsByParentScenarioIdAndUserId(@Param("parentScenarioId") UUID parentScenarioId, @Param("userId") UUID userId);
    List<LeafUserScenario> findAccessibleScenarios(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    long countAccessibleScenarios(@Param("userId") UUID userId);
    
    List<java.util.Map<String, Object>> findScenarioTree(UUID rootId);

    int insert(LeafUserScenario scenario);
    int update(LeafUserScenario scenario);
    int deleteById(UUID id);
    boolean existsById(UUID id);
}
