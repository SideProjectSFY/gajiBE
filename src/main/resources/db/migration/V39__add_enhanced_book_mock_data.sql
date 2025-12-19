-- V39: Enhanced Book Mock Data with Realistic Book Information
-- Adding Pride and Prejudice style book data with proper covers, descriptions, and genres

-- Insert realistic classic books with descriptions
INSERT INTO novels (title, author, publication_year, genre, vectordb_collection_id, ingestion_status, total_passages_count, total_characters_count, description, cover_image_url) VALUES
  -- Pride and Prejudice (Main featured book)
  ('Pride and Prejudice', 'Jane Austen', 1813, 'Romance', 'novel_pride_prejudice', 'completed', 623, 45, 
   'A romantic novel of manners set in Georgian England. The story follows Elizabeth Bennet as she deals with issues of upbringing, morality, and marriage in the society of the landed gentry.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  
  -- More Jane Austen
  ('Sense and Sensibility', 'Jane Austen', 1811, 'Romance', 'novel_sense_sensibility', 'completed', 492, 38,
   'The story follows the Dashwood sisters, Elinor and Marianne, as they navigate love, romance, and heartbreak in 19th century England.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
  ('Emma', 'Jane Austen', 1815, 'Romance', 'novel_emma', 'completed', 534, 42,
   'Emma Woodhouse, handsome, clever, and rich, navigates matchmaking and self-discovery in Regency England.',
   'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'),
  
  -- Classic Fantasy
  ('The Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasy', 'novel_hobbit', 'completed', 445, 38,
   'Bilbo Baggins embarks on an unexpected journey with thirteen dwarves and the wizard Gandalf to reclaim the Lonely Mountain.',
   'https://images.unsplash.com/photo-1589998059171-988d887df646?w=400'),
  ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 1997, 'Fantasy', 'novel_hp1', 'completed', 523, 42,
   'An orphaned boy discovers he''s a wizard and attends Hogwarts School of Witchcraft and Wizardry.',
   'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400'),
  ('The Chronicles of Narnia', 'C.S. Lewis', 1950, 'Fantasy', 'novel_narnia', 'completed', 398, 35,
   'Four siblings discover a magical land through a wardrobe and help defeat the White Witch.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
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
  
  -- Gothic & Horror
  ('Dracula', 'Bram Stoker', 1897, 'Horror', 'novel_dracula', 'completed', 534, 22,
   'Count Dracula comes to England to spread the undead curse. A group led by Van Helsing must stop him.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  ('Frankenstein', 'Mary Shelley', 1818, 'Sci-Fi', 'novel_frankenstein', 'completed', 512, 18,
   'A young scientist creates a sapient creature in an unorthodox experiment, with tragic consequences.',
   'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400'),
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
  ('A Tale of Two Cities', 'Charles Dickens', 1859, 'Historical', 'novel_two_cities', 'completed', 578, 38,
   'Set against the backdrop of the French Revolution, a tale of sacrifice and resurrection.',
   'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=400'),
  
  -- Science Fiction
  ('The Time Machine', 'H.G. Wells', 1895, 'Sci-Fi', 'novel_time_machine', 'completed', 234, 12,
   'A scientist invents a machine that allows him to travel through time to the distant future.',
   'https://images.unsplash.com/photo-1589998059171-988d887df646?w=400'),
  ('Twenty Thousand Leagues Under the Sea', 'Jules Verne', 1870, 'Sci-Fi', 'novel_20k_leagues', 'completed', 445, 18,
   'Professor Aronnax is taken prisoner aboard the Nautilus by the enigmatic Captain Nemo.',
   'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=400'),
  
  -- Classic Literature
  ('Moby-Dick', 'Herman Melville', 1851, 'Adventure', 'novel_moby_dick', 'completed', 689, 32,
   'Captain Ahab''s obsessive quest for revenge against the white whale that maimed him.',
   'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400'),
  
  -- Added in V42 originally, moved here for consistency
  ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Classic', 'novel_gatsby', 'completed', 450, 20, 
   'A story of the fabulously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan.',
   'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=400'),
  ('1984', 'George Orwell', 1949, 'Dystopian', 'novel_1984', 'completed', 500, 15, 
   'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.',
   'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=400');

