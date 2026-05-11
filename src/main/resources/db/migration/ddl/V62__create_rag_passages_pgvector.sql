CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS rag_passages (
    passage_id VARCHAR(500) PRIMARY KEY,
    novel_id UUID NOT NULL,
    source_novel_id VARCHAR(120) NOT NULL,
    passage_manifest_id VARCHAR(80) NOT NULL,
    chunker_version VARCHAR(80) NOT NULL,
    embedding_model_id VARCHAR(120) NOT NULL,
    embedding_config_hash VARCHAR(64) NOT NULL,
    chapter VARCHAR(80),
    character_names TEXT,
    ordinal INTEGER,
    chunk_index INTEGER,
    word_count INTEGER,
    normalized_text_hash VARCHAR(64),
    start_word INTEGER,
    end_word INTEGER,
    text TEXT NOT NULL,
    embedding vector(768) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_rag_passages_novel_manifest
    ON rag_passages(novel_id, passage_manifest_id);

CREATE INDEX IF NOT EXISTS idx_rag_passages_source_novel
    ON rag_passages(source_novel_id);

DO $$
DECLARE
    vector_version TEXT;
    version_parts TEXT[];
    major_version INTEGER;
    minor_version INTEGER;
BEGIN
    SELECT extversion INTO vector_version
    FROM pg_extension
    WHERE extname = 'vector';

    version_parts := string_to_array(COALESCE(vector_version, '0.0.0'), '.');
    major_version := COALESCE(NULLIF(regexp_replace(COALESCE(version_parts[1], '0'), '\D.*$', ''), '')::INTEGER, 0);
    minor_version := COALESCE(NULLIF(regexp_replace(COALESCE(version_parts[2], '0'), '\D.*$', ''), '')::INTEGER, 0);

    IF major_version > 0 OR (major_version = 0 AND minor_version >= 5) THEN
        EXECUTE 'CREATE INDEX IF NOT EXISTS idx_rag_passages_embedding_hnsw
            ON rag_passages USING hnsw (embedding vector_cosine_ops)';
    ELSE
        RAISE NOTICE 'Skipping HNSW index for pgvector version %. HNSW requires pgvector >= 0.5.0.', vector_version;
    END IF;
END $$;
