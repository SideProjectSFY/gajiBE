package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookComment {

    private UUID id;
    private UUID bookId;
    private UUID userId;
    private String content;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Associations for result mapping
    private Novel book;
    private User user;
}
