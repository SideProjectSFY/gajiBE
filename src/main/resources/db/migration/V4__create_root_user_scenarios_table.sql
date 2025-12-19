-- V4: Create root_user_scenarios table
-- Root-level user-created "What If?" scenarios

CREATE TABLE root_user_scenarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    base_scenario_id UUID REFERENCES base_scenarios(id) ON DELETE SET NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    what_if_question TEXT NOT NULL,
    scenario_type VARCHAR(50) NOT NULL CHECK (scenario_type IN (
        'CHARACTER_CHANGE', 'EVENT_ALTERATION', 'SETTING_MODIFICATION'
    )),
    is_private BOOLEAN DEFAULT false,
    fork_count INTEGER DEFAULT 0,
    conversation_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for query performance
CREATE INDEX idx_root_scenarios_user ON root_user_scenarios(user_id);
CREATE INDEX idx_root_scenarios_base ON root_user_scenarios(base_scenario_id);
CREATE INDEX idx_root_scenarios_private ON root_user_scenarios(is_private);
CREATE INDEX idx_root_scenarios_created ON root_user_scenarios(created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE root_user_scenarios IS 'Root-level user scenarios (max depth 1 - ROOT only)';
COMMENT ON COLUMN root_user_scenarios.what_if_question IS 'User''s "What If?" question for this scenario';
COMMENT ON COLUMN root_user_scenarios.scenario_type IS 'Type of modification: CHARACTER_CHANGE, EVENT_ALTERATION, or SETTING_MODIFICATION';
COMMENT ON COLUMN root_user_scenarios.is_private IS 'Whether scenario is private (false = public, visible to all users)';
COMMENT ON COLUMN root_user_scenarios.fork_count IS 'Number of times this scenario has been forked';
