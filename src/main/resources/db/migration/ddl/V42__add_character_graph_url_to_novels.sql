-- V51: Add character_graph_url to novels table for S3 relationship graphs
ALTER TABLE novels
ADD COLUMN character_graph_url VARCHAR(500);

-- Index for graph lookups
CREATE INDEX idx_novels_character_graph ON novels(character_graph_url) WHERE character_graph_url IS NOT NULL;

-- Comment
COMMENT ON COLUMN novels.character_graph_url IS 'S3 URL for character relationship graph visualization';