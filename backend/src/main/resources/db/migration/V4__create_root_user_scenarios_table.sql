-- V4: Create root_user_scenarios table
-- Root-level user-created "What If?" scenarios

CREATE TABLE root_user_scenarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    base_scenario_id UUID REFERENCES base_scenarios(id) ON DELETE SET NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    what_if_question TEXT NOT NULL,
    is_public BOOLEAN DEFAULT FALSE,
    fork_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for query performance
CREATE INDEX idx_root_scenarios_user ON root_user_scenarios(user_id);
CREATE INDEX idx_root_scenarios_base ON root_user_scenarios(base_scenario_id);
CREATE INDEX idx_root_scenarios_public ON root_user_scenarios(is_public);
CREATE INDEX idx_root_scenarios_created ON root_user_scenarios(created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE root_user_scenarios IS 'Root-level user scenarios (max depth 1 - ROOT only)';
COMMENT ON COLUMN root_user_scenarios.what_if_question IS 'User''s "What If?" question for this scenario';
COMMENT ON COLUMN root_user_scenarios.is_public IS 'Whether scenario is visible to other users';
COMMENT ON COLUMN root_user_scenarios.fork_count IS 'Number of times this scenario has been forked';
