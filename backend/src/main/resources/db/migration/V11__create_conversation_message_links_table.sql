-- V11: Create conversation_message_links table
-- Many-to-many relationship between conversations and messages (enables message reuse across forks)

CREATE TABLE conversation_message_links (
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    sequence_number INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (conversation_id, message_id),
    UNIQUE (conversation_id, sequence_number)
);

-- Indexes for query performance
CREATE INDEX idx_conv_msg_links_conversation ON conversation_message_links(conversation_id, sequence_number);
CREATE INDEX idx_conv_msg_links_message ON conversation_message_links(message_id);

-- Add comments for documentation
COMMENT ON TABLE conversation_message_links IS 'Links messages to conversations with sequence ordering';
COMMENT ON COLUMN conversation_message_links.sequence_number IS 'Message order within conversation (1, 2, 3, ...)';
