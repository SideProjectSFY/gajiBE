package com.gaji.corebackend.service;

import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.entity.UserFollow;
import com.gaji.corebackend.exception.BadRequestException;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.mapper.UserFollowMapper;
import com.gaji.corebackend.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

/**
 * Service for managing user follow relationships
 */
@Service
@RequiredArgsConstructor
public class UserFollowService {

    private final UserFollowMapper userFollowMapper;
    private final UserMapper userMapper;

    /**
     * Follow a user
     */
    @Transactional
    public void followUser(UUID followerId, UUID followeeId) {
        // Validate: Cannot follow yourself
        if (followerId.equals(followeeId)) {
            throw new BadRequestException("Cannot follow yourself");
        }

        // Validate: Both users exist
        if (!userMapper.existsById(followerId)) {
            throw new ResourceNotFoundException("Follower not found");
        }
        if (!userMapper.existsById(followeeId)) {
            throw new ResourceNotFoundException("User not found");
        }

        // Check if already following
        if (userFollowMapper.existsByFollowerIdAndFolloweeId(followerId, followeeId)) {
            return;
        }

        try {
            // Create follow relationship
            UserFollow userFollow = UserFollow.builder()
                .followerId(followerId)
                .followeeId(followeeId)
                .build();

            userFollowMapper.insert(userFollow);
        } catch (DataIntegrityViolationException e) {
            // Already following or constraint violation - idempotent behavior
            return;
        }
    }

    /**
     * Unfollow a user
     */
    @Transactional
    public void unfollowUser(UUID followerId, UUID followeeId) {
        userFollowMapper.deleteByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    /**
     * Check if a user is following another user
     */
    @Transactional(readOnly = true)
    public boolean isFollowing(UUID followerId, UUID followeeId) {
        return userFollowMapper.existsByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    /**
     * Get list of followers
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowers(UUID userId, Pageable pageable) {
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();
        
        List<User> followers = userFollowMapper.findFollowersByUserId(userId, limit, offset);
        long total = userFollowMapper.countByFolloweeId(userId);
        
        return new PageImpl<>(followers, pageable, total);
    }

    /**
     * Get list of following
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowing(UUID userId, Pageable pageable) {
        int limit = pageable.getPageSize();
        long offset = pageable.getOffset();
        
        List<User> following = userFollowMapper.findFollowingByUserId(userId, limit, offset);
        long total = userFollowMapper.countByFollowerId(userId);
        
        return new PageImpl<>(following, pageable, total);
    }
    
    /**
     * Count followers
     */
    @Transactional(readOnly = true)
    public long getFollowerCount(UUID userId) {
        return userFollowMapper.countByFolloweeId(userId);
    }

    /**
     * Count following
     */
    @Transactional(readOnly = true)
    public long getFollowingCount(UUID userId) {
        return userFollowMapper.countByFollowerId(userId);
    }

    /**
     * Check if two users mutually follow each other
     */
    @Transactional(readOnly = true)
    public boolean isMutualFollow(UUID userId1, UUID userId2) {
        return userFollowMapper.existsByFollowerIdAndFolloweeId(userId1, userId2) &&
               userFollowMapper.existsByFollowerIdAndFolloweeId(userId2, userId1);
    }
}
