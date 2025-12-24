-- V3: Create base_scenarios table
-- Stores references to VectorDB passages that define scenario context

CREATE TABLE base_scenarios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    novel_id UUID NOT NULL REFERENCES novels(id) ON DELETE CASCADE,
    base_story VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    vectordb_passage_ids TEXT[],
    chapter_number INTEGER,
    page_range VARCHAR(50),
    character_summary TEXT,
    location_summary TEXT,
    theme_summary TEXT,
    content_summary TEXT,
    tags TEXT[],
    is_verified BOOLEAN DEFAULT false,
    creator_id UUID REFERENCES users(id),
    character_vectordb_ids TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for query performance
CREATE INDEX idx_base_scenarios_novel ON base_scenarios(novel_id);
CREATE INDEX idx_base_scenarios_title ON base_scenarios(title);

-- Add comments for documentation
COMMENT ON TABLE base_scenarios IS 'Base scenarios extracted from novels, references VectorDB for content';
COMMENT ON COLUMN base_scenarios.vectordb_passage_ids IS 'Array of VectorDB passage IDs that define this scenario';
COMMENT ON COLUMN base_scenarios.character_vectordb_ids IS 'Array of VectorDB character IDs involved in scenario';
