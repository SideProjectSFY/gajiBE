package com.gaji.corebackend.enums;

/**
 * Event Alteration Types
 * 사건 변경 유형
 */
public enum EventAlterationType {
    /**
     * 사건이 발생하지 않음
     */
    NEVER_OCCURRED("never_occurred", "사건이 발생하지 않음"),
    
    /**
     * 사건이 막힘
     */
    PREVENTED("prevented", "사건이 막힘"),
    
    /**
     * 결과가 바뀜
     */
    OUTCOME_CHANGED("outcome_changed", "결과가 바뀜"),
    
    /**
     * 사건이 성공함
     */
    SUCCEEDED("succeeded", "사건이 성공함");
    
    private final String code;
    private final String description;
    
    EventAlterationType(String code, String description) {
        this.code = code;
        this.description = description;
    }
    
    public String getCode() {
        return code;
    }
    
    public String getDescription() {
        return description;
    }
}
