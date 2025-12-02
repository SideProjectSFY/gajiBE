-- V5: Create leaf_user_scenarios table
-- Child scenarios forked from root scenarios (max depth 1)

CREATE TABLE leaf_user_scenarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    parent_scenario_id UUID REFERENCES root_user_scenarios(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    what_if_question TEXT NOT NULL,
    scenario_type VARCHAR(50) NOT NULL,
    is_private BOOLEAN DEFAULT false,
    conversation_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (parent_scenario_id IS NOT NULL)
);

-- Indexes for query performance
CREATE INDEX idx_leaf_scenarios_user ON leaf_user_scenarios(user_id);
CREATE INDEX idx_leaf_scenarios_parent ON leaf_user_scenarios(parent_scenario_id);
CREATE INDEX idx_leaf_scenarios_private ON leaf_user_scenarios(is_private);
CREATE INDEX idx_leaf_scenarios_created ON leaf_user_scenarios(created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE leaf_user_scenarios IS 'Child scenarios forked from root scenarios (depth 1 only)';
COMMENT ON COLUMN leaf_user_scenarios.parent_scenario_id IS 'Parent root scenario this was forked from';
COMMENT ON COLUMN leaf_user_scenarios.what_if_question IS 'User''s "What If?" question for this forked scenario';
COMMENT ON COLUMN leaf_user_scenarios.scenario_type IS 'Type of the forked scenario';
