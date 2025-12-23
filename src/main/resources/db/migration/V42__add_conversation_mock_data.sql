-- V42: Add Mock Conversations for Public Feed
-- Adds missing novels and creates rich conversation data matching the UI design

-- 1. Add missing novels (Moved to V39)

-- 2. Create Base Scenarios for these novels (if not exist)
-- We use a DO block or just simple INSERTs with subqueries. 
-- Since we can't easily use DO blocks in all migration tools without specific config, we'll use INSERT SELECT WHERE NOT EXISTS.

-- Helper function to get novel ID
-- (We'll just use subqueries in the INSERTs)

-- Base Scenario: Pride and Prejudice (Elizabeth)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'pride_and_prejudice_liz', 'Elizabeth Bennet Character Study', 'Focus on Elizabeth Bennet', ARRAY['uuid1'], ARRAY['elizabeth_bennet_1342']
FROM novels WHERE title = 'Pride and Prejudice'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Elizabeth Bennet Character Study');

-- Base Scenario: The Great Gatsby (Gatsby)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'gatsby_main', 'Jay Gatsby Character Study', 'Focus on Jay Gatsby', ARRAY['uuid2'], ARRAY['gatsby_64317']
FROM novels WHERE title = 'The Great Gatsby'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Jay Gatsby Character Study');

-- Base Scenario: Pride and Prejudice (Darcy)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'pride_and_prejudice_darcy', 'Mr. Darcy Character Study', 'Focus on Mr. Darcy', ARRAY['uuid3'], ARRAY['darcy_1342']
FROM novels WHERE title = 'Pride and Prejudice'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Mr. Darcy Character Study');


-- 3. Create Root User Scenarios & Conversations
-- We'll use a temporary table or just direct inserts with CTEs to keep it clean.

-- User: alice_wonder (assuming she exists from V16)

-- 3.1 Elizabeth Bennet
WITH target_user AS (SELECT id FROM users WHERE username = 'alice_wonder' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Elizabeth Bennet Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Elizabeth Bennet', 
             'The spirited and intelligent second daughter of the Bennet family.',
             'What if Elizabeth was more open about her feelings?', 'CHARACTER_CHANGE', false, 1546
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'elizabeth_bennet_1342', 'Elizabeth Bennet', 1546, 342, false
FROM target_user u, inserted_scenario s;

-- 3.2 Jay Gatsby
WITH target_user AS (SELECT id FROM users WHERE username = 'bob_reader' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Jay Gatsby Character Study' LIMIT 1),
     inserted_scenario AS (
        INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
        SELECT 
            u.id, b.id, 'Jay Gatsby', 
            'A mysterious millionaire with a past and an obsession.',
            'What if Gatsby moved on?', 'CHARACTER_CHANGE', false, 1734
        FROM target_user u, target_base b
        RETURNING id
    )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'gatsby_64317', 'Jay Gatsby', 1734, 892, false
FROM target_user u, inserted_scenario s;

-- 3.3 Mr. Fitzwilliam Darcy
WITH target_user AS (SELECT id FROM users WHERE username = 'grace_novelist' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Mr. Darcy Character Study' LIMIT 1),
     inserted_scenario AS (
        INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
        SELECT 
            u.id, b.id, 'Mr. Fitzwilliam Darcy', 
            'A wealthy gentleman with impeccable manners but poor social skills.',
            'What if Darcy was poor?', 'CHARACTER_CHANGE', false, 1523
        FROM target_user u, target_base b
        RETURNING id
    )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'darcy_1342', 'Mr. Fitzwilliam Darcy', 1523, 765, false
FROM target_user u, inserted_scenario s;
