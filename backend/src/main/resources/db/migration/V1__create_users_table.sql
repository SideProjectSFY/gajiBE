-- V1: Create users table for authentication and user management
-- PostgreSQL extensions for UUID generation and full-text search

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Set timezone to UTC
SET TIMEZONE='UTC';

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL CHECK (username ~* '^[a-zA-Z0-9_]{3,50}$'),
    bio TEXT CHECK (length(bio) <= 500),
    avatar_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance optimization
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);

-- Add comments for documentation
COMMENT ON TABLE users IS 'User accounts for authentication and profile management';
COMMENT ON COLUMN users.username IS 'Unique username, 3-50 alphanumeric characters and underscores only';
COMMENT ON COLUMN users.bio IS 'User biography, max 500 characters';
