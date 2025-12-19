-- V18: Add more sample books for Book Browse Page testing
-- Adding 20+ books with scenarios and conversations for realistic pagination/filtering testing

-- Add more sample novels (metadata only)
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count) VALUES
  -- Fantasy books
  ('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy', 'novel_hobbit_uuid', 'completed', 445, 38),
  ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 1997, 'Fantasy', 'novel_hp1_uuid', 'completed', 523, 42),
  ('The Chronicles of Narnia: The Lion, the Witch and the Wardrobe', 'C.S. Lewis', 1950, 'Fantasy', 'novel_narnia_uuid', 'completed', 398, 35),
  ('Alice''s Adventures in Wonderland', 'Lewis Carroll', 1865, 'Fantasy', 'novel_alice_uuid', 'completed', 287, 28),
  
  -- Sci-Fi books
  ('Frankenstein', 'Mary Shelley', 1818, 'Sci-Fi', 'novel_frankenstein_uuid', 'completed', 512, 18),
  ('The Time Machine', 'H.G. Wells', 1895, 'Sci-Fi', 'novel_time_machine_uuid', 'completed', 234, 15),
  ('Twenty Thousand Leagues Under the Sea', 'Jules Verne', 1870, 'Sci-Fi', 'novel_20k_leagues_uuid', 'completed', 567, 22),
  ('The War of the Worlds', 'H.G. Wells', 1898, 'Sci-Fi', 'novel_war_worlds_uuid', 'completed', 345, 12),
  
  -- Mystery books
  ('The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 1892, 'Mystery', 'novel_sherlock_uuid', 'completed', 456, 25),
  ('The Hound of the Baskervilles', 'Arthur Conan Doyle', 1902, 'Mystery', 'novel_hound_uuid', 'completed', 389, 18),
  ('The Moonstone', 'Wilkie Collins', 1868, 'Mystery', 'novel_moonstone_uuid', 'completed', 478, 32),
  
  -- Romance books
  ('Sense and Sensibility', 'Jane Austen', 1811, 'Romance', 'novel_sense_uuid', 'completed', 492, 38),
  ('Wuthering Heights', 'Emily Brontë', 1847, 'Romance', 'novel_wuthering_uuid', 'completed', 523, 28),
  ('Jane Eyre', 'Charlotte Brontë', 1847, 'Romance', 'novel_jane_eyre_uuid', 'completed', 612, 35),
  
  -- Adventure books
  ('Treasure Island', 'Robert Louis Stevenson', 1883, 'Adventure', 'novel_treasure_uuid', 'completed', 378, 24),
  ('The Three Musketeers', 'Alexandre Dumas', 1844, 'Adventure', 'novel_musketeers_uuid', 'completed', 689, 48),
  ('Robinson Crusoe', 'Daniel Defoe', 1719, 'Adventure', 'novel_crusoe_uuid', 'completed', 445, 15),
  
  -- Horror books
  ('Dracula', 'Bram Stoker', 1897, 'Horror', 'novel_dracula_uuid', 'completed', 534, 22),
  ('The Strange Case of Dr Jekyll and Mr Hyde', 'Robert Louis Stevenson', 1886, 'Horror', 'novel_jekyll_uuid', 'completed', 178, 8),
  
  -- Historical books
  ('A Tale of Two Cities', 'Charles Dickens', 1859, 'Historical', 'novel_two_cities_uuid', 'completed', 598, 45),
  ('The Count of Monte Cristo', 'Alexandre Dumas', 1844, 'Historical', 'novel_monte_cristo_uuid', 'completed', 789, 52);

-- Add base scenarios for each book (2-5 scenarios per book)
-- Fantasy scenarios
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'the_hobbit', 'The Journey Begins', 'The start of an epic adventure', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title = 'The Hobbit'
UNION ALL
SELECT id, 'the_hobbit', 'Dragon Encounter', 'Meeting Smaug the dragon', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid()]
FROM novels WHERE title = 'The Hobbit'
UNION ALL
SELECT id, 'harry_potter_1', 'The Sorting Hat', 'Harry''s first day at Hogwarts', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE 'Harry Potter%'
UNION ALL
SELECT id, 'harry_potter_1', 'Quidditch Match', 'First Quidditch game', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE 'Harry Potter%'
UNION ALL
SELECT id, 'narnia', 'Through the Wardrobe', 'Entering Narnia', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid(), gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE '%Narnia%'
UNION ALL
SELECT id, 'alice_wonderland', 'Tea Party', 'The Mad Hatter''s tea party', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE 'Alice%';

-- Mystery scenarios
INSERT INTO base_scenarios (novel_id, base_story, title, description, vectordb_passage_ids, character_vectordb_ids)
SELECT id, 'sherlock_holmes', 'A Study in Scarlet', 'Holmes'' first case', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE '%Sherlock%'
UNION ALL
SELECT id, 'sherlock_holmes', 'The Sign of Four', 'Mystery of the treasure', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid(), gen_random_uuid()]
FROM novels WHERE title LIKE '%Sherlock%'
UNION ALL
SELECT id, 'baskerville_hound', 'The Curse Revealed', 'The legend of the Baskerville hound', 
       ARRAY[gen_random_uuid(), gen_random_uuid()], 
       ARRAY[gen_random_uuid()]
FROM novels WHERE title LIKE '%Baskerville%';

-- Create root user scenarios from base scenarios (for conversation counts)
-- This will give each book multiple scenarios with varying conversation counts
INSERT INTO root_user_scenarios (user_id, base_scenario_id, title, description, what_if_question, scenario_type, is_private, fork_count)
SELECT 
  u.id,
  bs.id,
  'What if ' || bs.title || ' went differently?',
  'Alternative take on ' || bs.description,
  'What if the protagonist made a different choice?',
  'CHARACTER_CHANGE',
  false,
  FLOOR(RANDOM() * 10)::INTEGER
FROM users u
CROSS JOIN base_scenarios bs
WHERE u.username IN ('alice_wonder', 'diana_creator', 'grace_novelist')
AND bs.id IN (SELECT id FROM base_scenarios ORDER BY created_at DESC LIMIT 30);

INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title)
SELECT 
  u.id,
  rus.id,
  'root_user',
  gen_random_uuid(),
       'Discussion about ' || rus.title
FROM users u
CROSS JOIN root_user_scenarios rus
WHERE u.username IN ('bob_reader', 'charlie_chat', 'eve_explorer', 'frank_social', 'henry_fork')
AND rus.id IN (SELECT id FROM root_user_scenarios ORDER BY created_at DESC LIMIT 40);

-- Add more conversations to increase variety
INSERT INTO conversations (user_id, scenario_id, scenario_type, character_vectordb_id, title)
SELECT 
  u.id,
  rus.id,
  'root_user',
  gen_random_uuid(),
       'Another take on ' || rus.title
FROM users u
CROSS JOIN root_user_scenarios rus
WHERE u.username IN ('alice_wonder', 'diana_creator')
AND rus.id IN (SELECT id FROM root_user_scenarios ORDER BY RANDOM() LIMIT 30);

COMMENT ON TABLE novels IS 'V18: Added 20+ books across multiple genres for Book Browse testing';
