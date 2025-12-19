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
public class BookLike {

    private UUID userId;
    private UUID bookId;
    private LocalDateTime createdAt;

    // Associations for result mapping
    private User user;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class BookLikeId implements Serializable {
        private UUID userId;
        private UUID bookId;
    }
}
