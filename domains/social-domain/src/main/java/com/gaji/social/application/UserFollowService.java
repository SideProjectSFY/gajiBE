package com.gaji.social.application;

import com.gaji.auth.domain.model.User;
import com.gaji.auth.application.UserFacade;
import com.gaji.common.exception.BadRequestException;
import com.gaji.common.exception.ResourceNotFoundException;
import com.gaji.social.domain.model.UserFollow;
import com.gaji.social.domain.model.UserFollowId;
import com.gaji.social.domain.repository.UserFollowRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing user follow relationships
 */
@Service
@RequiredArgsConstructor
public class UserFollowService {

    private final UserFollowRepository userFollowRepository;
    private final UserFacade userFacade;

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
        if (!userFacade.existsById(followerId)) {
            throw new ResourceNotFoundException("Follower not found");
        }
        if (!userFacade.existsById(followeeId)) {
            throw new ResourceNotFoundException("User not found");
        }

        // Check if already following
        if (userFollowRepository.existsByFollowerIdAndFolloweeId(followerId, followeeId)) {
            return;
        }

        try {
            // Create follow relationship
            UserFollow userFollow = UserFollow.builder()
                .followerId(followerId)
                .followeeId(followeeId)
                .build();

            userFollowRepository.save(userFollow);
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
        userFollowRepository.deleteById(new UserFollowId(followerId, followeeId));
    }

    /**
     * Check if a user is following another user
     */
    @Transactional(readOnly = true)
    public boolean isFollowing(UUID followerId, UUID followeeId) {
        return userFollowRepository.existsByFollowerIdAndFolloweeId(followerId, followeeId);
    }

    /**
     * Get list of followers
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowers(UUID userId, Pageable pageable) {
        Page<UserFollow> follows = userFollowRepository.findByFolloweeId(userId, pageable);
        
        List<UUID> followerIds = follows.getContent().stream()
                .map(UserFollow::getFollowerId)
                .collect(Collectors.toList());

        if (followerIds.isEmpty()) {
            return new PageImpl<>(Collections.emptyList(), pageable, follows.getTotalElements());
        }

        List<User> followers = userFacade.findAllById(followerIds);
        
        return new PageImpl<>(followers, pageable, follows.getTotalElements());
    }

    /**
     * Get list of following
     */
    @Transactional(readOnly = true)
    public Page<User> getFollowing(UUID userId, Pageable pageable) {
        Page<UserFollow> follows = userFollowRepository.findByFollowerId(userId, pageable);
        
        List<UUID> followeeIds = follows.getContent().stream()
                .map(UserFollow::getFolloweeId)
                .collect(Collectors.toList());

        if (followeeIds.isEmpty()) {
            return new PageImpl<>(Collections.emptyList(), pageable, follows.getTotalElements());
        }

        List<User> following = userFacade.findAllById(followeeIds);
        
        // Use userFacade.findAllById results directly
        return new PageImpl<>(following, pageable, follows.getTotalElements());
    }

    /**
     * Count followers
     */
    @Transactional(readOnly = true)
    public long getFollowerCount(UUID userId) {
        return userFollowRepository.countByFolloweeId(userId);
    }

    /**
     * Count following
     */
    @Transactional(readOnly = true)
    public long getFollowingCount(UUID userId) {
        return userFollowRepository.countByFollowerId(userId);
    }

    /**
     * Check if two users mutually follow each other
     */
    @Transactional(readOnly = true)
    public boolean isMutualFollow(UUID userId1, UUID userId2) {
        return userFollowRepository.existsById(new UserFollowId(userId1, userId2)) &&
               userFollowRepository.existsById(new UserFollowId(userId2, userId1));
    }
}
