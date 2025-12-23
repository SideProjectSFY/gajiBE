-- V48: Add character relationships from char_graph data
-- Populates the character_relationships table with relationship data

-- ============================================
-- The Adventures of Sherlock Holmes - Main Character Relationships
-- ============================================

-- Holmes <-> Watson (Best Friends, Partners)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Best Friends, Partners',
    10,
    'Dr. Watson is Sherlock Holmes''s closest friend, flatmate, and chronicler. Their partnership defines the stories.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Watson'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Watson <-> Holmes (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Best Friends, Partners',
    10,
    'Holmes is Watson''s extraordinary friend whose cases he meticulously chronicles.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sherlock Holmes'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- ============================================
-- Pride and Prejudice - Main Character Relationships
-- ============================================

-- Elizabeth <-> Darcy (Romantic Interest, Initial Antagonism)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Romantic Interest',
    10,
    'Elizabeth initially dislikes Darcy due to his pride and her prejudice, but eventually falls deeply in love with him.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fitzwilliam Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Darcy <-> Elizabeth (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Romantic Interest',
    10,
    'Darcy falls in love with Elizabeth despite her lower social standing, captivated by her wit and intelligence.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Elizabeth Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- ============================================
-- Frankenstein - Main Character Relationships
-- ============================================

-- Victor <-> Creature (Creator-Creation, Antagonistic)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Creator-Creation, Antagonistic',
    10,
    'Victor created the Creature but immediately abandoned him in horror, leading to mutual destruction.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Creature'
WHERE n.title = 'Frankenstein'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Creature <-> Victor (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Creation-Creator, Vengeance',
    10,
    'The Creature seeks revenge against Victor for abandoning him and denying him a companion.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Victor Frankenstein'
WHERE n.title = 'Frankenstein'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- ============================================
-- The Great Gatsby - Main Character Relationships
-- ============================================

-- Nick <-> Gatsby (Friend, Observer)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Friend, Observer',
    8,
    'Nick becomes Gatsby''s friend and the sole witness to his tragic pursuit of the American Dream.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jay Gatsby'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Gatsby <-> Nick (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Friend, Confidant',
    8,
    'Gatsby confides in Nick and uses him as a connection to Daisy.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nick Carraway'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- ============================================
-- The Adventures of Tom Sawyer - Main Character Relationships
-- ============================================

-- Tom <-> Huck (Best Friends)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Best Friends',
    10,
    'Tom and Huck are inseparable friends who share adventures along the Mississippi River.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Huckleberry Finn'
WHERE n.title = 'The Adventures of Tom Sawyer'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Huck <-> Tom (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Best Friends',
    10,
    'Huck admires Tom''s imagination and leadership, following him on many adventures.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Sawyer'
WHERE n.title = 'The Adventures of Tom Sawyer'
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- ============================================
-- Romeo and Juliet - Main Character Relationships
-- ============================================

-- Romeo <-> Juliet (Lovers)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Lovers, Star-crossed',
    10,
    'Romeo falls instantly and completely in love with Juliet despite their families'' deadly feud.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Juliet'
WHERE n.gutenberg_id = 1513
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Juliet <-> Romeo (reverse)
INSERT INTO character_relationships (novel_id, source_character_id, target_character_id, relationship_type, weight, description)
SELECT 
    n.id,
    c1.id,
    c2.id,
    'Lovers, Star-crossed',
    10,
    'Juliet loves Romeo with equal passion, willing to defy her family and risk death for their love.'
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Romeo'
WHERE n.gutenberg_id = 1513
ON CONFLICT (source_character_id, target_character_id) DO NOTHING;

-- Log the number of relationships inserted
DO $$
BEGIN
    RAISE NOTICE 'Character relationships migration completed. Total relationships: %', (SELECT COUNT(*) FROM character_relationships);
END $$;

