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

-- Sample novels (metadata only - content stored in VectorDB)
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count) VALUES
  ('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 'novel_pride_and_prejudice_uuid', 'completed', 523, 42),
  ('Great Expectations', 'Charles Dickens', 1861, 'Drama', 'novel_great_expectations_uuid', 'completed', 687, 58),
  ('The Adventures of Tom Sawyer', 'Mark Twain', 1876, 'Adventure', 'novel_tom_sawyer_uuid', 'completed', 412, 35);

-- Sample base scenarios (with VectorDB passage references)
-- Note: In production, these would be created by the FastAPI service after novel ingestion
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT 
  id,
  'pride_and_prejudice',
  'Opening Scene',
  'The beginning of the story where main characters are introduced',
  ARRAY['11111111-1111-1111-1111-111111111111'::UUID, '22222222-2222-2222-2222-222222222222'::UUID],
  ARRAY['aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::UUID, 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::UUID]
FROM novels
WHERE title = 'Pride and Prejudice';

-- Sample root user scenario
INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
SELECT 
  u.id,
  bs.id,
  'What if Elizabeth was wealthy?',
  'Exploring how the story changes if Elizabeth Bennet comes from wealth',
  'What if Elizabeth Bennet inherited a fortune from a distant relative?',
  'CHARACTER_CHANGE',
  false,
  2
FROM users u
CROSS JOIN base_scenarios bs
WHERE u.username = 'alice_wonder'
AND bs.title = 'Opening Scene'
LIMIT 1;

-- Sample character change for the scenario
INSERT INTO scenario_character_changes (root_scenario_id, character_vectordb_id, attribute, original_value, new_value, reasoning)
SELECT 
  rus.id,
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::UUID,
  'social_status',
  'Genteel but poor',
  'Wealthy heiress',
  'Elizabeth inherits fortune, changing power dynamics with Darcy'
FROM root_user_scenarios rus
WHERE rus.title = 'What if Elizabeth was wealthy?';

-- Sample conversation
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title)
SELECT 
  u.id,
  rus.id,
  'root_user',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::UUID,
  'Chat with Elizabeth about her newfound wealth'
FROM users u
CROSS JOIN root_user_scenarios rus
WHERE u.username = 'charlie_chat'
AND rus.title = 'What if Elizabeth was wealthy?'
LIMIT 1;

-- Sample messages (linked directly to conversation via conversation_id per V10 schema)
WITH conv AS (
  SELECT id FROM conversations WHERE title = 'Chat with Elizabeth about her newfound wealth' LIMIT 1
)
INSERT INTO messages (conversation_id, role, content)
SELECT 
  conv.id,
  msg.role,
  msg.content
FROM conv
CROSS JOIN (VALUES
  ('user', 'Hello Elizabeth! How does it feel to suddenly be wealthy?'),
  ('assistant', 'It is quite overwhelming, I must confess. The weight of such fortune brings both opportunity and responsibility.'),
  ('user', 'Does this change how you view Mr. Darcy?'),
  ('assistant', 'Indeed, it does alter the dynamic between us. I find myself less concerned with his wealth and more focused on his character.')
) AS msg(role, content);

-- Link messages to conversation (for conversation_message_links table per ERD design)
INSERT INTO conversation_message_links (conversation_id, message_id, sequence_order)
SELECT 
  m.conversation_id,
  m.id,
  ROW_NUMBER() OVER (ORDER BY m.created_at)
FROM messages m
JOIN conversations c ON m.conversation_id = c.id
WHERE c.title = 'Chat with Elizabeth about her newfound wealth';

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

-- Conversation likes
INSERT INTO conversation_likes (user_id, conversation_id)
SELECT u.id, c.id
FROM users u
CROSS JOIN conversations c
WHERE u.username IN ('bob_reader', 'diana_creator', 'eve_explorer')
AND c.title = 'Chat with Elizabeth about her newfound wealth';

-- Conversation memo
INSERT INTO conversation_memos (user_id, conversation_id, content)
SELECT u.id, c.id, 'Great exploration of wealth dynamics! The character''s response feels authentic.'
FROM users u
CROSS JOIN conversations c
WHERE u.username = 'frank_social'
AND c.title = 'Chat with Elizabeth about her newfound wealth';

-- Add comments for documentation
COMMENT ON TABLE users IS 'Dev seed data: 10 test users, password: password123';
COMMENT ON TABLE novels IS 'Dev seed data: 3 sample novels with VectorDB references';
