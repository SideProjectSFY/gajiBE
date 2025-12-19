CREATE TABLE scenario_likes (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    scenario_id UUID NOT NULL,
    scenario_type VARCHAR(20) NOT NULL CHECK (scenario_type IN ('root_user', 'leaf_user')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, scenario_id)
);