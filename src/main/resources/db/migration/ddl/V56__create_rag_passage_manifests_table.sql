CREATE TABLE rag_passage_manifests (
    passage_manifest_id VARCHAR(80) PRIMARY KEY,
    novel_id UUID NOT NULL REFERENCES novels(id) ON DELETE CASCADE,
    source_novel_id VARCHAR(120) NOT NULL,
    chunker_version VARCHAR(80) NOT NULL,
    source_text_hash VARCHAR(64) NOT NULL,
    embedding_model_id VARCHAR(120) NOT NULL,
    embedding_config_hash VARCHAR(64) NOT NULL,
    vector_collection_name VARCHAR(120) NOT NULL,
    elasticsearch_index_name VARCHAR(120) NOT NULL,
    expected_passage_count INTEGER NOT NULL DEFAULT 0,
    vector_passage_count INTEGER NOT NULL DEFAULT 0,
    elasticsearch_passage_count INTEGER NOT NULL DEFAULT 0,
    vector_status VARCHAR(40) NOT NULL DEFAULT 'pending',
    elasticsearch_status VARCHAR(40) NOT NULL DEFAULT 'pending',
    reconciliation_status VARCHAR(40) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    indexed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_rag_manifest_config UNIQUE (novel_id, source_text_hash, embedding_config_hash)
);

CREATE INDEX idx_rag_manifest_novel_id ON rag_passage_manifests(novel_id);
CREATE INDEX idx_rag_manifest_source_novel_id ON rag_passage_manifests(source_novel_id);
CREATE INDEX idx_rag_manifest_readiness ON rag_passage_manifests(vector_status, elasticsearch_status, reconciliation_status);
