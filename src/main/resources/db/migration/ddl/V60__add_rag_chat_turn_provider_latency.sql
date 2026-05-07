ALTER TABLE rag_chat_turns
ADD COLUMN provider_elapsed_ms DOUBLE PRECISION;

CREATE INDEX idx_rag_chat_turn_provider_latency
    ON rag_chat_turns(provider_elapsed_ms);
