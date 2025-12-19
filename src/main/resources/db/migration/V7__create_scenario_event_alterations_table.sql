-- V7: Create scenario_event_alterations table
-- Tracks event/plot modifications in user scenarios

CREATE TABLE scenario_event_alterations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    root_scenario_id UUID REFERENCES root_user_scenarios(id) ON DELETE CASCADE,
    leaf_scenario_id UUID REFERENCES leaf_user_scenarios(id) ON DELETE CASCADE,
    event_vectordb_id VARCHAR(100) NOT NULL,
    alteration_type VARCHAR(50) NOT NULL,
    original_event TEXT,
    new_event TEXT NOT NULL,
    reasoning TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        (root_scenario_id IS NOT NULL AND leaf_scenario_id IS NULL) OR
        (root_scenario_id IS NULL AND leaf_scenario_id IS NOT NULL)
    )
);

-- Indexes for query performance
CREATE INDEX idx_scenario_event_alt_root ON scenario_event_alterations(root_scenario_id);
CREATE INDEX idx_scenario_event_alt_leaf ON scenario_event_alterations(leaf_scenario_id);
CREATE INDEX idx_scenario_event_alt_event ON scenario_event_alterations(event_vectordb_id);
CREATE INDEX idx_scenario_event_alt_type ON scenario_event_alterations(alteration_type);

-- Add comments for documentation
COMMENT ON TABLE scenario_event_alterations IS 'Event/plot modifications in user scenarios';
COMMENT ON COLUMN scenario_event_alterations.event_vectordb_id IS 'VectorDB event ID being altered';
COMMENT ON COLUMN scenario_event_alterations.alteration_type IS 'Type of change: prevented, modified, added';
COMMENT ON COLUMN scenario_event_alterations.reasoning IS 'User explanation for why this event was altered';
