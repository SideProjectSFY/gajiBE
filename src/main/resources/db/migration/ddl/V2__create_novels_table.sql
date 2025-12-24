-- V2: Create novels table (METADATA ONLY - NO full_text column)
-- References VectorDB for content storage via vectordb_collection_id

CREATE TABLE novels (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(500) NOT NULL,
    author VARCHAR(200),
    original_language VARCHAR(10),
    era VARCHAR(100),
    genre VARCHAR(100),
    publication_year INTEGER,
    isbn VARCHAR(20),
    series_title VARCHAR(300),
    series_number INTEGER,
    copyright_status VARCHAR(50) CHECK (copyright_status IN ('public_domain', 'copyrighted', 'creative_commons', 'unknown')),
    cover_image_url VARCHAR(500),
    description TEXT,
    is_verified BOOLEAN DEFAULT false,
    creator_id UUID REFERENCES users(id) ON DELETE SET NULL,
    vectordb_collection_id VARCHAR(100),
    ingestion_status VARCHAR(20) DEFAULT 'pending',
    total_passages_count INTEGER DEFAULT 0,
    total_characters_count INTEGER DEFAULT 0,
    gutenberg_file_path VARCHAR(255),
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
