CREATE TABLE rag_chat_turns (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,
    user_message_id UUID REFERENCES messages(id) ON DELETE SET NULL,
    assistant_message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    novel_id UUID REFERENCES novels(id) ON DELETE SET NULL,
    provider VARCHAR(50),
    model VARCHAR(100),
    mode VARCHAR(32),
    grounding_status VARCHAR(50),
    fallback_used BOOLEAN NOT NULL DEFAULT FALSE,
    fallback_reason VARCHAR(120),
    ranking_policy VARCHAR(120),
    query_source VARCHAR(32),
    passage_count INTEGER NOT NULL DEFAULT 0,
    citation_count INTEGER NOT NULL DEFAULT 0,
    token_usage INTEGER,
    total_ms DOUBLE PRECISION,
    embedding_ms DOUBLE PRECISION,
    vector_search_ms DOUBLE PRECISION,
    bm25_search_ms DOUBLE PRECISION,
    fusion_ms DOUBLE PRECISION,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_rag_chat_turn_assistant_message UNIQUE (assistant_message_id)
);

CREATE INDEX idx_rag_chat_turn_conversation_created
    ON rag_chat_turns(conversation_id, created_at DESC);
CREATE INDEX idx_rag_chat_turn_grounding
    ON rag_chat_turns(grounding_status, fallback_used);
CREATE INDEX idx_rag_chat_turn_novel
    ON rag_chat_turns(novel_id);

CREATE TABLE rag_chat_turn_citations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    rag_chat_turn_id UUID NOT NULL REFERENCES rag_chat_turns(id) ON DELETE CASCADE,
    passage_id VARCHAR(500) NOT NULL,
    final_rank INTEGER,
    vector_rank INTEGER,
    bm25_rank INTEGER,
    manifest_id VARCHAR(120),
    chapter VARCHAR(80),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_rag_chat_turn_citation UNIQUE (rag_chat_turn_id, passage_id)
);

CREATE INDEX idx_rag_chat_turn_citation_turn
    ON rag_chat_turn_citations(rag_chat_turn_id, final_rank);
CREATE INDEX idx_rag_chat_turn_citation_passage
    ON rag_chat_turn_citations(passage_id);
