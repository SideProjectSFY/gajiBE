-- V14: Create conversation_memos table
-- Users can add personal memos to conversations

CREATE TABLE conversation_memos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    content TEXT NOT NULL CHECK (length(content) <= 2000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, conversation_id)
);

-- Indexes for query performance
CREATE INDEX idx_memos_user ON conversation_memos(user_id);
CREATE INDEX idx_memos_conversation ON conversation_memos(conversation_id);

-- Add comments for documentation
COMMENT ON TABLE conversation_memos IS 'Personal user memos on conversations';
COMMENT ON COLUMN conversation_memos.content IS 'Memo text, max 2000 characters';
COMMENT ON COLUMN conversation_memos.user_id IS 'User who created the memo';
COMMENT ON COLUMN conversation_memos.conversation_id IS 'Conversation the memo is about';
