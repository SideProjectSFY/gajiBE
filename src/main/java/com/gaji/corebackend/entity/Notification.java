package com.gaji.corebackend.entity;

import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notification {

    private UUID id;
    private UUID userId;
    private String type;
    private String content;
    
    @Builder.Default
    private Boolean isRead = false;
    
    private String relatedLink;
    private LocalDateTime createdAt;
    
    // Relationships (optional, for MyBatis mapping if needed)
    private User user;
}
