-- V41: Add Profile Mock Data
-- Populates data to verify Profile Page functionality (Scenarios, Likes, Follows)

-- 1. Create Scenarios for Test Users
-- Jane Austen (User 1) creates a scenario for Pride and Prejudice
INSERT INTO root_user_scenarios (
    id, user_id, novel_id, title, description, 
    what_if_question, scenario_type, is_private, fork_count, 
    character_changes, event_alterations, setting_modifications,
    created_at, updated_at
)
SELECT 
    '660e8400-e29b-41d4-a716-446655440001', -- Specific ID
    '550e8400-e29b-41d4-a716-446655440001', -- Jane Austen
    id,
    'Elizabeth accepts Darcy first proposal',
    'What if Elizabeth had accepted Mr. Darcy''s first proposal at Hunsford Parsonage?',
    'What if Elizabeth accepted Darcy immediately?',
    'EVENT_ALTERATION',
    false,
    5,
    null,
    'Elizabeth is overwhelmed by the offer and accepts despite her reservations.',
    null,
    NOW() - INTERVAL '5 days',
    NOW() - INTERVAL '5 days'
FROM novels WHERE title = 'Pride and Prejudice' LIMIT 1;

-- Sherlock Holmes (User 2) creates a scenario for Sherlock Holmes
INSERT INTO root_user_scenarios (
    id, user_id, novel_id, title, description, 
    what_if_question, scenario_type, is_private, fork_count,
    character_changes, event_alterations, setting_modifications,
    created_at, updated_at
)
SELECT 
    '660e8400-e29b-41d4-a716-446655440002', -- Specific ID
    '550e8400-e29b-41d4-a716-446655440002', -- Sherlock Holmes
    id,
    'Moriarty wins at Reichenbach',
    'A dark timeline where Holmes fails to defeat Moriarty at the falls.',
    'What if Moriarty survived and Holmes perished?',
    'EVENT_ALTERATION',
    false,
    12,
    null,
    'Holmes slips on the wet rocks and falls alone.',
    null,
    NOW() - INTERVAL '3 days',
    NOW() - INTERVAL '3 days'
FROM novels WHERE title = 'The Adventures of Sherlock Holmes' LIMIT 1;

-- Fantasy Lover (User 3) creates a scenario for The Hobbit
INSERT INTO root_user_scenarios (
    id, user_id, novel_id, title, description, 
    what_if_question, scenario_type, is_private, fork_count,
    character_changes, event_alterations, setting_modifications,
    created_at, updated_at
)
SELECT 
    '660e8400-e29b-41d4-a716-446655440003', -- Specific ID
    '550e8400-e29b-41d4-a716-446655440003', -- Fantasy Lover
    id,
    'Bilbo stays home',
    'Bilbo refuses the adventure completely and stays in the Shire.',
    'What if Bilbo never left Bag End?',
    'CHARACTER_CHANGE',
    false,
    0,
    'Bilbo is more stubborn and less adventurous.',
    null,
    null,
    NOW() - INTERVAL '1 day',
    NOW() - INTERVAL '1 day'
FROM novels WHERE title = 'The Hobbit' LIMIT 1;


-- 2. Create User Follows
-- Sherlock follows Jane
INSERT INTO user_follows (follower_id, followee_id, created_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440002', -- Sherlock
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    NOW() - INTERVAL '10 days'
);

-- Fantasy Lover follows Jane
INSERT INTO user_follows (follower_id, followee_id, created_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440003', -- Fantasy Lover
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    NOW() - INTERVAL '8 days'
);

-- Jane follows Sherlock (Mutual)
INSERT INTO user_follows (follower_id, followee_id, created_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    '550e8400-e29b-41d4-a716-446655440002', -- Sherlock
    NOW() - INTERVAL '9 days'
);


-- 3. Create Scenario Likes
-- Sherlock likes Jane's scenario
INSERT INTO scenario_likes (user_id, scenario_id, scenario_type, created_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440002', -- Sherlock
    '660e8400-e29b-41d4-a716-446655440001', -- Jane's Scenario
    'root_user',
    NOW() - INTERVAL '4 days'
);

-- Jane likes Sherlock's scenario
INSERT INTO scenario_likes (user_id, scenario_id, scenario_type, created_at)
VALUES (
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    '660e8400-e29b-41d4-a716-446655440002', -- Sherlock's Scenario
    'root_user',
    NOW() - INTERVAL '2 days'
);


-- 4. Create Book Likes
-- Jane likes Pride and Prejudice
INSERT INTO book_likes (user_id, book_id, created_at)
SELECT 
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    id,
    NOW() - INTERVAL '20 days'
FROM novels WHERE title = 'Pride and Prejudice';

-- Jane likes Sense and Sensibility
INSERT INTO book_likes (user_id, book_id, created_at)
SELECT 
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    id,
    NOW() - INTERVAL '19 days'
FROM novels WHERE title = 'Sense and Sensibility';

-- Sherlock likes Sherlock Holmes
INSERT INTO book_likes (user_id, book_id, created_at)
SELECT 
    '550e8400-e29b-41d4-a716-446655440002', -- Sherlock
    id,
    NOW() - INTERVAL '15 days'
FROM novels WHERE title = 'The Adventures of Sherlock Holmes';


-- 5. Create Conversations (for Jane)
INSERT INTO conversations (
    id, user_id, scenario_id, scenario_type, character_vectordb_id, 
    title, is_root, message_count, created_at, updated_at
)
VALUES (
    '770e8400-e29b-41d4-a716-446655440001',
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    '660e8400-e29b-41d4-a716-446655440001', -- Jane's Scenario
    'root_user',
    'elizabeth_bennet_uuid',
    'Chatting with Elizabeth',
    true,
    2,
    NOW() - INTERVAL '1 hour',
    NOW() - INTERVAL '1 hour'
);

-- Messages for the conversation
INSERT INTO messages (id, conversation_id, sender_id, role, content, created_at)
VALUES 
(
    uuid_generate_v4(),
    '770e8400-e29b-41d4-a716-446655440001',
    '550e8400-e29b-41d4-a716-446655440001', -- Jane
    'user',
    'Why did you accept him?',
    NOW() - INTERVAL '59 minutes'
),
(
    uuid_generate_v4(),
    '770e8400-e29b-41d4-a716-446655440001',
    null, -- Assistant
    'assistant',
    'I felt I had no other choice to save my family from ruin.',
    NOW() - INTERVAL '58 minutes'
);
