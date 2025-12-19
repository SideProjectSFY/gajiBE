-- V28: Add CHECK constraint to prevent self-follow in user_follows table
-- Story 6.4: Follow/Follower System Backend

-- Add CHECK constraint to prevent self-follow
ALTER TABLE user_follows
ADD CONSTRAINT check_no_self_follow CHECK (follower_id <> followee_id);

-- Add comment
COMMENT ON CONSTRAINT check_no_self_follow ON user_follows IS 'Prevents users from following themselves';
