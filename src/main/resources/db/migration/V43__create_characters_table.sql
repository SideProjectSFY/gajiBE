-- V33: Create characters table
-- Stores character information extracted from novels

CREATE TABLE characters (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    novel_id UUID NOT NULL REFERENCES novels(id) ON DELETE CASCADE,
    
    -- Character identification
    common_name VARCHAR(200) NOT NULL,
    is_main_character BOOLEAN DEFAULT false,
    alternative_names TEXT[], -- Array of alternative names
    
    -- Character description
    description TEXT,
    portrait_prompt TEXT,
    
    -- AI persona and speaking style
    persona TEXT,
    persona_en TEXT,
    persona_ko TEXT,
    speaking_style TEXT,
    speaking_style_en TEXT,
    speaking_style_ko TEXT,
    
    -- VectorDB reference (for character embeddings)
    vectordb_character_id VARCHAR(100),
    
    -- Character graph metadata
    char_graph_id INTEGER, -- Original ID from char_graph JSON
    
    -- Metadata
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_novel_common_name UNIQUE (novel_id, common_name)
);

-- Indexes
CREATE INDEX idx_characters_novel ON characters(novel_id);
CREATE INDEX idx_characters_main ON characters(is_main_character);
CREATE INDEX idx_characters_vectordb ON characters(vectordb_character_id);

-- Comments
COMMENT ON TABLE characters IS 'Novel character information for AI conversations';
COMMENT ON COLUMN characters.alternative_names IS 'Array of alternative names/aliases used in the novel';
COMMENT ON COLUMN characters.char_graph_id IS 'Original character ID from character graph analysis';

