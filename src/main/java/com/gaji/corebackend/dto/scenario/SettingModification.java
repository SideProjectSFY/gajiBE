package com.gaji.corebackend.dto.scenario;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Setting Modifications (배경/세계관 수정)
 * 설명: 스토리의 배경, 시대, 장소, 문화적 맥락을 변경하는 방식
 * 예시: "만약 오만과 편견이 2024년 서울에서 일어났다면?"
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SettingModification {
    
    /**
     * 시간대 변경 (예: 과거 → 현재/미래)
     */
    private TimePeriodChange timePeriod;
    
    /**
     * 장소 변경 (예: 영국 → 한국)
     */
    private LocationChange location;
    
    /**
     * 문화적 맥락 변경
     */
    private CulturalContextChange culturalContext;
    
    /**
     * 마법 시스템/기술 수준 변경
     */
    private SystemChange systemChange;
    
    /**
     * 기타 세계관 변경 (자유 형식)
     */
    private String otherModifications;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class TimePeriodChange {
        /**
         * 원래 시간대
         */
        private String originalPeriod;
        
        /**
         * 변경된 시간대
         */
        private String modifiedPeriod;
        
        /**
         * 시간대 변경으로 인한 주요 차이점
         */
        private String keyDifferences;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class LocationChange {
        /**
         * 원래 장소
         */
        private String originalLocation;
        
        /**
         * 변경된 장소
         */
        private String modifiedLocation;
        
        /**
         * 장소 변경으로 인한 주요 차이점
         */
        private String keyDifferences;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class CulturalContextChange {
        /**
         * 원래 문화적 맥락
         */
        private String originalContext;
        
        /**
         * 변경된 문화적 맥락
         */
        private String modifiedContext;
        
        /**
         * 문화적 변경으로 인한 주요 차이점
         */
        private String keyDifferences;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class SystemChange {
        /**
         * 시스템 유형 (magic_system, technology_level, social_system 등)
         */
        private String systemType;
        
        /**
         * 원래 시스템
         */
        private String originalSystem;
        
        /**
         * 변경된 시스템
         */
        private String modifiedSystem;
        
        /**
         * 시스템 변경으로 인한 주요 차이점
         */
        private String keyDifferences;
    }
}
