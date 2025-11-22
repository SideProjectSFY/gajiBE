-- V13: Create conversation_likes table
-- Social feature: users can like conversations

CREATE TABLE conversation_likes (
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, conversation_id)
);

-- Indexes for query performance
CREATE INDEX idx_likes_user ON conversation_likes(user_id);
CREATE INDEX idx_likes_conversation ON conversation_likes(conversation_id);

-- Add comments for documentation
COMMENT ON TABLE conversation_likes IS 'User likes on conversations';
COMMENT ON COLUMN conversation_likes.user_id IS 'User who liked the conversation';
COMMENT ON COLUMN conversation_likes.conversation_id IS 'Conversation that was liked';
