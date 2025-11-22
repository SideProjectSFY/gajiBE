-- V8: Create scenario_setting_modifications table
-- Tracks location/setting changes in user scenarios

CREATE TABLE scenario_setting_modifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    scenario_id UUID NOT NULL REFERENCES root_user_scenarios(id) ON DELETE CASCADE,
    location_vectordb_id UUID NOT NULL,    -- Reference to VectorDB locations collection
    modification_type VARCHAR(50) NOT NULL, -- e.g., "time_period", "location", "atmosphere"
    original_value TEXT,
    new_value TEXT NOT NULL,
    reasoning TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for query performance
CREATE INDEX idx_scenario_setting_mod_scenario ON scenario_setting_modifications(scenario_id);
CREATE INDEX idx_scenario_setting_mod_location ON scenario_setting_modifications(location_vectordb_id);
CREATE INDEX idx_scenario_setting_mod_type ON scenario_setting_modifications(modification_type);

-- Add comments for documentation
COMMENT ON TABLE scenario_setting_modifications IS 'Location/setting modifications in user scenarios';
COMMENT ON COLUMN scenario_setting_modifications.location_vectordb_id IS 'VectorDB location ID being modified';
COMMENT ON COLUMN scenario_setting_modifications.modification_type IS 'Type of change: time_period, location, atmosphere';
COMMENT ON COLUMN scenario_setting_modifications.reasoning IS 'User explanation for why this setting was changed';
