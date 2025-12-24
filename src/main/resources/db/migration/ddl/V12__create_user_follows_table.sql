-- V12: Create user_follows table
-- Social feature: user following relationships

CREATE TABLE user_follows (
    follower_id UUID REFERENCES users(id) ON DELETE CASCADE,
    followee_id UUID REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, followee_id)
);

-- Indexes for query performance
CREATE INDEX idx_follows_follower ON user_follows(follower_id);
CREATE INDEX idx_follows_followee ON user_follows(followee_id);

-- Add comments for documentation
COMMENT ON TABLE user_follows IS 'User following relationships for social features';
COMMENT ON COLUMN user_follows.follower_id IS 'User who is following';
COMMENT ON COLUMN user_follows.followee_id IS 'User being followed';
