-- Ensure chat history ordering is stable for messages created before JPA auditing
-- populated created_at consistently.
UPDATE messages
SET created_at = COALESCE(created_at, CURRENT_TIMESTAMP)
WHERE created_at IS NULL;

ALTER TABLE messages
ALTER COLUMN created_at SET NOT NULL;
