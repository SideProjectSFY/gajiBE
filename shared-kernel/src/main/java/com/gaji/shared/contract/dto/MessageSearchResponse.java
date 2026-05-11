package com.gaji.shared.contract.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MessageSearchResponse {

    private UUID messageId;
    private UUID conversationId;
    private String conversationTitle;
    private String role;
    private String snippet;
    private LocalDateTime createdAt;
}
