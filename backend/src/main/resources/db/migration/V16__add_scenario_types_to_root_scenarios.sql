-- V16: Add scenario type fields to root_user_scenarios for unified modal
-- Adds novel_id, scenario_title, and three scenario type text fields

-- Add novel_id reference
ALTER TABLE root_user_scenarios 
ADD COLUMN novel_id UUID REFERENCES novels(id) ON DELETE CASCADE;

-- Add scenario types as text fields (free-form text, not normalized)
ALTER TABLE root_user_scenarios 
ADD COLUMN character_changes TEXT,
ADD COLUMN event_alterations TEXT,
ADD COLUMN setting_modifications TEXT;

-- Add index for novel_id lookups
CREATE INDEX idx_root_scenarios_novel ON root_user_scenarios(novel_id);

-- Add comments for documentation
COMMENT ON COLUMN root_user_scenarios.novel_id IS 'Reference to the novel this scenario is based on';
COMMENT ON COLUMN root_user_scenarios.character_changes IS 'Free-form text describing character changes (min 10 chars if provided)';
COMMENT ON COLUMN root_user_scenarios.event_alterations IS 'Free-form text describing event alterations (min 10 chars if provided)';
COMMENT ON COLUMN root_user_scenarios.setting_modifications IS 'Free-form text describing setting modifications (min 10 chars if provided)';

