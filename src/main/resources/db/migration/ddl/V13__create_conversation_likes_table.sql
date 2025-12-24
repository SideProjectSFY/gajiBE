-- V13: Create conversation_likes table
-- Social feature: users can like conversations

CREATE TABLE conversation_likes (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, conversation_id)
);

-- Indexes for query performance
CREATE INDEX idx_likes_user ON conversation_likes(user_id);
CREATE INDEX idx_likes_conversation ON conversation_likes(conversation_id);
CREATE INDEX idx_conversation_likes_user_created ON conversation_likes(user_id, created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE conversation_likes IS 'User likes on conversations';
COMMENT ON COLUMN conversation_likes.user_id IS 'User who liked the conversation';
COMMENT ON COLUMN conversation_likes.conversation_id IS 'Conversation that was liked';

-- Create trigger to update like_count automatically
CREATE OR REPLACE FUNCTION update_conversation_like_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE conversations
        SET like_count = like_count + 1
        WHERE id = NEW.conversation_id;
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE conversations
        SET like_count = GREATEST(like_count - 1, 0)
        WHERE id = OLD.conversation_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_conversation_like_count
AFTER INSERT OR DELETE ON conversation_likes
FOR EACH ROW
EXECUTE FUNCTION update_conversation_like_count();
