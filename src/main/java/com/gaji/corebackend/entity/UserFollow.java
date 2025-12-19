package com.gaji.corebackend.entity;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserFollow {

    private UUID followerId;
    private UUID followeeId;
    private LocalDateTime createdAt;

    // Associations for result mapping
    private User follower;
    private User followee;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserFollowId implements Serializable {
        private UUID followerId;
        private UUID followeeId;
    }
}
