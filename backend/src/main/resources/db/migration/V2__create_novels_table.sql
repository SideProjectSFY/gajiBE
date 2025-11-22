-- V2: Create novels table (METADATA ONLY - NO full_text column)
-- References VectorDB for content storage via vectordb_collection_id

CREATE TABLE novels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(500) NOT NULL,
    author VARCHAR(200) NOT NULL,
    publication_year INTEGER,
    genre VARCHAR(100),
    vectordb_collection_id VARCHAR(255) NOT NULL UNIQUE,  -- Reference to VectorDB collection
    ingestion_status VARCHAR(50) DEFAULT 'pending',       -- pending, processing, completed, failed
    total_passages_count INTEGER,
    total_characters_count INTEGER,
    gutenberg_file_path VARCHAR(500),                     -- For debugging/reference
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for search and lookup performance
CREATE INDEX idx_novels_title ON novels(title);
CREATE INDEX idx_novels_author ON novels(author);
CREATE INDEX idx_novels_vectordb ON novels(vectordb_collection_id);
CREATE INDEX idx_novels_status ON novels(ingestion_status);

-- Add comments for documentation
COMMENT ON TABLE novels IS 'Novel metadata only - content stored in VectorDB';
COMMENT ON COLUMN novels.vectordb_collection_id IS 'VectorDB collection identifier for novel passages';
COMMENT ON COLUMN novels.ingestion_status IS 'Novel processing status: pending, processing, completed, failed';
COMMENT ON COLUMN novels.total_passages_count IS 'Total number of passages stored in VectorDB';
