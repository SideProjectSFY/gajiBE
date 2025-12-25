-- V52: Populate S3 image URLs for characters and novels
-- S3 Bucket: gaji-bucket-namut
-- Region: ap-northeast-2

-- ============================================
-- CHARACTER PORTRAIT IMAGES
-- ============================================

-- Pride and Prejudice
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1342_Pride_and_Prejudice_Elizabeth_Bennet.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1342 LIMIT 1)
  AND common_name = 'Elizabeth Bennet';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1342_Pride_and_Prejudice_Fitzwilliam_Darcy.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1342 LIMIT 1)
  AND common_name = 'Fitzwilliam Darcy';

-- Sherlock Holmes (1661)
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1661_The_Adventures_of_Sherlock_Holmes_Sherlock_Holmes.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1661 LIMIT 1)
  AND common_name = 'Sherlock Holmes';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1661_The_Adventures_of_Sherlock_Holmes_Dr_Watson.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1661 LIMIT 1)
  AND common_name = 'Dr. Watson';

-- Sherlock Holmes (2852 - Hound of Baskervilles)
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/2852_The_Hound_of_the_Baskervilles_Sherlock_Holmes.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 2852 LIMIT 1)
  AND common_name = 'Sherlock Holmes';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/2852_The_Hound_of_the_Baskervilles_Dr_Watson.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 2852 LIMIT 1)
  AND common_name = 'Dr. Watson';

-- Alice in Wonderland
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/11_Alice_s_Adventures_in_Wonderland_Alice.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 11 LIMIT 1)
  AND common_name = 'Alice';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/11_Alice_s_Adventures_in_Wonderland_Queen_of_Hearts.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 11 LIMIT 1)
  AND common_name = 'Queen of Hearts';

-- Moby-Dick
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/15_Moby-Dick_or_The_Whale_Ishmael.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 15 LIMIT 1)
  AND common_name = 'Ishmael';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/15_Moby-Dick_or_The_Whale_Queequeg.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 15 LIMIT 1)
  AND common_name = 'Queequeg';

-- The Time Machine
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/35_The_Time_Machine_Time_Traveller.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 35 LIMIT 1)
  AND common_name = 'Time Traveller';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/35_The_Time_Machine_Weena.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 35 LIMIT 1)
  AND common_name = 'Weena';

-- The War of the Worlds
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/36_The_War_of_the_Worlds_The_Narrator.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 36 LIMIT 1)
  AND common_name = 'The Narrator';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/36_The_War_of_the_Worlds_The_Narrators_Wife.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 36 LIMIT 1)
  AND common_name = 'The Narrator''s Wife';

-- Dr. Jekyll and Mr. Hyde
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/42_The_Strange_Case_of_Dr__Jekyll_and_Mr__Hyde_Dr_Jekyll.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 42 LIMIT 1)
  AND common_name = 'Dr. Jekyll';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/42_The_Strange_Case_of_Dr__Jekyll_and_Mr__Hyde_Mr_Utterson.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 42 LIMIT 1)
  AND common_name = 'Mr. Utterson';

-- Tom Sawyer
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/74_The_Adventures_of_Tom_Sawyer_Complete_Tom_Sawyer.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 74 LIMIT 1)
  AND common_name = 'Tom Sawyer';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/74_The_Adventures_of_Tom_Sawyer_Complete_Huckleberry_Finn.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 74 LIMIT 1)
  AND common_name = 'Huckleberry Finn';

-- Frankenstein
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/84_Frankenstein_Or_The_Modern_Prometheus_Victor_Frankenstein.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 84 LIMIT 1)
  AND common_name = 'Victor Frankenstein';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/84_Frankenstein_Or_The_Modern_Prometheus_The_Creature.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 84 LIMIT 1)
  AND common_name = 'The Creature';

-- A Tale of Two Cities
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/98_A_Tale_of_Two_Cities_Charles_Darnay.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 98 LIMIT 1)
  AND common_name = 'Charles Darnay';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/98_A_Tale_of_Two_Cities_Lucie_Manette.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 98 LIMIT 1)
  AND common_name = 'Lucie Manette';

-- Treasure Island
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/120_Treasure_Island_Jim_Hawkins.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 120 LIMIT 1)
  AND common_name = 'Jim Hawkins';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/120_Treasure_Island_Long_John_Silver.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 120 LIMIT 1)
  AND common_name = 'Long John Silver';

-- The Moonstone
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/155_The_Moonstone_Franklin_Blake.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 155 LIMIT 1)
  AND common_name = 'Franklin Blake';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/155_The_Moonstone_Rachel_Verinder.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 155 LIMIT 1)
  AND common_name = 'Rachel Verinder';

-- Emma
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/158_Emma_Emma_Woodhouse.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 158 LIMIT 1)
  AND common_name = 'Emma Woodhouse';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/158_Emma_Mr_Knightley.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 158 LIMIT 1)
  AND common_name = 'Mr. Knightley';

-- Sense and Sensibility
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/161_Sense_and_Sensibility_Elinor_Dashwood.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 161 LIMIT 1)
  AND common_name = 'Elinor Dashwood';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/161_Sense_and_Sensibility_Marianne_Dashwood.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 161 LIMIT 1)
  AND common_name = 'Marianne Dashwood';

-- Twenty Thousand Leagues Under the Sea
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/164_Twenty_Thousand_Leagues_under_the_Sea_Conseil.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 164 LIMIT 1)
  AND common_name = 'Conseil';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/164_Twenty_Thousand_Leagues_under_the_Sea_Pierre_Aronnax.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 164 LIMIT 1)
  AND common_name = 'Pierre Aronnax';

-- Dracula
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/345_Dracula_Jonathan_Harker.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 345 LIMIT 1)
  AND common_name = 'Jonathan Harker';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/345_Dracula_Mina_Harker.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 345 LIMIT 1)
  AND common_name = 'Mina Harker';

-- Robinson Crusoe
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/521_The_Life_and_Adventures_of_Robinson_Crusoe_Robinson_Crusoe.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 521 LIMIT 1)
  AND common_name = 'Robinson Crusoe';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/521_The_Life_and_Adventures_of_Robinson_Crusoe_Friday.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 521 LIMIT 1)
  AND common_name = 'Friday';

-- Wuthering Heights
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/768_Wuthering_Heights_Heathcliff.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 768 LIMIT 1)
  AND common_name = 'Heathcliff';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/768_Wuthering_Heights_Catherine_Earnshaw.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 768 LIMIT 1)
  AND common_name = 'Catherine Earnshaw';

-- The Count of Monte Cristo
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1184_The_Count_of_Monte_Cristo__Illustrated_Edmond_Dantès.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1184 LIMIT 1)
  AND common_name = 'Edmond Dantès';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1184_The_Count_of_Monte_Cristo__Illustrated_M_Morrel.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1184 LIMIT 1)
  AND common_name = 'M. Morrel';

-- The Three Musketeers
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1257_The_Three_Musketeers_Athos.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1257 LIMIT 1)
  AND common_name = 'Athos';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1257_The_Three_Musketeers_DArtagnan.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1257 LIMIT 1)
  AND common_name = 'D''Artagnan';

-- Jane Eyre
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1260_Jane_Eyre_An_Autobiography_Jane_Eyre.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1260 LIMIT 1)
  AND common_name = 'Jane Eyre';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1260_Jane_Eyre_An_Autobiography_Mr_Rochester.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1260 LIMIT 1)
  AND common_name = 'Mr. Rochester';

-- Great Expectations
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1400_Great_Expectations_Joe_Gargery.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1400 LIMIT 1)
  AND common_name = 'Joe Gargery';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1400_Great_Expectations_Pip.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1400 LIMIT 1)
  AND common_name = 'Pip';

-- Romeo and Juliet
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1513_Romeo_and_Juliet_Juliet.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1513 LIMIT 1)
  AND common_name = 'Juliet';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/1513_Romeo_and_Juliet_Romeo.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 1513 LIMIT 1)
  AND common_name = 'Romeo';

-- The Great Gatsby
UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/64317_The_Great_Gatsby_Jay_Gatsby.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 64317 LIMIT 1)
  AND common_name = 'Jay Gatsby';

UPDATE characters SET image_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_images/64317_The_Great_Gatsby_Nick_Carraway.png'
WHERE novel_id = (SELECT id FROM novels WHERE gutenberg_id = 64317 LIMIT 1)
  AND common_name = 'Nick Carraway';

-- ============================================
-- CHARACTER RELATIONSHIP GRAPH IMAGES
-- ============================================

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/11_Alice_s_Adventures_in_Wonderland_graph.png'
WHERE gutenberg_id = 11;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/15_Moby-Dick_or_The_Whale_graph.png'
WHERE gutenberg_id = 15;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/35_The_Time_Machine_graph.png'
WHERE gutenberg_id = 35;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/36_The_War_of_the_Worlds_graph.png'
WHERE gutenberg_id = 36;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/42_The_Strange_Case_of_Dr__Jekyll_and_Mr__Hyde_graph.png'
WHERE gutenberg_id = 42;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/74_The_Adventures_of_Tom_Sawyer_Complete_graph.png'
WHERE gutenberg_id = 74;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/84_Frankenstein_Or_The_Modern_Prometheus_graph.png'
WHERE gutenberg_id = 84;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/98_A_Tale_of_Two_Cities_graph.png'
WHERE gutenberg_id = 98;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/120_Treasure_Island_graph.png'
WHERE gutenberg_id = 120;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/155_The_Moonstone_graph.png'
WHERE gutenberg_id = 155;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/158_Emma_graph.png'
WHERE gutenberg_id = 158;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/161_Sense_and_Sensibility_graph.png'
WHERE gutenberg_id = 161;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/164_Twenty_Thousand_Leagues_under_the_Sea_graph.png'
WHERE gutenberg_id = 164;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/345_Dracula_graph.png'
WHERE gutenberg_id = 345;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/521_The_Life_and_Adventures_of_Robinson_Crusoe_graph.png'
WHERE gutenberg_id = 521;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/768_Wuthering_Heights_graph.png'
WHERE gutenberg_id = 768;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1184_The_Count_of_Monte_Cristo__Illustrated_graph.png'
WHERE gutenberg_id = 1184;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1257_The_Three_Musketeers_graph.png'
WHERE gutenberg_id = 1257;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1260_Jane_Eyre_An_Autobiography_graph.png'
WHERE gutenberg_id = 1260;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1342_Pride_and_Prejudice_graph.png'
WHERE gutenberg_id = 1342;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1400_Great_Expectations_graph.png'
WHERE gutenberg_id = 1400;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1513_Romeo_and_Juliet_graph.png'
WHERE gutenberg_id = 1513;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/1661_The_Adventures_of_Sherlock_Holmes_graph.png'
WHERE gutenberg_id = 1661;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/2852_The_Hound_of_the_Baskervilles_graph.png'
WHERE gutenberg_id = 2852;

UPDATE novels SET character_graph_url = 'https://gaji-bucket-namut.s3.ap-northeast-2.amazonaws.com/character_graphs/64317_The_Great_Gatsby_graph.png'
WHERE gutenberg_id = 64317;

-- Log completion
DO $$
BEGIN
    RAISE NOTICE 'V52: S3 URLs populated - Characters: %, Novels with graphs: %', 
        (SELECT COUNT(*) FROM characters WHERE image_url IS NOT NULL),
        (SELECT COUNT(*) FROM novels WHERE character_graph_url IS NOT NULL);
END $$;

COMMENT ON COLUMN characters.image_url IS 'V52: S3 character portrait images populated';
COMMENT ON COLUMN novels.character_graph_url IS 'V52: S3 character relationship graph images populated';