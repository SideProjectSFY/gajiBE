-- V20: Add scenario_category to distinguish scenario types
-- Story 3.6: Needed for scenario type filtering in search

-- Add scenario_category enum type
CREATE TYPE scenario_category AS ENUM (
    'CHARACTER_CHANGE',
    'EVENT_ALTERATION', 
    'SETTING_MODIFICATION',
    'MIXED'
);

-- Add scenario_category column to root_user_scenarios
ALTER TABLE root_user_scenarios
ADD COLUMN scenario_category scenario_category;

-- Auto-populate based on which fields are filled
UPDATE root_user_scenarios
SET scenario_category = 
    CASE
        WHEN character_changes IS NOT NULL AND event_alterations IS NULL AND setting_modifications IS NULL THEN 'CHARACTER_CHANGE'::scenario_category
        WHEN event_alterations IS NOT NULL AND character_changes IS NULL AND setting_modifications IS NULL THEN 'EVENT_ALTERATION'::scenario_category
        WHEN setting_modifications IS NOT NULL AND character_changes IS NULL AND event_alterations IS NULL THEN 'SETTING_MODIFICATION'::scenario_category
        ELSE 'MIXED'::scenario_category
    END;

-- Make it nullable (scenarios can have multiple types)
-- But encourage setting a primary category for filtering

-- Add index for filtering by category
CREATE INDEX idx_root_scenarios_category ON root_user_scenarios(scenario_category);

-- Add comment
COMMENT ON COLUMN root_user_scenarios.scenario_category IS 'Primary category for filtering: CHARACTER_CHANGE, EVENT_ALTERATION, SETTING_MODIFICATION, or MIXED';
