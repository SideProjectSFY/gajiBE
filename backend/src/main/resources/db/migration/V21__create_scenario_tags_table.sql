CREATE TABLE scenario_tags (
    scenario_id UUID NOT NULL,
    scenario_type VARCHAR(20) NOT NULL CHECK (scenario_type IN ('root_user', 'leaf_user')),
    tag_id UUID REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (scenario_id, tag_id)
);