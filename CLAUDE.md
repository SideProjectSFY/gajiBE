# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Gaji backend.

## Current Backend Direction

The backend is the canonical AI/RAG runtime. Python sidecars are not part of the active runtime path.

- Spring Boot owns authenticated chat APIs and conversation persistence.
- Gemini generation and embedding requests are made from Spring Boot.
- PostgreSQL + pgvector stores RAG passages and embeddings.
- Elasticsearch provides BM25 retrieval and conversation message search.
- Redis is used only for limited polling/status support.

## Boundaries

- Keep chat, retrieval, and provider orchestration inside Spring Boot.
- Keep RAG storage on PostgreSQL/pgvector and Elasticsearch.
- Do not restore direct sidecar routing or broker-token handoffs.

## Useful Commands

```bash
./gradlew :apps:api-app:compileJava :apps:api-app:compileTestJava
./gradlew :apps:api-app:test
./gradlew :apps:api-app:bootRun --args='--spring.profiles.active=dev'
```

## AI/RAG Implementation Notes

- `AiChatProxyService` is kept as a compatibility facade, but it delegates locally.
- `AiChatCompletionService` performs Gemini generation, pgvector retrieval, Elasticsearch retrieval, and RAG metadata shaping.
- Scenario validation is local/basic; it should not call a remote runtime.
- Legacy async message submission should not enqueue work to a external worker. Use `/chat-completion`.
