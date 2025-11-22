-- V9: Create conversations table
-- Manages AI character conversations within scenarios

CREATE TABLE conversations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    scenario_id UUID REFERENCES root_user_scenarios(id) ON DELETE SET NULL,
    character_vectordb_id UUID NOT NULL,   -- Reference to VectorDB characters collection
    parent_conversation_id UUID REFERENCES conversations(id) ON DELETE SET NULL,
    title VARCHAR(200),
    is_root BOOLEAN DEFAULT TRUE,          -- TRUE for root conversations, FALSE for forked ones
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- ROOT-only forking: if this has a parent, parent must be root (is_root = true)
    -- This will be enforced at application level and via trigger
    CHECK ((parent_conversation_id IS NULL AND is_root = TRUE) OR 
           (parent_conversation_id IS NOT NULL AND is_root = FALSE))
);

-- Indexes for query performance
CREATE INDEX idx_conversations_user ON conversations(user_id);
CREATE INDEX idx_conversations_scenario ON conversations(scenario_id);
CREATE INDEX idx_conversations_character ON conversations(character_vectordb_id);
CREATE INDEX idx_conversations_parent ON conversations(parent_conversation_id);
CREATE INDEX idx_conversations_created ON conversations(created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE conversations IS 'AI character conversations with ROOT-only forking (max depth 1)';
COMMENT ON COLUMN conversations.character_vectordb_id IS 'VectorDB character ID being conversed with';
COMMENT ON COLUMN conversations.parent_conversation_id IS 'Parent conversation if forked (ROOT only, max depth 1)';
COMMENT ON COLUMN conversations.is_root IS 'TRUE for root conversations, FALSE for forked (child) conversations';

-- Create trigger function to enforce ROOT-only forking
CREATE OR REPLACE FUNCTION enforce_root_only_forking()
RETURNS TRIGGER AS $$
BEGIN
    -- If this conversation has a parent, ensure parent is a root conversation
    IF NEW.parent_conversation_id IS NOT NULL THEN
        IF EXISTS (
            SELECT 1 FROM conversations 
            WHERE id = NEW.parent_conversation_id 
            AND is_root = FALSE
        ) THEN
            RAISE EXCEPTION 'Cannot fork from a forked conversation. Only root conversations can be forked (max depth 1).';
        END IF;
        -- Ensure this conversation is marked as not root
        NEW.is_root := FALSE;
    ELSE
        -- No parent means this is a root conversation
        NEW.is_root := TRUE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER check_root_only_forking
    BEFORE INSERT OR UPDATE ON conversations
    FOR EACH ROW
    EXECUTE FUNCTION enforce_root_only_forking();
