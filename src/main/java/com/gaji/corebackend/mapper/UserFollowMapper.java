package com.gaji.corebackend.mapper;

import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.entity.UserFollow;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.UUID;

@Mapper
public interface UserFollowMapper {
    boolean existsByFollowerIdAndFolloweeId(@Param("followerId") UUID followerId, @Param("followeeId") UUID followeeId);
    int deleteByFollowerIdAndFolloweeId(@Param("followerId") UUID followerId, @Param("followeeId") UUID followeeId);
    long countByFolloweeId(UUID followeeId);
    long countByFollowerId(UUID followerId);
    
    List<User> findFollowersByUserId(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    List<User> findFollowingByUserId(@Param("userId") UUID userId, @Param("limit") int limit, @Param("offset") long offset);
    
    int insert(UserFollow userFollow);
}
