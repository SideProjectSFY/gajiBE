-- V15: Seed development data (only applied with spring.profiles.active=dev)
-- Sample users, novels (metadata), and scenarios for testing

-- Sample users (using BCrypt hashed password 'password123')
INSERT INTO users (email, password_hash, username, bio) VALUES
  ('dev@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'dev_user', 'Development test user'),
  ('admin@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'admin_user', 'Admin test user'),
  ('alice@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'alice_wonder', 'Loves exploring "What If?" scenarios'),
  ('bob@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'bob_reader', 'Classic literature enthusiast'),
  ('charlie@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'charlie_chat', 'AI conversation tester'),
  ('diana@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'diana_creator', 'Scenario creator'),
  ('eve@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'eve_explorer', 'Timeline explorer'),
  ('frank@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'frank_social', 'Social feature tester'),
  ('grace@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'grace_novelist', 'Novel curator'),
  ('henry@example.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5v5n3o8a8xXfK', 'henry_fork', 'Fork master');

-- Sample novels removed - novels are added in V22 and V39 with proper metadata
-- Base scenarios and conversations are added in V41 and V42 with proper character data from V46

-- Sample social features
-- User follows
INSERT INTO user_follows (follower_id, followee_id)
SELECT u1.id, u2.id
FROM users u1
CROSS JOIN users u2
WHERE u1.username = 'bob_reader' AND u2.username = 'alice_wonder'
UNION ALL
SELECT u1.id, u2.id
FROM users u1
CROSS JOIN users u2
WHERE u1.username = 'charlie_chat' AND u2.username = 'alice_wonder'
UNION ALL
SELECT u1.id, u2.id
FROM users u1
CROSS JOIN users u2
WHERE u1.username = 'diana_creator' AND u2.username = 'grace_novelist';

-- Social features data added in V41

-- Add comments for documentation
COMMENT ON TABLE users IS 'Dev seed data: 10 test users, password: password123';
