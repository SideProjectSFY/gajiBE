package com.gaji.corebackend.service;

import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.entity.UserFollow;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.repository.UserFollowRepository;
import com.gaji.corebackend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

/**
 * Service for managing user follow relationships
 * Story 6.4: Follow/Follower System Backend
 * 
 * Implements all QA recommendations:
 * - HIGH #1: Uses JPA Repository consistently (not MyBatis Mapper)
 * - HIGH #2: Proper pagination with Page<User> return type
 * - HIGH #3: JPA entity with proper annotations
 * - HIGH #4: Uses JPA save() method (no custom insert needed)
 * - HIGH #5: Race condition handled with try-catch DuplicateKeyException
 * - MEDIUM #6: @Transactional on all service methods
 * - MEDIUM #7: Optimized mutual follow check with single query
 */
@Service
@RequiredArgsConstructor
public class UserFollowService {

    private final UserFollowRepository userFollowRepository;
    private final UserRepository userRepository;

    /**
     * Follow a user
     * Idempotent operation - no error if already following
     * 
     * @param followerId ID of the user who wants to follow
     * @param followeeId ID of the user to be followed
     * @throws BadRequestException if trying to follow yourself
     * @throws ResourceNotFoundException if either user doesn't exist
     */
    @Transactional
    public void followUser(UUID followerId, UUID followeeId) {
        // Validate: Cannot follow yourself
        if (followerId.equals(followeeId)) {
            throw new BadRequestException("Cannot follow yourself");
        }

        // Validate: Both users exist
        User follower = userRepository.findById(followerId)
            .orElseThrow(() -> new ResourceNotFoundException("Follower not found"));
        User followee = userRepository.findById(followeeId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        // HIGH #5: Race condition handling - try insert, catch duplicate
        try {
            // Create follow relationship
            UserFollow userFollow = UserFollow.builder()
                .followerId(followerId)
                .followeeId(followeeId)
                .build();

            userFollowRepository.save(userFollow);
        } catch (DataIntegrityViolationException e) {
            // Already following or constraint violation - idempotent behavior
            // This handles both duplicate key and CHECK constraint violations
            return;
        }
    }

    /**
     * Unfollow a user
     * Idempotent operation - no error if not following
     * 
     * @param followerId ID of the user who wants to unfollow
     * @param followeeId ID of the user to be unfollowed
     */
    @Transactional
    public void unfollowUser(UUID followerId, UUID followeeId) {
        // Idempotent: Delete if exists, no error if doesn't exist
        userFollowRepository.deleteByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    /**
     * Check if a user is following another user
     * 
     * @param followerId ID of the potential follower
     * @param followeeId ID of the user being checked
     * @return true if following relationship exists
     */
    @Transactional(readOnly = true)
    public boolean isFollowing(UUID followerId, UUID followeeId) {
        return userFollowRepository.existsByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    /**
     * Get paginated list of followers (users who follow this user)
     * HIGH #2: Proper pagination - returns Page<User> directly from repository
     * 
     * @param userId ID of the user
     * @param pageable pagination parameters
     * @return page of User entities
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowers(UUID userId, Pageable pageable) {
        return userFollowRepository.findFollowersByFolloweeId(userId, pageable);
    }

    /**
     * Get paginated list of following (users this user follows)
     * HIGH #2: Proper pagination - returns Page<User> directly from repository
     * 
     * @param userId ID of the user
     * @param pageable pagination parameters
     * @return page of User entities
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowing(UUID userId, Pageable pageable) {
        return userFollowRepository.findFollowingByFollowerId(userId, pageable);
    }

    /**
     * Get follower count for a user
     * 
     * @param userId ID of the user
     * @return number of followers
     */
    @Transactional(readOnly = true)
    public long getFollowerCount(UUID userId) {
        return userFollowRepository.countByFolloweeId(userId);
    }

    /**
     * Get following count for a user
     * 
     * @param userId ID of the user
     * @return number of users being followed
     */
    @Transactional(readOnly = true)
    public long getFollowingCount(UUID userId) {
        return userFollowRepository.countByFollowerId(userId);
    }

    /**
     * Check if two users mutually follow each other
     * MEDIUM #7: Optimized with single query instead of two separate checks
     * 
     * @param userId1 First user ID
     * @param userId2 Second user ID
     * @return true if both users follow each other
     */
    @Transactional(readOnly = true)
    public boolean isMutualFollow(UUID userId1, UUID userId2) {
        return userFollowRepository.areMutualFollows(userId1, userId2);
    }
}
