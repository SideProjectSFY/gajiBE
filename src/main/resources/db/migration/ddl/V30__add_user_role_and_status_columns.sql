-- V30: Add role, is_active, and last_login_at columns to users table
-- Priority 2 (High): Data integrity enhancement

-- Add role column with default USER
ALTER TABLE users 
ADD COLUMN role VARCHAR(20) DEFAULT 'USER' NOT NULL 
CHECK (role IN ('USER', 'ADMIN', 'MODERATOR'));

-- Add is_active column with default true
ALTER TABLE users 
ADD COLUMN is_active BOOLEAN DEFAULT true NOT NULL;

-- Add last_login_at column
ALTER TABLE users 
ADD COLUMN last_login_at TIMESTAMP;

-- Create index for role-based queries
CREATE INDEX idx_users_role ON users(role);

-- Create index for active user queries
CREATE INDEX idx_users_is_active ON users(is_active);

-- Add comments for documentation
COMMENT ON COLUMN users.role IS 'User role: USER (default), ADMIN, or MODERATOR';
COMMENT ON COLUMN users.is_active IS 'Whether the user account is active (not suspended/deleted)';
COMMENT ON COLUMN users.last_login_at IS 'Timestamp of the user''s last login';
