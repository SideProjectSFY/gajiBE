package com.gaji.corebackend.dto.scenario;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Character Property Changes (캐릭터 속성 변경)
 * 설명: 캐릭터의 속성(성격, 소속, 능력, 배경 등)을 변경하는 방식
 * 예시: "만약 헤르미온이가 슬리데린에 배정되었다면?"
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CharacterPropertyChange {
    
    /**
     * 캐릭터 이름
     */
    private String characterName;
    
    /**
     * 집 배정 (예: 그리핀도르 → 슬리데린)
     */
    private PropertyChange houseAssignment;
    
    /**
     * 성격 특성 변경
     */
    private PropertyChange personalityTraits;
    
    /**
     * 친구 그룹 변경
     */
    private PropertyChange friendGroup;
    
    /**
     * 배경 스토리 변경
     */
    private PropertyChange backgroundStory;
    
    /**
     * 기타 속성 변경 (자유 형식)
     */
    private String otherChanges;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class PropertyChange {
        /**
         * 원래 값 (Before)
         */
        private String originalValue;
        
        /**
         * 변경된 값 (After)
         */
        private String changedValue;
        
        /**
         * 변경 이유 또는 설명
         */
        private String reason;
    }
}
