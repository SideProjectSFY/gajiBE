-- V10: Create messages table
-- Stores individual messages within conversations

CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_type VARCHAR(20) NOT NULL,  -- 'user' or 'ai'
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (sender_type IN ('user', 'ai'))
);

-- Indexes for query performance
CREATE INDEX idx_messages_created ON messages(created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE messages IS 'Individual messages in conversations (sender-agnostic)';
COMMENT ON COLUMN messages.sender_type IS 'Message sender: user or ai';
COMMENT ON COLUMN messages.content IS 'Message text content';
