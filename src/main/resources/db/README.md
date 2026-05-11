# Database Setup Guide

## Overview

This directory contains Flyway migration scripts for the Gaji PostgreSQL database. The current RAG storage direction is:

- **PostgreSQL**: Domain metadata, conversation data, RAG passage text, and `pgvector` embeddings
- **Elasticsearch**: BM25 passage index, citation/source lookup index, and conversation-message search index
- **Redis**: Cache and short-lived async task state

New RAG data should use PostgreSQL `pgvector` and Elasticsearch.

## Architecture

### Database Tables

#### Core Domain Tables

1. `users` - User authentication and profiles
2. `novels` - Novel metadata
3. `base_scenarios` - Base scenario metadata and legacy passage references

#### Scenario Tables (5)

4. `root_user_scenarios` - Root-level user scenarios (max depth 1)
5. `leaf_user_scenarios` - Child scenarios forked from root
6. `scenario_character_changes` - Character modifications
7. `scenario_event_alterations` - Plot/event changes
8. `scenario_setting_modifications` - Location/setting changes

#### Conversation Tables (3)

9. `conversations` - AI character conversations (ROOT-only forking)
10. `messages` - Individual messages (reusable across forks)
11. `conversation_message_links` - Message ordering in conversations

#### Social Features (3)

12. `user_follows` - User following relationships
13. `conversation_likes` - Conversation likes
14. `conversation_memos` - Personal user memos

### RAG Storage Design

**PostgreSQL Stores:**

- User data and authentication
- Scenario metadata and relationships
- Conversation metadata and structure
- Social features (follows, likes, memos)
- RAG passage manifests in `rag_passage_manifests`
- RAG passage text and embeddings in `rag_passages`

**pgvector Stores:**

- `rag_passages.embedding vector(768)`
- HNSW cosine index when the installed pgvector version supports it
- Passage metadata used for filtering by novel, manifest, chapter, and source

**Elasticsearch Stores:**

- Passage documents for BM25 retrieval
- Exact source lookup documents keyed by canonical passage ID
- Conversation-message documents for faster message search

**Legacy References:**

- Columns such as `vectordb_collection_id`, `vectordb_passage_ids`, and `character_vectordb_id` still exist in older migrations.
- Treat those names as compatibility fields unless a new migration explicitly replaces them.

## Quick Start

### 1. Start Local Data Services

```bash
# From project root
docker compose -f docker-compose.dev.yml up -d postgres elasticsearch redis

# Verify database is running
docker compose -f docker-compose.dev.yml ps

# Check logs
docker compose -f docker-compose.dev.yml logs -f postgres
```

### 2. Verify Database Connection

```bash
# Connect to database
docker exec -it gaji-postgres psql -U gaji_user -d gaji_db

# Inside psql, verify extensions. `vector` should be present for pgvector.
\dx

# List tables
\dt

# Exit
\q
```

### 3. Run Spring Boot Application

Flyway migrations will automatically run on startup:

```bash
cd gajiBE
./gradlew :apps:api-app:bootRun --args='--spring.profiles.active=dev'
```

### 4. Verify Migrations

```bash
# Check migration history
docker exec -it gaji-postgres psql -U gaji_user -d gaji_db -c "SELECT * FROM flyway_schema_history ORDER BY installed_rank;"

# Verify tables were created
docker exec -it gaji-postgres psql -U gaji_user -d gaji_db -c "\dt"

# Count records in seed data (dev profile only)
docker exec -it gaji-postgres psql -U gaji_user -d gaji_db -c "SELECT COUNT(*) FROM users;"
```

## Migration Management

### Migration Files

All migrations are in: `gajiBE/src/main/resources/db/migration/ddl/`

Naming convention: `V{version}__{description}.sql`

Example:

- `V1__create_users_table.sql`
- `V2__create_novels_table.sql`

### Migration Order

1. V1: Extensions and users table
2. V2: Novels table (metadata only)
3. V3: Base scenarios table
4. V4-5: Root and leaf user scenarios
5. V6-8: Scenario type-specific tables
6. V9-11: Conversation tables
7. V12-14: Social features
8. V15: Development seed data (dev profile only)
9. V56+: RAG passage manifests, RAG observability, and `rag_passages` pgvector storage

### Adding New Migrations

1. Create new file: `V{next_version}__{description}.sql`
2. Write SQL migration
3. Test locally with dev profile
4. Commit to version control
5. Deploy - Flyway runs automatically

### Rollback Strategy

Flyway does NOT support automatic rollbacks. For rollbacks:

1. Create a new "undo" migration (e.g., `V16__undo_feature_x.sql`)
2. Or manually revert changes in database
3. Or restore from backup

## Database Access

### Connection Details

**Development:**

- Host: `localhost`
- Port: `5432`
- Database: `gaji_db`
- User: `gaji_user`
- Password: `gaji_password`

**Spring Boot application.yml:**

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/gaji_db
    username: gaji_user
    password: gaji_password
```

### Security Best Practices

**DO NOT:**

- ❌ Commit passwords to version control
- ❌ Use default passwords in production
- ❌ Expose database port publicly

**DO:**

- ✅ Use environment variables for credentials
- ✅ Rotate passwords regularly
- ✅ Use SSL connections in production
- ✅ Limit database user privileges

## Development Seed Data

When running with `spring.profiles.active=dev`, migration V15 seeds the database with:

- **10 test users** (password: `password123`)

  - dev@example.com / dev_user
  - admin@example.com / admin_user
  - alice@example.com / alice_wonder
  - bob@example.com / bob_reader
  - charlie@example.com / charlie_chat
  - diana@example.com / diana_creator
  - eve@example.com / eve_explorer
  - frank@example.com / frank_social
  - grace@example.com / grace_novelist
  - henry@example.com / henry_fork

- **3 sample novels** (metadata only):

  - Pride and Prejudice (Jane Austen, 1813)
  - Great Expectations (Charles Dickens, 1861)
  - The Adventures of Tom Sawyer (Mark Twain, 1876)

- **1 sample scenario**: "What if Elizabeth was wealthy?"
- **1 sample conversation** with messages
- **Social features**: Follows, likes, and memos

## Troubleshooting

### Issue: Migrations don't run

**Solution:**

```bash
# Check Flyway configuration in application.yml
# Verify spring.flyway.enabled=true

# Check database connection
docker exec -it gaji-postgres psql -U gaji_user -d gaji_db -c "SELECT version();"
```

### Issue: Migration checksum mismatch

**Solution:**

```bash
# DO NOT modify existing migrations after they've been applied
# Create a new migration instead

# If absolutely necessary, repair Flyway
# Connect to database and run:
# DELETE FROM flyway_schema_history WHERE version = 'X';
```

### Issue: Connection refused

**Solution:**

```bash
# Ensure PostgreSQL container is running
docker-compose ps

# Check logs for errors
docker-compose logs postgres

# Restart container
docker-compose restart postgres
```

### Issue: Seed data not loaded

**Solution:**

```bash
# Verify dev profile is active
# Check application.yml: spring.profiles.active=dev

# V15 migration only runs with dev profile
```

## Performance Optimization

### Connection Pooling (HikariCP)

Configured in `application.yml`:

```yaml
spring:
  datasource:
    hikari:
      maximum-pool-size: 20 # Production
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
```

### Indexes

All foreign keys have B-tree indexes for JOIN performance:

- User ID columns
- Novel ID columns
- Scenario ID columns
- Conversation ID columns

Search columns also indexed:

- novels.title, novels.author
- users.email, users.username
- base_scenarios.title
- rag_passages.embedding through HNSW cosine index when pgvector supports it
- rag_passages.novel_id/source_novel_id for retrieval filters

### Query Optimization Tips

1. Use `EXPLAIN ANALYZE` to check query plans
2. Verify indexes are being used
3. Avoid SELECT \* - select only needed columns
4. Use JOINs efficiently (indexed FK columns)
5. Paginate large result sets

## Monitoring

### Health Check

Spring Boot Actuator provides database health:

```bash
curl http://localhost:8080/actuator/health
```

### Database Statistics

```sql
-- Table sizes
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Row counts
SELECT
  schemaname,
  tablename,
  n_live_tup AS row_count
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

-- Index usage
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan AS index_scans
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;
```

## Backup and Recovery

### Backup

```bash
# Full database backup
docker exec gaji-postgres pg_dump -U gaji_user gaji_db > backup_$(date +%Y%m%d).sql

# Schema only
docker exec gaji-postgres pg_dump -U gaji_user -s gaji_db > schema_backup.sql

# Data only
docker exec gaji-postgres pg_dump -U gaji_user -a gaji_db > data_backup.sql
```

### Restore

```bash
# Restore full backup
cat backup_20250122.sql | docker exec -i gaji-postgres psql -U gaji_user -d gaji_db

# Or drop and recreate
docker exec gaji-postgres dropdb -U gaji_user gaji_db
docker exec gaji-postgres createdb -U gaji_user gaji_db
cat backup_20250122.sql | docker exec -i gaji-postgres psql -U gaji_user -d gaji_db
```

## Production Considerations

### Environment Variables

```bash
# Production example
export DB_URL="jdbc:postgresql://prod-db-host:5432/gaji_db"
export DB_USERNAME="gaji_prod_user"
export DB_PASSWORD="secure_random_password_here"
```

### SSL Connection

Update `application-prod.yml`:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://prod-host:5432/gaji_db?ssl=true&sslmode=require
```

### Connection Pool Sizing

**Formula:** `connections = ((core_count × 2) + effective_spindle_count)`

For 4-core server: `(4 × 2) + 1 = 9` minimum
Set `maximum-pool-size: 20` for headroom

## References

- [Flyway Documentation](https://flywaydb.org/documentation/)
- [PostgreSQL 15 Documentation](https://www.postgresql.org/docs/15/)
- [Spring Boot Data Access](https://spring.io/guides/gs/accessing-data-jpa/)
- [HikariCP Configuration](https://github.com/brettwooldridge/HikariCP#configuration-knobs-baby)
