-- V44: Create character_relationships table
-- Stores character relationship graph data

CREATE TABLE character_relationships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    novel_id UUID NOT NULL REFERENCES novels(id) ON DELETE CASCADE,
    
    -- Source and target characters
    source_character_id UUID NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
    target_character_id UUID NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
    
    -- Relationship metadata
    relationship_type TEXT, -- e.g., 'friend', 'family', 'enemy', 'colleague'
    weight FLOAT, -- Relationship strength/frequency
    interaction_count INTEGER DEFAULT 0,
    
    -- Detailed relationship description
    description TEXT,
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_character_relationship UNIQUE (source_character_id, target_character_id),
    CONSTRAINT no_self_relationship CHECK (source_character_id != target_character_id)
);

-- Indexes
CREATE INDEX idx_char_rel_source ON character_relationships(source_character_id);
CREATE INDEX idx_char_rel_target ON character_relationships(target_character_id);
CREATE INDEX idx_char_rel_novel ON character_relationships(novel_id);

-- Comments
COMMENT ON TABLE character_relationships IS 'Character relationship graph extracted from novels';
COMMENT ON COLUMN character_relationships.weight IS 'Relationship strength (higher = more interactions)';

