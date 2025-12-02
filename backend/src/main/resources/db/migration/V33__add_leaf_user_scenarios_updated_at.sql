-- V33: Add updated_at column to leaf_user_scenarios table
-- Missing timestamp column for tracking last modification

ALTER TABLE leaf_user_scenarios 
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN leaf_user_scenarios.updated_at IS 'Timestamp of last update to this scenario';
