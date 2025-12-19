-- V27: Add has_been_forked column to conversations table
-- Story 4.4: Conversation Forking Backend - Prevent duplicate forks

-- Add has_been_forked column (default FALSE)
ALTER TABLE conversations
ADD COLUMN has_been_forked BOOLEAN DEFAULT FALSE;

-- Add index for performance (will be checked frequently during fork operations)
CREATE INDEX idx_conversations_has_been_forked ON conversations(has_been_forked);

-- Add comment for documentation
COMMENT ON COLUMN conversations.has_been_forked IS 'TRUE if this ROOT conversation has been forked (prevents duplicate forks)';

-- Add check constraint: Only ROOT conversations can have has_been_forked = TRUE
-- Forked (child) conversations should always have has_been_forked = FALSE
ALTER TABLE conversations
ADD CONSTRAINT check_forked_only_for_roots
CHECK (
    (is_root = TRUE) OR 
    (is_root = FALSE AND has_been_forked = FALSE)
);

-- Update existing data: Set has_been_forked = TRUE for any ROOT conversation that already has children
UPDATE conversations
SET has_been_forked = TRUE
WHERE is_root = TRUE
AND id IN (
    SELECT DISTINCT parent_conversation_id
    FROM conversations
    WHERE parent_conversation_id IS NOT NULL
);
