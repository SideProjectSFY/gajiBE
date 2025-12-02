-- V8: Create scenario_setting_modifications table
-- Tracks location/setting changes in user scenarios

CREATE TABLE scenario_setting_modifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    root_scenario_id UUID REFERENCES root_user_scenarios(id) ON DELETE CASCADE,
    leaf_scenario_id UUID REFERENCES leaf_user_scenarios(id) ON DELETE CASCADE,
    location_vectordb_id VARCHAR(100) NOT NULL,
    modification_type VARCHAR(50) NOT NULL,
    original_setting TEXT,
    new_setting TEXT NOT NULL,
    reasoning TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        (root_scenario_id IS NOT NULL AND leaf_scenario_id IS NULL) OR
        (root_scenario_id IS NULL AND leaf_scenario_id IS NOT NULL)
    )
);

-- Indexes for query performance
CREATE INDEX idx_scenario_setting_mod_root ON scenario_setting_modifications(root_scenario_id);
CREATE INDEX idx_scenario_setting_mod_leaf ON scenario_setting_modifications(leaf_scenario_id);
CREATE INDEX idx_scenario_setting_mod_location ON scenario_setting_modifications(location_vectordb_id);
CREATE INDEX idx_scenario_setting_mod_type ON scenario_setting_modifications(modification_type);

-- Add comments for documentation
COMMENT ON TABLE scenario_setting_modifications IS 'Location/setting modifications in user scenarios';
COMMENT ON COLUMN scenario_setting_modifications.location_vectordb_id IS 'VectorDB location ID being modified';
COMMENT ON COLUMN scenario_setting_modifications.modification_type IS 'Type of change: time_period, location, atmosphere';
COMMENT ON COLUMN scenario_setting_modifications.reasoning IS 'User explanation for why this setting was changed';
