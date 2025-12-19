-- V42: Add Mock Conversations for Public Feed
-- Adds missing novels and creates rich conversation data matching the UI design

-- 1. Add missing novels (The Great Gatsby, 1984)
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count, description, cover_image_url)
SELECT 'The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic', 'novel_gatsby', 'completed', 450, 20, 
       'A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
       'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'
WHERE NOT EXISTS (SELECT 1 FROM novels WHERE title = 'The Great Gatsby');

INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count, description, cover_image_url)
SELECT '1984', 'George Orwell', 1949, 'Dystopian', 'novel_1984', 'completed', 500, 15, 
       'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.',
       'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'
WHERE NOT EXISTS (SELECT 1 FROM novels WHERE title = '1984');

-- 2. Create Base Scenarios for these novels (if not exist)
-- We use a DO block or just simple INSERTs with subqueries. 
-- Since we can't easily use DO blocks in all migration tools without specific config, we'll use INSERT SELECT WHERE NOT EXISTS.

-- Helper function to get novel ID
-- (We'll just use subqueries in the INSERTs)

-- Base Scenario: Pride and Prejudice (Elizabeth)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'pride_and_prejudice_liz', 'Elizabeth Bennet Character Study', 'Focus on Elizabeth Bennet', ARRAY['uuid1'::UUID], ARRAY['char_liz'::UUID]
FROM novels WHERE title = 'Pride and Prejudice'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Elizabeth Bennet Character Study');

-- Base Scenario: The Great Gatsby (Gatsby)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'gatsby_main', 'Jay Gatsby Character Study', 'Focus on Jay Gatsby', ARRAY['uuid2'::UUID], ARRAY['char_gatsby'::UUID]
FROM novels WHERE title = 'The Great Gatsby'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Jay Gatsby Character Study');

-- Base Scenario: Moby Dick (Ahab)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'moby_dick_ahab', 'Captain Ahab Character Study', 'Focus on Captain Ahab', ARRAY['uuid3'::UUID], ARRAY['char_ahab'::UUID]
FROM novels WHERE title = 'Moby-Dick'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Captain Ahab Character Study');

-- Base Scenario: Wuthering Heights (Heathcliff)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'wuthering_heathcliff', 'Heathcliff Character Study', 'Focus on Heathcliff', ARRAY['uuid4'::UUID], ARRAY['char_heathcliff'::UUID]
FROM novels WHERE title = 'Wuthering Heights'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Heathcliff Character Study');

-- Base Scenario: 1984 (Winston)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, '1984_winston', 'Winston Smith Character Study', 'Focus on Winston Smith', ARRAY['uuid5'::UUID], ARRAY['char_winston'::UUID]
FROM novels WHERE title = '1984'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Winston Smith Character Study');

-- Base Scenario: Jane Eyre (Jane)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'jane_eyre_main', 'Jane Eyre Character Study', 'Focus on Jane Eyre', ARRAY['uuid6'::UUID], ARRAY['char_jane'::UUID]
FROM novels WHERE title = 'Jane Eyre'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Jane Eyre Character Study');

-- Base Scenario: Pride and Prejudice (Darcy)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'pride_and_prejudice_darcy', 'Mr. Darcy Character Study', 'Focus on Mr. Darcy', ARRAY['uuid7'::UUID], ARRAY['char_darcy'::UUID]
FROM novels WHERE title = 'Pride and Prejudice'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Mr. Darcy Character Study');

-- Base Scenario: The Great Gatsby (Nick)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'gatsby_nick', 'Nick Carraway Character Study', 'Focus on Nick Carraway', ARRAY['uuid8'::UUID], ARRAY['char_nick'::UUID]
FROM novels WHERE title = 'The Great Gatsby'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Nick Carraway Character Study');

-- Base Scenario: Wuthering Heights (Catherine)
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'wuthering_catherine', 'Catherine Earnshaw Character Study', 'Focus on Catherine Earnshaw', ARRAY['uuid9'::UUID], ARRAY['char_catherine'::UUID]
FROM novels WHERE title = 'Wuthering Heights'
AND NOT EXISTS (SELECT 1 FROM base_scenarios WHERE title = 'Catherine Earnshaw Character Study');


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
    u.id, s.id, 'root_user', 'char_liz', 'Elizabeth Bennet', 1546, 342, false
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
    u.id, s.id, 'root_user', 'char_gatsby', 'Jay Gatsby', 1734, 892, false
FROM target_user u, inserted_scenario s;

-- 3.3 Captain Ahab
WITH target_user AS (SELECT id FROM users WHERE username = 'charlie_chat' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Captain Ahab Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Captain Ahab', 
             'The monomaniacal captain of the whaling ship Pequod.',
             'What if Ahab forgave the whale?', 'CHARACTER_CHANGE', false, 893
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_ahab', 'Captain Ahab', 893, 120, false
FROM target_user u, inserted_scenario s;

-- 3.4 Heathcliff
WITH target_user AS (SELECT id FROM users WHERE username = 'diana_creator' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Heathcliff Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Heathcliff', 
             'A dark, intense figure consumed by love and revenge.',
             'What if Heathcliff stayed?', 'CHARACTER_CHANGE', false, 1287
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_heathcliff', 'Heathcliff', 1287, 543, false
FROM target_user u, inserted_scenario s;

-- 3.5 Winston Smith
WITH target_user AS (SELECT id FROM users WHERE username = 'eve_explorer' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Winston Smith Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Winston Smith', 
             'A low-ranking member of the Party who begins to question the system.',
             'What if Winston escaped?', 'EVENT_ALTERATION', false, 1315
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_winston', 'Winston Smith', 1315, 678, false
FROM target_user u, inserted_scenario s;

-- 3.6 Jane Eyre
WITH target_user AS (SELECT id FROM users WHERE username = 'frank_social' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Jane Eyre Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Jane Eyre', 
             'An orphaned governess with strong moral convictions.',
             'What if Jane never left?', 'EVENT_ALTERATION', false, 1159
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_jane', 'Jane Eyre', 1159, 432, false
FROM target_user u, inserted_scenario s;

-- 3.7 Mr. Fitzwilliam Darcy
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
    u.id, s.id, 'root_user', 'char_darcy', 'Mr. Fitzwilliam Darcy', 1523, 765, false
FROM target_user u, inserted_scenario s;

-- 3.8 Nick Carraway
WITH target_user AS (SELECT id FROM users WHERE username = 'henry_fork' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Nick Carraway Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Nick Carraway', 
             'The narrator who finds himself drawn into Gatsby''s world.',
             'What if Nick intervened?', 'EVENT_ALTERATION', false, 763
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_nick', 'Nick Carraway', 763, 234, false
FROM target_user u, inserted_scenario s;

-- 3.9 Catherine Earnshaw
WITH target_user AS (SELECT id FROM users WHERE username = 'alice_wonder' LIMIT 1),
     target_base AS (SELECT id FROM base_scenarios WHERE title = 'Catherine Earnshaw Character Study' LIMIT 1),
     inserted_scenario AS (
         INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
         SELECT 
             u.id, b.id, 'Catherine Earnshaw', 
             'A free-spirited woman torn between passion and social status.',
             'What if Catherine chose Heathcliff?', 'EVENT_ALTERATION', false, 345
         FROM target_user u, target_base b
         RETURNING id
     )
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title, message_count, like_count, is_private)
SELECT 
    u.id, s.id, 'root_user', 'char_catherine', 'Catherine Earnshaw', 345, 112, false
FROM target_user u, inserted_scenario s;

