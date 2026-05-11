-- V61: Add indexes for conversation message search
-- Supports owned-message keyword search and recent-history reads without loading full conversations.

CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX IF NOT EXISTS idx_messages_conversation_created_desc
ON messages(conversation_id, created_at DESC);

-- The composite index keeps the conversation_id prefix usable while also matching
-- the recent-message ORDER BY path, so the older single-column index is redundant.
DROP INDEX IF EXISTS idx_messages_conversation;

CREATE INDEX IF NOT EXISTS idx_messages_content_trgm_lower
ON messages USING GIN (lower(content) gin_trgm_ops);
