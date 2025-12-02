package com.gaji.corebackend.repository;

import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.entity.UserFollow;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

/**
 * Repository for UserFollow entity
 * Story 6.4: Follow/Follower System Backend
 * 
 * Uses JPA for consistency with User entity
 */
@Repository
public interface UserFollowRepository extends JpaRepository<UserFollow, UserFollow.UserFollowId> {

    /**
     * Check if a follow relationship exists
     * @param followerId ID of the follower
     * @param followeeId ID of the user being followed
     * @return true if relationship exists
     */
    boolean existsByFollowerIdAndFolloweeId(UUID followerId, UUID followeeId);

    /**
     * Delete a follow relationship (idempotent)
     * @param followerId ID of the follower
     * @param followeeId ID of the user being followed
     */
    void deleteByFollowerIdAndFolloweeId(UUID followerId, UUID followeeId);

    /**
     * Count followers of a user
     * @param followeeId ID of the user
     * @return number of followers
     */
    long countByFolloweeId(UUID followeeId);

    /**
     * Count users a user is following
     * @param followerId ID of the user
     * @return number of following
     */
    long countByFollowerId(UUID followerId);

    /**
     * Get paginated list of followers (users who follow this user)
     * Uses custom query to fetch User entities directly
     * @param followeeId ID of the user
     * @param pageable pagination parameters
     * @return page of User entities
     */
    @Query("SELECT uf.follower FROM UserFollow uf WHERE uf.followeeId = :followeeId ORDER BY uf.createdAt DESC")
    Page<User> findFollowersByFolloweeId(@Param("followeeId") UUID followeeId, Pageable pageable);

    /**
     * Get paginated list of following (users this user follows)
     * Uses custom query to fetch User entities directly
     * @param followerId ID of the user
     * @param pageable pagination parameters
     * @return page of User entities
     */
    @Query("SELECT uf.followee FROM UserFollow uf WHERE uf.followerId = :followerId ORDER BY uf.createdAt DESC")
    Page<User> findFollowingByFollowerId(@Param("followerId") UUID followerId, Pageable pageable);

    /**
     * Check if two users mutually follow each other
     * Optimized single query version (QA Recommendation #7)
     * @param userId1 First user ID
     * @param userId2 Second user ID
     * @return true if both follow each other
     */
    @Query("SELECT COUNT(uf) = 2 FROM UserFollow uf " +
           "WHERE (uf.followerId = :userId1 AND uf.followeeId = :userId2) " +
           "OR (uf.followerId = :userId2 AND uf.followeeId = :userId1)")
    boolean areMutualFollows(@Param("userId1") UUID userId1, @Param("userId2") UUID userId2);
}
