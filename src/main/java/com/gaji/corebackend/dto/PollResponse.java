package com.gaji.corebackend.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * 폴링 응답 DTO
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PollResponse {
    
    private String status;  // queued, processing, completed, failed, unknown
    
    private String content;
    
    private String error;
    
    private UUID messageId;  // When completed and saved to DB
    
    // 턴 정보
    private Integer turnCount;  // 현재 턴 수
    private Integer maxTurns;   // 최대 턴 수 (기본값: 5)
}
