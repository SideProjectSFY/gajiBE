-- V31: Add difficulty_level and estimated_play_time to base_scenarios table
-- Priority 2 (High): Data integrity enhancement for scenario metadata

-- Add difficulty_level column
ALTER TABLE base_scenarios 
ADD COLUMN difficulty_level VARCHAR(20) 
CHECK (difficulty_level IN ('EASY', 'MEDIUM', 'HARD'));

-- Add estimated_play_time column (in minutes)
ALTER TABLE base_scenarios 
ADD COLUMN estimated_play_time INTEGER 
CHECK (estimated_play_time > 0 AND estimated_play_time <= 600);

-- Create index for filtering by difficulty
CREATE INDEX idx_base_scenarios_difficulty ON base_scenarios(difficulty_level);

-- Create index for filtering by play time
CREATE INDEX idx_base_scenarios_play_time ON base_scenarios(estimated_play_time);

-- Add comments for documentation
COMMENT ON COLUMN base_scenarios.difficulty_level IS 'Scenario difficulty: EASY, MEDIUM, or HARD';
COMMENT ON COLUMN base_scenarios.estimated_play_time IS 'Estimated play time in minutes (1-600)';
