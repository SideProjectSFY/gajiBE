package com.gaji.corebackend.entity;

/**
 * Enum for scenario category types
 * Story 3.6: Used for filtering scenarios by primary category
 */
public enum ScenarioCategory {
    /**
     * Scenario focuses on character changes
     */
    CHARACTER_CHANGE,

    /**
     * Scenario focuses on event alterations
     */
    EVENT_ALTERATION,

    /**
     * Scenario focuses on setting modifications
     */
    SETTING_MODIFICATION,

    /**
     * Scenario has multiple types of changes
     */
    MIXED
}
