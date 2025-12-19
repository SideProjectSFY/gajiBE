package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.FollowResponse;
import com.gaji.corebackend.dto.IsFollowingResponse;
import com.gaji.corebackend.dto.UserDTO;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.exception.ResourceNotFoundException;
import com.gaji.corebackend.mapper.UserMapper;
import com.gaji.corebackend.service.UserFollowService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST Controller for user follow operations
 * Story 6.4: Follow/Follower System Backend
 * 
 * Endpoints:
 * - POST /api/users/{id}/follow - Follow a user
 * - DELETE /api/users/{id}/unfollow - Unfollow a user
 * - GET /api/users/{id}/is-following - Check follow status
 * - GET /api/users/{id}/followers - Get followers list (paginated)
 * - GET /api/users/{id}/following - Get following list (paginated)
 */
@RestController
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
public class UserFollowController {

    private final UserFollowService userFollowService;
    private final UserMapper userMapper;

    /**
     * Follow a user
     * 
     * @param id User ID to follow
     * @param userId Authenticated user ID from header
     * @return FollowResponse with updated status
     */
    @PostMapping("/{id}/follow")
    public ResponseEntity<FollowResponse> followUser(
        @PathVariable UUID id,
        @RequestHeader("X-User-Id") UUID userId
    ) {
        userFollowService.followUser(userId, id);

        // Build response with current status
        FollowResponse response = new FollowResponse(
            true, // isFollowing
            userFollowService.getFollowerCount(id), // followerCount
            userFollowService.isMutualFollow(userId, id) // isMutual
        );

        return ResponseEntity.ok(response);
    }

    /**
     * Unfollow a user
     * 
     * @param id User ID to unfollow
     * @param userId Authenticated user ID from header
     * @return FollowResponse with updated status
     */
    @DeleteMapping("/{id}/unfollow")
    public ResponseEntity<FollowResponse> unfollowUser(
        @PathVariable UUID id,
        @RequestHeader("X-User-Id") UUID userId
    ) {
        userFollowService.unfollowUser(userId, id);

        // Build response with current status
        FollowResponse response = new FollowResponse(
            false, // isFollowing
            userFollowService.getFollowerCount(id), // followerCount
            false // isMutual (cannot be mutual if not following)
        );

        return ResponseEntity.ok(response);
    }

    /**
     * Check if current user is following a target user
     * 
     * @param id User ID to check
     * @param userId Authenticated user ID from header
     * @return IsFollowingResponse with follow status
     */
    @GetMapping("/{id}/is-following")
    public ResponseEntity<IsFollowingResponse> isFollowing(
        @PathVariable UUID id,
        @RequestHeader("X-User-Id") UUID userId
    ) {
        boolean isFollowing = userFollowService.isFollowing(userId, id);
        boolean isMutual = userFollowService.isMutualFollow(userId, id);

        IsFollowingResponse response = new IsFollowingResponse(isFollowing, isMutual);

        return ResponseEntity.ok(response);
    }


    /**
     * Get paginated list of followers
     * Public endpoint - anyone can see who follows a user
     * 
     * @param id User ID
     * @param page Page number (0-indexed)
     * @param size Page size
     * @return Page of UserDTO
     */
    @GetMapping("/{id}/followers")
    public ResponseEntity<Page<UserDTO>> getFollowers(
        @PathVariable UUID id,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "20") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<User> followers = userFollowService.getFollowers(id, pageable);

        // Convert User entities to UserDTO
        Page<UserDTO> followerDTOs = followers.map(this::toDTO);

        return ResponseEntity.ok(followerDTOs);
    }

    /**
     * Get paginated list of following
     * Public endpoint - anyone can see who a user follows
     * 
     * @param id User ID
     * @param page Page number (0-indexed)
     * @param size Page size
     * @return Page of UserDTO
     */
    @GetMapping("/{id}/following")
    public ResponseEntity<Page<UserDTO>> getFollowing(
        @PathVariable UUID id,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "20") int size
    ) {
        Pageable pageable = PageRequest.of(page, size);
        Page<User> following = userFollowService.getFollowing(id, pageable);

        // Convert User entities to UserDTO
        Page<UserDTO> followingDTOs = following.map(this::toDTO);

        return ResponseEntity.ok(followingDTOs);
    }

    /**
     * Convert User entity to UserDTO
     * HIGH #8: Uses @Builder annotation on UserDTO
     * 
     * @param user User entity
     * @return UserDTO
     */
    private UserDTO toDTO(User user) {
        return UserDTO.builder()
            .id(user.getId())
            .username(user.getUsername())
            .email(user.getEmail())
            .avatarUrl(user.getAvatarUrl())
            .bio(user.getBio())
            .build();
    }
}
