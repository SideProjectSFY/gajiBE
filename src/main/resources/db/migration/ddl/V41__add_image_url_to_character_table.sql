
-- V50: Add image_url to characters table for S3 portrait images
ALTER TABLE characters
ADD COLUMN image_url VARCHAR(500);

-- Index for image lookups
CREATE INDEX idx_characters_image_url ON characters(image_url) WHERE image_url IS NOT NULL;

-- Comment
COMMENT ON COLUMN characters.image_url IS 'S3 URL for character portrait image';