package com.gaji.social.domain.repository;

import com.gaji.social.domain.model.UserFollow;
import com.gaji.social.domain.model.UserFollowId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;
import java.util.UUID;

public interface UserFollowRepository {
    
    UserFollow save(UserFollow userFollow);
    
    Optional<UserFollow> findById(UserFollowId id);

    boolean existsById(UserFollowId id);
    
    void deleteById(UserFollowId id);

    long countByFollowerId(UUID followerId); // Following count
    
    long countByFolloweeId(UUID followeeId); // Follower count
    
    boolean existsByFollowerIdAndFolloweeId(UUID followerId, UUID followeeId);
    
    // Followers of X
    Page<UserFollow> findByFolloweeId(UUID followeeId, Pageable pageable);
    
    // Who X follows
    Page<UserFollow> findByFollowerId(UUID followerId, Pageable pageable);
}

