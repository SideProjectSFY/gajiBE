package com.gaji.social.infrastructure.persistence;

import com.gaji.social.domain.model.UserFollow;
import com.gaji.social.domain.model.UserFollowId;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;

import java.util.UUID;

public interface UserFollowJpaRepository extends JpaRepository<UserFollow, UserFollowId>, QuerydslPredicateExecutor<UserFollow> {
    long countByFollowerId(UUID followerId); // Following count
    long countByFolloweeId(UUID followeeId); // Follower count
    boolean existsByFollowerIdAndFolloweeId(UUID followerId, UUID followeeId);
    
    // Followers of X
    Page<UserFollow> findByFolloweeId(UUID followeeId, Pageable pageable);
    
    // Who X follows
    Page<UserFollow> findByFollowerId(UUID followerId, Pageable pageable);
}
