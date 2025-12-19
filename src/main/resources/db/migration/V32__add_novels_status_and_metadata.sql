-- V32: Add status, copyright_note, and metadata to novels table
-- Priority 3 (Medium): Consistency improvement with ERD

-- Add status column for novel publication status
ALTER TABLE novels 
ADD COLUMN status VARCHAR(20) DEFAULT 'PUBLISHED' 
CHECK (status IN ('DRAFT', 'PUBLISHED', 'ARCHIVED'));

-- Add copyright_note for detailed copyright information
ALTER TABLE novels 
ADD COLUMN copyright_note TEXT;

-- Add metadata JSONB column for flexible additional data
ALTER TABLE novels 
ADD COLUMN metadata JSONB;

-- Create index for status filtering
CREATE INDEX IF NOT EXISTS idx_novels_status ON novels(status);

-- Create GIN index for JSONB metadata queries
CREATE INDEX IF NOT EXISTS idx_novels_metadata ON novels USING GIN(metadata);

-- Add comments for documentation
COMMENT ON COLUMN novels.status IS 'Novel publication status: DRAFT, PUBLISHED, or ARCHIVED';
COMMENT ON COLUMN novels.copyright_note IS 'Detailed copyright information and restrictions';
COMMENT ON COLUMN novels.metadata IS 'Additional flexible metadata stored as JSONB';

-- Note: This keeps existing columns (vectordb_collection_id, ingestion_status, etc.)
-- for operational purposes while adding ERD-specified columns for business logic
