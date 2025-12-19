package com.gaji.corebackend.dto.scenario;

import com.gaji.corebackend.enums.EventAlterationType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Event Alterations (사건 결과 변경)
 * 설명: 스토리의 주요 사건이 다르게 진행되거나 발생하지 않는 방식
 * 예시: "만약 개츠비가 데이지를 다시 만나지 않았다면?"
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventAlteration {
    
    /**
     * 사건 이름
     */
    private String eventName;
    
    /**
     * 원작에서의 사건 설명
     */
    private String originalEvent;
    
    /**
     * 변경 유형
     */
    private EventAlterationType alterationType;
    
    /**
     * 변경된 사건 결과 설명
     */
    private String alteredOutcome;
    
    /**
     * 영향받는 타임라인 설명
     */
    private String timelineImpact;
    
    /**
     * 사건 발생 시점 (챕터 또는 시간)
     */
    private String eventTiming;
}
