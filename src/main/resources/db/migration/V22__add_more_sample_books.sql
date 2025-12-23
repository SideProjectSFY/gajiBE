-- V22: Add more sample books for Book Browse Page testing
-- Adding 17 books with scenarios and conversations for realistic pagination/filtering testing
-- Only books with origin_txt files in gajiAI/rag-chatbot_test/data/origin_txt

-- Add more sample novels (metadata only)
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count) VALUES
  -- Fantasy books
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

-- Base scenarios and conversations are added in V41 and V42 with proper character data
-- V22 only provides the book metadata

COMMENT ON TABLE novels IS 'V22: Added 17 books across multiple genres for Book Browse testing (only books with origin_txt files)';
