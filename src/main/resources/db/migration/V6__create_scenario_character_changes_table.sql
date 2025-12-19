-- V6: Create scenario_character_changes table
-- Tracks character modifications in user scenarios

CREATE TABLE scenario_character_changes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    root_scenario_id UUID REFERENCES root_user_scenarios(id) ON DELETE CASCADE,
    leaf_scenario_id UUID REFERENCES leaf_user_scenarios(id) ON DELETE CASCADE,
    character_vectordb_id VARCHAR(100) NOT NULL,
    attribute VARCHAR(100) NOT NULL,
    original_value TEXT,
    new_value TEXT NOT NULL,
    reasoning TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        (root_scenario_id IS NOT NULL AND leaf_scenario_id IS NULL) OR
        (root_scenario_id IS NULL AND leaf_scenario_id IS NOT NULL)
    )
);

-- Indexes for query performance
CREATE INDEX idx_scenario_char_changes_root ON scenario_character_changes(root_scenario_id);
CREATE INDEX idx_scenario_char_changes_leaf ON scenario_character_changes(leaf_scenario_id);
CREATE INDEX idx_scenario_char_changes_char ON scenario_character_changes(character_vectordb_id);
CREATE INDEX idx_scenario_char_changes_attr ON scenario_character_changes(attribute);

-- Add comments for documentation
COMMENT ON TABLE scenario_character_changes IS 'Character attribute modifications in user scenarios';
COMMENT ON COLUMN scenario_character_changes.character_vectordb_id IS 'VectorDB character ID being modified';
COMMENT ON COLUMN scenario_character_changes.attribute IS 'Which character attribute is changed (house, personality, etc.)';
COMMENT ON COLUMN scenario_character_changes.reasoning IS 'User explanation for why this change was made';
