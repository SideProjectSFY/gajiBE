-- V39: Enhanced Book Mock Data with Realistic Book Information
-- All 25 books from origin_txt folder (excluding The Return of Sherlock Holmes which overlaps with The Adventures of Sherlock Holmes)
-- Adding Pride and Prejudice style book data with proper covers, descriptions, and genres

-- Insert realistic classic books with descriptions
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count, description, cover_image_url) VALUES
  -- Jane Austen Collection
  ('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 'novel_pride_prejudice', 'completed', 623, 45, 
   'A romantic novel of manners set in Georgian England. The story follows Elizabeth Bennet as she deals with issues of upbringing, morality, and marriage in the society of the landed gentry.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  ('Sense and Sensibility', 'Jane Austen', 1811, 'Romance', 'novel_sense_sensibility', 'completed', 492, 38,
   'The story follows the Dashwood sisters, Elinor and Marianne, as they navigate love, romance, and heartbreak in 19th century England.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
  ('Emma', 'Jane Austen', 1815, 'Romance', 'novel_emma', 'completed', 534, 42,
   'Emma Woodhouse, handsome, clever, and rich, navigates matchmaking and self-discovery in Regency England.',
   'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'),
  
  -- Classic Fantasy
  ('Alice''s Adventures in Wonderland', 'Lewis Carroll', 1865, 'Fantasy', 'novel_alice', 'completed', 287, 28,
   'Alice tumbles down a rabbit hole into a whimsical world of peculiar creatures and mad tea parties.',
   'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400'),
  
  -- Mystery & Detective
  ('The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 1892, 'Mystery', 'novel_sherlock', 'completed', 456, 25,
   'The first collection of Sherlock Holmes stories, featuring twelve tales of the world''s greatest detective.',
   'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400'),
  ('The Hound of the Baskervilles', 'Arthur Conan Doyle', 1902, 'Mystery', 'novel_hound', 'completed', 389, 18,
   'Holmes investigates the legend of a supernatural hound haunting the Baskerville family on the moors.',
   'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'),
  ('The Moonstone', 'Wilkie Collins', 1868, 'Mystery', 'novel_moonstone', 'completed', 478, 32,
   'The theft of a legendary diamond sets off a complex mystery involving romance, intrigue, and deception.',
   'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'),
  
  -- Gothic & Horror
  ('Dracula', 'Bram Stoker', 1897, 'Horror', 'novel_dracula', 'completed', 534, 22,
   'Count Dracula comes to England to spread the undead curse. A group led by Van Helsing must stop him.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  ('Frankenstein', 'Mary Shelley', 1818, 'Sci-Fi', 'novel_frankenstein', 'completed', 512, 18,
   'A young scientist creates a sapient creature in an unorthodox experiment, with tragic consequences.',
   'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'),
  ('The Strange Case of Dr Jekyll and Mr Hyde', 'Robert Louis Stevenson', 1886, 'Horror', 'novel_jekyll', 'completed', 178, 8,
   'A London lawyer investigates the strange connection between Dr. Jekyll and the evil Mr. Hyde.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  ('Wuthering Heights', 'Emily Brontë', 1847, 'Romance', 'novel_wuthering', 'completed', 523, 28,
   'The passionate and destructive love between Heathcliff and Catherine Earnshaw on the Yorkshire moors.',
   'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'),
  ('Jane Eyre', 'Charlotte Brontë', 1847, 'Romance', 'novel_jane_eyre', 'completed', 612, 35,
   'An orphaned governess falls in love with her employer Mr. Rochester, who harbors a dark secret.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  
  -- Adventure & Historical
  ('Treasure Island', 'Robert Louis Stevenson', 1883, 'Adventure', 'novel_treasure', 'completed', 378, 24,
   'Young Jim Hawkins embarks on a dangerous quest for buried pirate treasure.',
   'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400'),
  ('The Three Musketeers', 'Alexandre Dumas', 1844, 'Adventure', 'novel_musketeers', 'completed', 612, 45,
   'D''Artagnan joins three musketeers to serve the French king and protect the queen''s honor.',
   'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=400'),
  ('The Count of Monte Cristo', 'Alexandre Dumas', 1844, 'Historical', 'novel_monte_cristo', 'completed', 789, 52,
   'A tale of betrayal, imprisonment, escape, and elaborate revenge in 19th century France.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
  ('A Tale of Two Cities', 'Charles Dickens', 1859, 'Historical', 'novel_two_cities', 'completed', 578, 38,
   'Set against the backdrop of the French Revolution, a tale of sacrifice and resurrection.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
  ('Great Expectations', 'Charles Dickens', 1861, 'Drama', 'novel_great_expectations', 'completed', 687, 58,
   'An orphan named Pip navigates life, love, and social class in Victorian England.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  ('Robinson Crusoe', 'Daniel Defoe', 1719, 'Adventure', 'novel_crusoe', 'completed', 445, 15,
   'A sailor survives a shipwreck and lives alone on a desert island for nearly three decades.',
   'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400'),
  
  -- Science Fiction
  ('The Time Machine', 'H.G. Wells', 1895, 'Sci-Fi', 'novel_time_machine', 'completed', 234, 12,
   'A scientist invents a machine that allows him to travel through time to the distant future.',
   'https://images.unsplash.com/photo-1589998059171-988d887df646?w=400'),
  ('The War of the Worlds', 'H.G. Wells', 1898, 'Sci-Fi', 'novel_war_worlds', 'completed', 345, 12,
   'Martians invade Victorian England in this pioneering science fiction tale of alien invasion.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  ('Twenty Thousand Leagues Under the Sea', 'Jules Verne', 1870, 'Sci-Fi', 'novel_20k_leagues', 'completed', 445, 18,
   'Professor Aronnax is taken prisoner aboard the Nautilus by the enigmatic Captain Nemo.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  
  -- Classic Literature
  ('Moby-Dick', 'Herman Melville', 1851, 'Adventure', 'novel_moby_dick', 'completed', 689, 32,
   'Captain Ahab''s obsessive quest for revenge against the white whale that maimed him.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic', 'novel_gatsby', 'completed', 450, 20, 
   'A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
   'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'),
  ('The Adventures of Tom Sawyer', 'Mark Twain', 1876, 'Adventure', 'novel_tom_sawyer', 'completed', 412, 35,
   'A mischievous boy growing up along the Mississippi River has adventures with his friends.',
   'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=400'),
  
  -- Shakespeare
  ('Romeo and Juliet', 'William Shakespeare', 1597, 'Tragedy', 'novel_romeo_juliet', 'completed', 350, 20,
   'The tragic love story of two young star-crossed lovers whose deaths ultimately reconcile their feuding families.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400');

COMMENT ON TABLE novels IS 'V39: Added 25 books from origin_txt with descriptions and cover images';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/11_Alice_s_Adventures_in_Wonderland_graph.png'
WHERE title = 'Alice''s Adventures in Wonderland';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/15_Moby-Dick_or_The_Whale_graph.png'
WHERE title = 'Moby-Dick';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/35_The_Time_Machine_graph.png'
WHERE title = 'The Time Machine';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/36_The_War_of_the_Worlds_graph.png'
WHERE title = 'The War of the Worlds';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/42_The_Strange_Case_of_Dr__Jekyll_and_Mr__Hyde_graph.png'
WHERE title = 'The Strange Case of Dr Jekyll and Mr Hyde';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/74_The_Adventures_of_Tom_Sawyer_Complete_graph.png'
WHERE title = 'The Adventures of Tom Sawyer';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/84_Frankenstein_Or_The_Modern_Prometheus_graph.png'
WHERE title = 'Frankenstein';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/98_A_Tale_of_Two_Cities_graph.png'
WHERE title = 'A Tale of Two Cities';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/120_Treasure_Island_graph.png'
WHERE title = 'Treasure Island';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/155_The_Moonstone_graph.png'
WHERE title = 'The Moonstone';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/158_Emma_graph.png'
WHERE title = 'Emma';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/161_Sense_and_Sensibility_graph.png'
WHERE title = 'Sense and Sensibility';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/164_Twenty_Thousand_Leagues_under_the_Sea_graph.png'
WHERE title = 'Twenty Thousand Leagues Under the Sea';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/345_Dracula_graph.png'
WHERE title = 'Dracula';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/521_The_Life_and_Adventures_of_Robinson_Crusoe_graph.png'
WHERE title = 'Robinson Crusoe';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/768_Wuthering_Heights_graph.png'
WHERE title = 'Wuthering Heights';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1184_The_Count_of_Monte_Cristo__Illustrated_graph.png'
WHERE title = 'The Count of Monte Cristo';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1257_The_Three_Musketeers_graph.png'
WHERE title = 'The Three Musketeers';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1260_Jane_Eyre_An_Autobiography_graph.png'
WHERE title = 'Jane Eyre';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1342_Pride_and_Prejudice_graph.png'
WHERE title = 'Pride and Prejudice';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1400_Great_Expectations_graph.png'
WHERE title = 'Great Expectations';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1513_Romeo_and_Juliet_graph.png'
WHERE title = 'Romeo and Juliet';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1661_The_Adventures_of_Sherlock_Holmes_graph.png'
WHERE title = 'The Adventures of Sherlock Holmes';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/2852_The_Hound_of_the_Baskervilles_graph.png'
WHERE title = 'The Hound of the Baskervilles';

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/64317_The_Great_Gatsby_graph.png'
WHERE title = 'The Great Gatsby';