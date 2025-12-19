-- V11: Create conversation_message_links table
-- Join table linking conversations to messages (enables message reuse across forks)

CREATE TABLE conversation_message_links (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    sequence_order INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(conversation_id, sequence_order),
    UNIQUE(conversation_id, message_id)
);

-- Indexes for query performance
CREATE INDEX idx_conv_msg_links_conversation ON conversation_message_links(conversation_id, sequence_order);
CREATE INDEX idx_conv_msg_links_message ON conversation_message_links(message_id);

-- Add comments for documentation
COMMENT ON TABLE conversation_message_links IS 'Links messages to conversations with sequence ordering';
COMMENT ON COLUMN conversation_message_links.sequence_order IS 'Message order within conversation (1, 2, 3, ...)';
