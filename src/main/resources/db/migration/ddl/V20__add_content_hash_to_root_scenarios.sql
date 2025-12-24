-- V17: Add content_hash for duplicate detection
-- Hash of (scenario_title + character_changes + event_alterations + setting_modifications)

ALTER TABLE root_user_scenarios 
ADD COLUMN content_hash VARCHAR(32);

-- Create index for fast duplicate lookups
CREATE INDEX idx_root_scenarios_novel_hash ON root_user_scenarios(novel_id, content_hash);

-- Add comment for documentation
COMMENT ON COLUMN root_user_scenarios.content_hash IS 'MD5 hash of scenario content for duplicate detection';

