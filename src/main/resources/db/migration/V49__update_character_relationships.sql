-- V49: Add character relationships from char_graph JSON files
-- Populates character_relationships table with graph data

-- ============================================
-- The Return of Sherlock Holmes
-- Characters: 18, Relationships: 39
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Friends, Colleagues, Flatmates, Chronicler$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. John H. Watson'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Professional colleagues, Collaboration, Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lestrade'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Mentor, Protégé, Professional colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stanley Hopkins'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Mortal Enemies, Antagonists, Arch-criminal$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Sebastian Moran'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Arch-nemesis, Intellectual rivals, Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Moriarty'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Family (Brothers), Confidants$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mycroft Holmes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.2,
    $desc$Client, Professional consultant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Thorneycroft Huxtable'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.1,
    $desc$Adversaries (initial), Professional consultants, Collaboration$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Leslie Armstrong'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Client, Protective$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hilton Cubitt'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Hunter/Prey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abe Slaney'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Hunter/Prey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Patrick Cairns'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Ethical enemy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Augustus Milverton'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Hunter/Prey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beppo'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Major Client, Professional consultant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Holdernesse'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Criminal discovered by SH$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Wilder'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Criminal captured by SH$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Reuben Hayes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Adversary, Ethical consultant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Hilda Trelawney Hope'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Professional acquaintances, Collaboration$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John H. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lestrade'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Professional acquaintances, Collaboration$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John H. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stanley Hopkins'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.5,
    $desc$Enemies, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John H. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Sebastian Moran'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.0,
    $desc$Enemy, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John H. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Moriarty'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John H. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mycroft Holmes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Professional colleagues, Scotland Yard$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lestrade'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stanley Hopkins'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Law enforcement/Criminal, Arresting officer (assisted)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lestrade'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Sebastian Moran'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$Professional adversaries$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lestrade'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Moriarty'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Law enforcement/Criminal, Pursuer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lestrade'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beppo'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Law enforcement/Suspect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lestrade'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Hilda Trelawney Hope'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Law enforcement/Criminal, Arresting officer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stanley Hopkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Patrick Cairns'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Professional acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stanley Hopkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Leslie Armstrong'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Criminal associates, Leader/Chief of staff$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Sebastian Moran'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Moriarty'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$Professional criminal network$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Professor Moriarty'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Reuben Hayes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Professional colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mycroft Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Holdernesse'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Professional relationship, Client$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Thorneycroft Huxtable'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Holdernesse'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.5,
    $desc$Professional relationship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Thorneycroft Huxtable'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Wilder'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$Adversaries$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Thorneycroft Huxtable'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Reuben Hayes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Rivals, Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hilton Cubitt'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abe Slaney'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Father/Illegitimate Son, Employer/Secretary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Duke of Holdernesse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Wilder'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Former Employer/Employee, Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Duke of Holdernesse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Reuben Hayes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Criminal associates, Co-conspirators (Kidnapping)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'James Wilder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Reuben Hayes'
WHERE n.title = 'The Return of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Count of Monte Cristo, Illustrated
-- Characters: 17, Relationships: 34
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Patron, Friend, Benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. Morrel'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Lost Love, Betrothed, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mercédès'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Father, Filial Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Old Dantès'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Antagonists, Vengeance Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Danglars'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.8,
    $desc$Rivals, Enemies, Vengeance Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fernand Mondego'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.2,
    $desc$Victim, Persecutor, Vengeance Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gérard de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Mentor, Spiritual Father, Prison Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abbé Faria'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Guardian, Lover, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Haydée'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Indirect Beneficiary, Political Connection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. Noirtier'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Friend, Benefactor, Protégé$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Maximilian Morrel'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Employer, Agent, Professional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Luigi Vampa'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Master, Trusted Slave, Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ali'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Vengeance Agent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caderousse'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Manipulator, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Héloïse de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Protector, Beneficiary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Manipulator, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edmond Dantès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hérmine Danglars'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Friend, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. Morrel'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Old Dantès'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Father, Son, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. Morrel'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Maximilian Morrel'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Spouses, Estranged, Cousins$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mercédès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fernand Mondego'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances, Shared Affliction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mercédès'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Co-conspirators, Enemies to Edmond$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Danglars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fernand Mondego'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintances, Co-conspirators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Danglars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gérard de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Spouses, Financial Partners$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Danglars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hérmine Danglars'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintances, Accomplices in Slander$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Danglars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caderousse'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintances, Accomplices in Slander$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fernand Mondego'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caderousse'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Indirect Co-conspirators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fernand Mondego'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gérard de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Father, Son, Political Rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gérard de Villefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. Noirtier'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Spouses, Co-criminals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gérard de Villefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Héloïse de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Father, Daughter, Estranged$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gérard de Villefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances, Marriage Negotiators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gérard de Villefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hérmine Danglars'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Grandfather, Granddaughter, Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. Noirtier'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Antagonists, Attempted Murder Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. Noirtier'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Héloïse de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Lovers, Betrothed$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Maximilian Morrel'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Stepmother, Stepdaughter, Antagonists, Attempted Murder$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Héloïse de Villefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Valentine de Villefort'
WHERE n.title = 'The Count of Monte Cristo, Illustrated'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Alice's Adventures in Wonderland
-- Characters: 17, Relationships: 33
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Antagonists, Authority Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Queen of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Guide, Acquaintances, Mistaken Identity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'White Rabbit'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Acquaintances, Philosopher/Recipient$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duchess'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Guide, Mentor, Philosopher$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cheshire Cat'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Companions, Escort$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gryphon'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Acquaintances, Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mouse'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Interviewer, Storyteller$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mock Turtle'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Authority Figure, Interrogator, Helper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caterpillar'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Authority Figure, Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Family, Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sister'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Antagonists, Tea Party Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'March Hare'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Antagonists, Tea Party Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hatter'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Victimizer/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dormouse'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Pet Owner, Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dinah'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Witness/Defendant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Knave of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Accidental Adversaries, Victimizer/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alice'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bill the Lizard'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Rivals, Authority Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duchess'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Authority Figure, Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'White Rabbit'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Spousal, Authority Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Judge/Prosecutor, Prisoner/Defendant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Knave of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Authority Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hatter'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Authority Figure, Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queen of Hearts'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gryphon'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Master/Subordinate, Authority$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'White Rabbit'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bill the Lizard'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Duchess'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cheshire Cat'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Conceptual Opposition, Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Duchess'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dinah'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Conflict, Authority Challenge$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Cheshire Cat'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Friends, Schoolmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gryphon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mock Turtle'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Mortal Enemies, Predator/Prey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dinah'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Companions, Friends, Tea Party Hosts$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'March Hare'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hatter'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Acquaintances, Abuser/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'March Hare'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dormouse'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Acquaintances, Abuser/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hatter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dormouse'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances, Trial Attendees$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'March Hare'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Knave of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances, Witness/Defendant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hatter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Knave of Hearts'
WHERE n.title = 'Alice''s Adventures in Wonderland'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Treasure Island
-- Characters: 12, Relationships: 30
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Antagonist, Mentor, Complex Ally$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Long John Silver'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Guardian, Mentor, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Livesey'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Patron, Protégé, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Squire Trelawney'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Authority, Commander, Protégé$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Smollett'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Victim, Lookout, Source of Plot$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Billy Bones'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Victim, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pew'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Key Ally, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Gunn'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Ally, Comrade$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abraham Gray'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Direct Antagonist, Mortal Enemy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Israel Hands'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Companion, Escort$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Redruth'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Encounter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jim Hawkins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Black Dog'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Antagonist, Negotiator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Livesey'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Employer, Antagonist, Betrayer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Squire Trelawney'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Antagonist, Rival Professional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Smollett'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Former Shipmate, Subordinate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Billy Bones'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Former Shipmate, Conspirator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pew'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Former Shipmate, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Gunn'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Conspirator, Subordinate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Israel Hands'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Conspirator, Shipmate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Long John Silver'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Black Dog'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.8,
    $desc$Colleague, Partner, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Livesey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Squire Trelawney'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Colleague, Commander, Professional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Livesey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Smollett'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Ally, Interrogator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Livesey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Gunn'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Doctor, Patient$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Livesey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Redruth'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Owner, Employee, Conflict Resolved$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Squire Trelawney'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Smollett'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Employer, Loyal Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Squire Trelawney'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Redruth'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Commander, Loyal Subordinate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Captain Smollett'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abraham Gray'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Former Shipmate, Threat$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Billy Bones'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pew'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Former Shipmate, Colleague$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Billy Bones'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Israel Hands'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Conspirator, Accomplice$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pew'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Black Dog'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Conspirator, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Israel Hands'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Black Dog'
WHERE n.title = 'Treasure Island'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Three Musketeers
-- Characters: 20, Relationships: 62
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$friends, comrades, mentor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Athos'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$friends, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Porthos'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$friends, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Aramis'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$patron, compatriots$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. de Tréville'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$lovers, romantic relationship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mme. Bonacieux'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$antagonists, enemies, rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Milady de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$allies, duel opponents$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lord de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$subordinate, adversary, patron$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cardinal Richelieu'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$antagonists, rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Rochefort'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$master, servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King Louis XIII'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$lovers, informant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Kitty'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$master, lackey, confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Planchet'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$comrades, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Grimaud'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$comrades, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mousqueton'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$comrades, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bazin'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$indirect involvement, plot connection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Buckingham'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$allies, judges$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Executioner of Lille'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$rivals, duel opponents$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Wardes'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$duel opponents, antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'D''Artagnan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jussac'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$friends, inseparables, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Porthos'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$friends, inseparables, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Aramis'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$subordinate, superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. de Tréville'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mme. Bonacieux'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$former husband and wife, mortal enemies, judge and victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Milady de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$allies, fellow judges$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lord de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$subordinate, antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cardinal Richelieu'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.5,
    $desc$antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Rochefort'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$servant, master$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King Louis XIII'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$master, lackey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Grimaud'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$indirect antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Buckingham'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$allies, fellow judges$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Athos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Executioner of Lille'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$friends, inseparables, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Porthos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Aramis'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$subordinate, superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Porthos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. de Tréville'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Porthos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mme. Bonacieux'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$master, lackey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Porthos'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mousqueton'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$subordinate, superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aramis'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'M. de Tréville'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aramis'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mme. Bonacieux'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$master, lackey$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aramis'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bazin'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$antagonistic rivals, military rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. de Tréville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cardinal Richelieu'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$trusted captain, master$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'M. de Tréville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King Louis XIII'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$victim and murderer, enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mme. Bonacieux'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Milady de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$subject, royal protection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mme. Bonacieux'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King Louis XIII'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$sister-in-law, antagonists, jailer and prisoner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lord de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$agent, superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cardinal Richelieu'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$accomplices, agent and handler$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Rochefort'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$mistress, soubrette, manipulator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Kitty'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$agent, target, ex-lover$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Buckingham'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$victim, executioner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Executioner of Lille'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$co-conspirators, lovers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Milady de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Wardes'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$friends, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lord de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Duke of Buckingham'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$allies, judges$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lord de Winter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Executioner of Lille'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$superior, agent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Cardinal Richelieu'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Comte de Rochefort'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$minister, king, political superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Cardinal Richelieu'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'King Louis XIII'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$comrades, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Comte de Rochefort'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jussac'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Planchet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Grimaud'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Planchet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mousqueton'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Planchet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bazin'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Grimaud'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mousqueton'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Grimaud'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bazin'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$fellow lackeys, allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mousqueton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bazin'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$protected confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Duke of Buckingham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mme. Bonacieux'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$lovers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Comte de Wardes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Milady de Winter'
WHERE n.title = 'The Three Musketeers'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Jane Eyre: An Autobiography
-- Characters: 20, Relationships: 45
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$lovers, spouse, soulmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Rochester'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$friends, spiritual mentor, schoolmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Helen Burns'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$cousins, savior, unrequited suitor, spiritual conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'St. John Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$mentor, teacher, protector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Temple'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$aunt, guardian, oppressor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$antagonist, school overseer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Brocklehurst'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$cousin, bully, tormentor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$cousins, sisterly bond, friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Diana Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$cousins, sisterly bond, friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$nurse, caregiver, friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bessie Leaven'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$colleagues, friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Fairfax'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$governess, pupil, foster mother$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Adèle'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$co-resident, source of mystery/fear$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Grace Poole'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$cousin, childhood co-resident$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Eliza Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$cousin, childhood co-resident$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$patient, medical advisor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lloyd'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$childhood oppressor, maid$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Abbot'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$crisis encounter, patient/nurse$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Richard Mason'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$romantic rival, acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Eyre'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Blanche Ingram'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$jealous rivals, unmet acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'St. John Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$employer, housekeeper, friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Fairfax'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$guardian, ward$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Adèle'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$employer, secret keeper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Grace Poole'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$brother-in-law, secret associate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Richard Mason'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$feigned lovers, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Rochester'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Blanche Ingram'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$student, mentor, cherished pupil$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Helen Burns'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Temple'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$student, overseer, antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Helen Burns'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Brocklehurst'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$employee, employer, professional conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Temple'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Brocklehurst'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$professional correspondence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Temple'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lloyd'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$mother, son, indulgent love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$mother, daughter, favoritism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$mother, daughter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Eliza Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$mistress, servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bessie Leaven'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$patron, school organizer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Brocklehurst'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$patron, medical service$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lloyd'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$mistress, maid, shared gossip$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Abbot'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$siblings, close relation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'St. John Rivers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Diana Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$siblings, close relation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'St. John Rivers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$sisters, very close relation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Diana Rivers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Rivers'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$young master, servant, indulged$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Bessie Leaven'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$colleagues, friends, gossip$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Bessie Leaven'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Abbot'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$maid, young mistress, favorite$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Bessie Leaven'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$co-resident, companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Fairfax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Adèle'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$associates, secret keeper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Grace Poole'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Richard Mason'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$sisters, estranged relation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Eliza Reed'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Reed'
WHERE n.title = 'Jane Eyre: An Autobiography'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Pride and Prejudice
-- Characters: 19, Relationships: 110
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$love interest, eventual spouses, intellectual sparring partners, mutual respect, admiration$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fitzwilliam Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$sisters, confidantes, close friends, mutual support$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$father-daughter, intellectual bond, mutual amusement, affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$mother-daughter, source of vexation, family tie, frustration$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$best friends, confidantes, contrasting personalities, strained friendship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charlotte Lucas'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$friends, sister's suitor, amiable acquaintance, friendly$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$initial attraction, disillusionment, antagonism, sister's husband, disgust$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$aunt-niece, confidantes, wise counsel, supportive$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$uncle-niece, supportive, guardian figure, respect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$sisters, concern, exasperation, responsibility, shame$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$cousins, unwanted suitor, object of amusement/irritation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$rivals, antagonists, mutual dislike, jealousy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$antagonists, defiant, opposition, social conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Catherine de Bourgh'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$acquaintances, friendly, informational source, respect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Fitzwilliam'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$developing sisterly bond, future sisters-in-law, mutual positive impression$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, caretaker, concerned, guiding$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, slight dislike, social adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, indifferent, occasional exasperation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$friend's love interest, eventual brother-in-law, respect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$potential son-in-law, mutual respect, grateful$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$potential son-in-law, object of disdain, later flattery$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintances, polite host/guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charlotte Lucas'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$best friends, confidantes, mutual trust, strong influence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$enemies, long-standing animosity, betrayal, disgust$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$respectful acquaintance, grateful$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$respectful acquaintance, grateful for assistance, collaborator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$benefactor, object of disdain, sister-in-law$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$object of polite disdain, amusement$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$object of unrequited affection, polite indifference, social acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$aunt-nephew, familial duty, respect for position, independent will$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Catherine de Bourgh'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$cousins, co-guardians, close family, friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Fitzwilliam'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$brother-sister, guardian, deep affection, protective$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social circle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fitzwilliam Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$father-daughter, affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$mother-daughter, favorite child, source of anxiety$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$friends, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charlotte Lucas'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$love interest, eventual spouses, mutual affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintance, initial pity, later disapproval$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$aunt-niece, affection, comfort, support$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$uncle-niece, supportive, affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$sisters, affection, concern$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$cousins, object of brief interest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$initial friends, disappointed by coldness, social acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintance, Jane's good nature is liked, influenced by Caroline$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, amiable$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$spouses, mutual exasperation, tolerance, intellectual disdain$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, amused by her pragmatic marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charlotte Lucas'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$future son-in-law, initially reserved, later respectful and pleased$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$father-in-law, initially deceived, later disgusted, responsible for debts$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$brother-in-law, relies on for help$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$brother-in-law, relies on for practical matters, trust$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$father-daughter, indulgent, disappointed, responsible$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$cousins, landlord-heir, amusement, tolerance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$father-daughter, indulgent, later stricter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$father-daughter, indifferent, amused by pedantry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$friends, acquaintances, rival matchmakers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charlotte Lucas'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$desired son-in-law, object of matchmaking, flattering$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$initially admired, later despised for elopement, accepted as son-in-law$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$sisters, frequent communication, relies on for help, confidantes$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$mother-daughter, doting, indulgent, favorite child$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$matchmaker, flattering, eager to please, vexed by Charlotte's marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$social acquaintance, initially agreeable, later distant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$mother-daughter, indulgent, less focused$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$mother-daughter, somewhat indifferent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, social circle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Charles Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, social interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$spouses, pragmatic marriage, mutual understanding, companionship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Collins'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, social circle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$patroness-dependent, respectful, manages relationship strategically$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Catherine de Bourgh'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, agreeable$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Fitzwilliam'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, polite$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friends, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friends, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charlotte Lucas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintance, amiable, indulges his request for a ball$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wickham'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintance, amiable, indulges her request for a ball$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$brother-sister, affectionate, influenced by sister$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$friend, potential brother-in-law, acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$brother-sister, affectionate, influenced by sister$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$spouses, elopement, mercenary marriage, eventual indifference, disgrace$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'George Wickham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$attempted elopement, former childhood fondness, deception$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'George Wickham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$flirtation, shared interest in officers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'George Wickham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, object of Mary's moralizing$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'George Wickham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$spouses, supportive, loving, confidantes$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Gardiner'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Gardiner'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$aunt-niece, concerned, guiding, accepts marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Gardiner'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, positive impression$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Gardiner'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$uncle-niece, responsible, takes action to resolve elopement$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Gardiner'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lydia Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$sisters, close, Lydia influences Kitty, shared frivolity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lydia Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, indifferent, Lydia ignores Mary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lydia Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Bingley'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$patron-clergyman, obsequious respect, dependence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Catherine de Bourgh'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Fitzwilliam'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, polite$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$cousin, brief interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$cousin, Mary finds his reflections solid$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Collins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$acquaintance, social ally, mutual disdain for Bennets$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Caroline Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Catherine de Bourgh'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$desires as sister-in-law, feigned affection, social ally$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Caroline Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$sisters, confidantes, allies, mutual support$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Caroline Bingley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$aunt-nephew, familial bond, expects deference$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Catherine de Bourgh'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Fitzwilliam'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$aunt-niece, guardian figure, plans for marriage, authoritative$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Catherine de Bourgh'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, brief interaction, social superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Catherine de Bourgh'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, brief interaction, social superior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Catherine de Bourgh'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$cousins, co-guardians, friendly, familial bond$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Fitzwilliam'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Georgiana Darcy'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, brief interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Fitzwilliam'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social circle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Fitzwilliam'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, brief interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Fitzwilliam'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintance, polite, admired by Louisa$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Georgiana Darcy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintance, social interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Louisa Hurst'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$sisters, shared domestic life$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Bennet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary Bennet'
WHERE n.title = 'Pride and Prejudice'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Great Expectations
-- Characters: 16, Relationships: 49
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Family, Deep Friendship, Guardian$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joe Gargery'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Love, Obsession, Manipulated$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Estella'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Deep Friendship, Flatmates, Business Partner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Herbert Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Benefactor, Loyalty, Bound by Secret$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abel Magwitch'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Patron, Expectations, Pity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Havisham'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Friendship, Moral Guide, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Biddy'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Family, Abusive Guardian, Fear$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Joe Gargery'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Legal Guardian, Professional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Professional, Friendship, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Wemmick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Mortal Hostility, Rivalry, Assault Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Friendship, Assistance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Pumblechook'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Enemy, Encounter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Compeyson'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Village Figure$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Wopsle'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Tutor, Mentor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pip'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Matthew Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Love, Marriage, Partnership$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Joe Gargery'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Professional Rivalry, Hostility$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Family, Marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Estella'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Village Figure$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Wopsle'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Family, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Pumblechook'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Adopted Daughter, Manipulator/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Estella'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Havisham'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Estella'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Legal Contact$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Estella'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Friendship, Accomplice$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Abel Magwitch'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Hostility, Brief Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Family, Student/Tutor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Matthew Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Friendship, Assistance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Professional, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Professional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Herbert Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Wemmick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Mortal Enemies, Rival Criminals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Abel Magwitch'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Compeyson'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Client, Legal Trustee$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Abel Magwitch'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Accomplice, Transport Helper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Abel Magwitch'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Client, Legal Advisor, Secret Keeper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Havisham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Family, Estrangement, Hostility$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Havisham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Matthew Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Tenant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Havisham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Pumblechook'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Employer, Gate-keeper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Havisham'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Hostility, Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Biddy'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Victim/Assailant, Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Family, Alliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Joe Gargery'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Pumblechook'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Friendship, Assistance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Jaggers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Professional, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Wemmick'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Matthew Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Professional, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Wemmick'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jaggers'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Professional Partnership$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Wemmick'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Orlick'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Former Legal Counsel$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Wemmick'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Compeyson'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Professional Hostility$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Orlick'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Criminal Association$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Startop'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Compeyson'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Pumblechook'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Wopsle'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Startop'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Matthew Pocket'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Student/Tutor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Matthew Pocket'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Startop'
WHERE n.title = 'Great Expectations'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Romeo and Juliet
-- Characters: 16, Relationships: 57
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$Lovers, Secretly Married$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Juliet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Cousins, Best Friends, Confidantes$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Benvolio'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Best Friends, Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mercutio'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Confessor, Spiritual Advisor, Officiant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friar Lawrence'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Master-Servant, Loyal Messenger$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Balthasar'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Messenger, Confidante (for Juliet), Facilitator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nurse'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Mortal Enemies, Adversaries, Kinsman by marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tybalt'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Rivals for Juliet, Enemies, Fought at tomb$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Paris'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Father-Son, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Mother-Son, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Head of Rival Family, Father-in-law (unacknowledged), Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Mother-in-law (unacknowledged), Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Ruler-Subject, Judge$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Transactional (poison)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Apothecary'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Indirectly connected (failed message)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Romeo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friar John'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Confessor, Spiritual Advisor, Conspirator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friar Lawrence'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$Confidante, Surrogate Mother$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nurse'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Cousin, Beloved Kinsman$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tybalt'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Suitor (unwanted), Forced Betrothal$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Paris'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Father-Daughter, Strained Relationship, Disobedient$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Mother-Daughter, Strained Relationship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Juliet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Friends, Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Benvolio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mercutio'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Enemies, Rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Benvolio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tybalt'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Uncle-Nephew, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Benvolio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Aunt-Nephew, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Benvolio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Subject, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Benvolio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Antagonistic, Mockery$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mercutio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nurse'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Enemies, Combatants$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mercutio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tybalt'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Kinsman$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mercutio'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Informational, Transactional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Balthasar'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Collaborators, Confidantes (briefly)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nurse'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Confessor, Marriage Advisor (forced)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Paris'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintances, Spiritual Guide$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintances, Spiritual Guide$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Subject, Witness, Explains events$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Fellow Friars, Colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friar Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friar John'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Servant to Montague's son$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Balthasar'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Subject, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Balthasar'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Facilitator, Advisor (initially)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nurse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Paris'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Servant, Employee$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nurse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Servant, Employee, Confidante (initially)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nurse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Uncle-Nephew, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tybalt'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Aunt-Nephew, Family, Mourned$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tybalt'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Defiance, Authority Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tybalt'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Prospective Son-in-law, Ally$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Paris'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Prospective Son-in-law, Ally$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Paris'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Kinsman$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Paris'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Husband-Wife$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Montague'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Head of Rival Family, Enemy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Heads of Rival Families, Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Subject, Head of family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Heads of Rival Families, Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Heads of Rival Families, Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Subject-Ruler, Concern$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Montague'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Husband-Wife$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Capulet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Capulet'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Subject, Head of family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Capulet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Subject-Ruler, Pleader for Justice$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Capulet'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Prince Escalus'
WHERE n.title = 'Romeo and Juliet'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Moonstone
-- Characters: 16, Relationships: 43
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Lovers, Relatives, Central Plot$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Rachel Verinder'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Confidant, Ally, Master/Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gabriel Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Professional Partner, Ally, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ezra Jennings'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Family, Host/Guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Verinder'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Rival, Antagonist, Relative$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Godfrey Ablewhite'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Legal Counsel, Ally, Family Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bruff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Professional Ally, Investigator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sergeant Cuff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Target, Antagonists, Plot Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Three Indian Brahmins'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Object of Obsession, Unrequited Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Rosanna Spearman'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Causal Agent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Thomas Candy'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Helper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Penelope Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Family, Hostile Narrator, Religious Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Drusilla Clack'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Investigative Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Septimus Luker'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Family, Origin of Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Herncastle'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Social Obstacle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Franklin Blake'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Merridew'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Mistress/Servant, Loyalty, Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gabriel Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Mother/Daughter, Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Verinder'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Engagement, Relatives, Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Godfrey Ablewhite'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Legal Guardian, Advisor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bruff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Suspect/Investigator, Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sergeant Cuff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Mistress/Maid, Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Rosanna Spearman'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Mistress/Maid, Close Friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Penelope Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Relatives, Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Drusilla Clack'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Chaperone, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rachel Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Merridew'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Master/Servant, Loyalty, Long Service$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gabriel Betteredge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Verinder'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Colleague, Pity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gabriel Betteredge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Rosanna Spearman'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Social Interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gabriel Betteredge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Thomas Candy'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Father/Daughter, Affection, Helper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Gabriel Betteredge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Penelope Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Professional Ally, Skeptic/Believer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ezra Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bruff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Professional Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ezra Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Thomas Candy'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Relatives, Host$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Godfrey Ablewhite'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Legal Counsel, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bruff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Employer, Investigator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sergeant Cuff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Family, Religious Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Drusilla Clack'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Sibling, Deep Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Verinder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Herncastle'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Client/Lawyer, Adversarial$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Godfrey Ablewhite'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Bruff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Victim, Murderers, Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Godfrey Ablewhite'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Three Indian Brahmins'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Mutual Deception, Admiration/Manipulation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Godfrey Ablewhite'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Drusilla Clack'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Debtor/Creditor, Adversarial$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Godfrey Ablewhite'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Septimus Luker'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Professional Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Bruff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sergeant Cuff'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Target, Antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Three Indian Brahmins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Septimus Luker'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Ancestral Guardians, Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Three Indian Brahmins'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Herncastle'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Colleagues, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Rosanna Spearman'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Penelope Betteredge'
WHERE n.title = 'The Moonstone'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Emma
-- Characters: 14, Relationships: 60
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.8,
    $desc$Best Friend, Future Spouse, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Father, Daughter, Constant Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Woodhouse'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Friend, Former Governess, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Friend, Protégée, Matchmaker$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Harriet Smith'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Acquaintance, Failed Romantic Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Friend, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Acquaintance, Flirtation, Mutual Deception$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Sister, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Rival in Accomplishment, Later Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Brother-in-law, Family Member$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Mutual Dislike$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Harriet's Guardian$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Emma Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Goddard'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Friend, Son-in-law$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Woodhouse'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Friend, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Benevolent Helper$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Harriet Smith'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Acquaintance, Social Peer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Friend, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Acquaintance, Rival$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Friend, Object of High Esteem$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Brother, Sister$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.8,
    $desc$Brother, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Mutual Contempt$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Friend, Former Governess$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Harriet Smith'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Friend, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.9,
    $desc$Father, Daughter, Constant Concern$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Son-in-law, Frequent Guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Woodhouse'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Friend, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Harriet Smith'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Acquaintance, Social Peer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.9,
    $desc$Husband, Wife, Lover$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Stepmother, Stepson, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Friend, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Friend, Former Charge$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Friend, Family Member$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Romantic Target, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Harriet Smith'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Guest/Host$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Harriet Smith'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Rescued, Rescuer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Harriet Smith'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Friend, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Elton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Weston'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Social Peer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Elton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Elton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Husband, Wife$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Elton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Father, Son$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Frank Churchill'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Friend, Future Daughter-in-law$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Friend, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Weston'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Lovers, Secretly Engaged$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Frank Churchill'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jane Fairfax'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Family Member$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Frank Churchill'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Mutual Disdain$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Frank Churchill'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Aunt, Niece, Constant Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Fairfax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Bates'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Patroness (endured)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jane Fairfax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Elton'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Husband, Wife$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Knightley'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Knightley'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Bates'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Goddard'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Social Peer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Elton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Goddard'
WHERE n.title = 'Emma'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Moby Dick; Or, The Whale
-- Characters: 10, Relationships: 45
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$bosom friends, deep affection, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Queequeg'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$captain/subordinate, fated observer, shipmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ahab'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$shipmates, observer/observed, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Starbuck'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$shipmates, colleagues, brief encounters$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stubb'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Flask'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$observer/mystery, shipmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$shipmates, tragic bond$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ishmael'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$captain/harpooneer, professional duty$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ahab'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$officer/subordinate, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Starbuck'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$headsman/harpooneer, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stubb'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$officer/subordinate, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Flask'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$harpooneer partners, friends, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$harpooneer partners, friends, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, pagan cohort$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, shared fate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Queequeg'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$captain/chief mate, antagonism, conflict of ideology$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Starbuck'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$captain/second mate, professional duty$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stubb'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$captain/third mate, professional duty$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Flask'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$captain/harpooneer, professional reliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$captain/harpooneer, professional reliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.8,
    $desc$fated partners, prophet/disciple, co-conspirators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$dependent/protector, conscience/madman$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ahab'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$mates, colleagues, professional opposition$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Stubb'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$mates, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Flask'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$officer/harpooneer, supervisory$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$officer/harpooneer, supervisory$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$officer/shadow, supervisory$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$officer/crew, pity/concern$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Starbuck'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$mates, friends, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stubb'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Flask'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$mates/harpooneers, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stubb'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$mates/harpooneers, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stubb'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stubb'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$former superior/victim, guilt/indifference$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Stubb'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$officer/harpooneer, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Flask'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tashtego'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$officer/harpooneer, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Flask'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$officer/crew, professional duty$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Flask'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, shared environment$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Flask'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$harpooneer partners, friends, co-workers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tashtego'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daggoo'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$shipmates, pagan cohort$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tashtego'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, close proximity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tashtego'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$shipmates, pagan cohort$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Daggoo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fedallah'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, close proximity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Daggoo'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$shipmates, Ahab's shadows$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fedallah'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Pip'
WHERE n.title = 'Moby Dick; Or, The Whale'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Sense and Sensibility
-- Characters: 17, Relationships: 57
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Sister, Deep Affection, Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Marianne Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Mother-Daughter, Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Lovers, Future Spouses, Protracted Separation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Edward Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Friend, Confidante, Brother-in-law$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Brandon'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Sister$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Margaret Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Half-Siblings, Formal Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Sister-in-law, Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fanny Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Acquaintance, Hostess, Benefactress$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Jennings'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Rivals, False Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lucy Steele'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Sister's Lover, Acquaintance, Confession$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Willoughby'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Cousin, Host, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir John Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Cousin, Social Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Social Acquaintance, Source of Information$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Steele (Anne)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Hostess$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Palmer (Charlotte)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Brother-in-law (eventual), Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Mother-in-law (eventual), Antagonism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elinor Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Mother-Daughter, Intense Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.5,
    $desc$Sister's Lover, Friend/Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Edward Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Admirer, Suitor, Future Husband$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Colonel Brandon'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Sister, Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Margaret Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$Half-Siblings, Distant Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Hostess, Acquaintance (Intrusive)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Jennings'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Lovers, Intense but short engagement, Abandonment$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Willoughby'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Cousin, Host, Admirer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir John Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.0,
    $desc$Social Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.0,
    $desc$Acquaintance, Hostess (mild dislike)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Marianne Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Palmer (Charlotte)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Son, Stepson$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Daughter-in-law, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fanny Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Friend, Hostess, Social Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Jennings'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Cousin, Host, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir John Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    1.5,
    $desc$Potential In-law, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Brother, Patron (potential)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edward Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Sister, Confidante (limited)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edward Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fanny Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Secret Engagement, Fiancée (former)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edward Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lucy Steele'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Brother, Rival (unintentional)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edward Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Mother, Antagonist, Disinheritance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edward Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Friend, Confidante (limited), Social Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Brandon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Jennings'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Rival, Enemy (Eliza Williams affair)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Brandon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Willoughby'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Close Friend, Social Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Brandon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir John Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.0,
    $desc$Social Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Colonel Brandon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Spouses, Mutually Selfish$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Fanny Dashwood'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Son-in-law, Mother-in-law, Alliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Sister-in-law (former rival)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fanny Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lucy Steele'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Brother-in-law (eventual)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fanny Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Daughter, Mother, Close Alliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Fanny Dashwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Daughter's Father-in-law, Friend, Social Planner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir John Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Daughter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Social Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Steele (Anne)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Daughter, Close Relationship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Palmer (Charlotte)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    2.0,
    $desc$Social Acquaintance (brief antagonism over Edward)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Jennings'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Sister, Confidante (low quality)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucy Steele'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Steele (Anne)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Lovers, Future Spouses, Conspiracy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucy Steele'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Daughter-in-law, Manipulative Submission$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucy Steele'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Spouses, Social Partnership$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir John Middleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lady Middleton'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Sister$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lady Middleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Palmer (Charlotte)'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Son, Mother, Favorite, Benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robert Ferrars'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Ferrars'
WHERE n.title = 'Sense and Sensibility'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Twenty Thousand Leagues under the Sea
-- Characters: 4, Relationships: 6
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Loyal servant, Companion, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pierre Aronnax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Conseil'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Companions, Co-prisoners, Friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pierre Aronnax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ned Land'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Captor/Host, Intellectual Colleague, Rival wills$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Pierre Aronnax'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Nemo'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Companions, Friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Conseil'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ned Land'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Captor/Servant, Acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Conseil'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Nemo'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Antagonists, Captor/Prisoner, Rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ned Land'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain Nemo'
WHERE n.title = 'Twenty Thousand Leagues under the Sea'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Adventures of Sherlock Holmes
-- Characters: 20, Relationships: 44
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$Friend, Colleague, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Watson'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Respected Adversary, Subject of Investigation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Irene Adler'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Client$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Wilhelm Gottsreich Sigismond von Ormstein'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Client$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jabez Wilson'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Arch-nemesis, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vincent Spaulding'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Adversary, Exposed$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Windibank'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Subject of Investigation, Confessor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Turner'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Client, Avenged$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Openshaw'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Primary Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain James Calhoun'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Subject of Investigation, Beneficiary of Discretion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Neville St. Clair'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Client$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. St. Clair'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Criminal, Subject of Mercy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Ryder'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Client, Protected$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Helen Stoner'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Mortal Enemy, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Grimesby Roylott'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Client, Rescued$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Victor Hatherley'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Client, Rescued$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alexander Holder'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Villain, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir George Burnwell'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Client, Protected$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Violet Hunter'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Mortal Enemy, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jephro Rucastle'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Irene Adler'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Wilhelm Gottsreich Sigismond von Ormstein'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jabez Wilson'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vincent Spaulding'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Windibank'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Turner'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Openshaw'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain James Calhoun'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Neville St. Clair'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. St. Clair'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'James Ryder'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Helen Stoner'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Grimesby Roylott'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Acquaintance, Introducer, Patient$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Victor Hatherley'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alexander Holder'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir George Burnwell'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Acquaintance, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Violet Hunter'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jephro Rucastle'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Former Lovers, Antagonistic$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Irene Adler'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Wilhelm Gottsreich Sigismond von Ormstein'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Employer-Employee (deceptive), Victim-Perpetrator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jabez Wilson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vincent Spaulding'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Victim-Perpetrator, Mortal Enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Openshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Captain James Calhoun'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Husband-Wife (deceptive)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Neville St. Clair'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. St. Clair'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Stepdaughter-Stepfather, Victim-Abuser$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Helen Stoner'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Grimesby Roylott'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Indirect Association, Adversary (indirect)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alexander Holder'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir George Burnwell'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Employee-Employer, Victim-Abuser$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Violet Hunter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jephro Rucastle'
WHERE n.title = 'The Adventures of Sherlock Holmes'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Hound of the Baskervilles
-- Characters: 13, Relationships: 43
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Professional partners, Friends, Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Watson'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Investigator-Client, Protector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Henry Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Consultant, Professional acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. James Mortimer'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Investigator-Target, Antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jack Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Subject of Posthumous Investigation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Charles Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Investigator-Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Laura Lyons'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Subject of Investigation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Selden'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Professional collaborators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lestrade'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Suspect-Investigator, Informant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Subject of inquiry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Informant, Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beryl Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Employer-Employee, Agent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sherlock Holmes'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cartwright'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Companion, Protector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Henry Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Acquaintance, Professional colleague$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. James Mortimer'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Acquaintance, Investigator-Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jack Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Subject of Investigation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Charles Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Investigator-Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Laura Lyons'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Manhunt Target, Confrontation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Selden'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Professional colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lestrade'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Investigator-Suspect, Confronter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Investigator-Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Acquaintance, Recipient of warning$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beryl Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Colleague of Holmes$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Watson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Cartwright'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Client-Trustee, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. James Mortimer'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Friend-Antagonist, Target$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jack Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Uncle-Nephew, Heir$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Charles Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Master-Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Master-Servant, Recipient of plea$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Love interest, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Henry Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beryl Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintance, Neighbor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. James Mortimer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jack Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Doctor-Patient, Close friends, Trustee$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. James Mortimer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Charles Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. James Mortimer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Laura Lyons'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Colleague at Inquest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. James Mortimer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Acquaintance-Murderer, Rival Heir$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jack Stapleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Charles Baskerville'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Manipulator-Dupe, False Lovers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jack Stapleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Laura Lyons'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Used Pawn$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jack Stapleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Selden'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Husband-Wife, Abuser-Victim, Collaborators$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jack Stapleton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beryl Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Benefactor-Applicant, Rendezvous arranger$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Charles Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Laura Lyons'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Master-Servant, Discovered body$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Charles Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Recipient of warning (indirect)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sir Charles Baskerville'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Beryl Stapleton'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Brother-in-law, Aided escape$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Selden'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Brother-Sister, Protector-Fugitive$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Selden'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Husband-Wife, Co-conspirators (Selden's escape)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Barrymore'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Barrymore'
WHERE n.title = 'The Hound of the Baskervilles'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Dracula
-- Characters: 12, Relationships: 31
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$spouse, lovers, intellectual partners$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mina Harker'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$mortal enemies, captive, victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Count Dracula'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$employer, mentor, benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Peter Hawkins'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$ally, colleague, friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. John Seward'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$ally, friend, comrade$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Arthur Holmwood'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$ally, friend, comrade$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Quincey P. Morris'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$ally, mentor, guide$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$victim, existential threat$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 1 (Fair)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$victim, existential threat$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 2 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$victim, existential threat$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 3 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$hostile encounter, captive environment$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jonathan Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Szgany/Slovaks'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$victim, existential threat, mental thrall$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Count Dracula'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$benefactor, friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Peter Hawkins'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$ally, friend, intellectual partner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. John Seward'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$friend, shared grief$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Arthur Holmwood'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$friend, comforter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Quincey P. Morris'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$ally, student, guide$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mina Harker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$mortal enemies, intellectual rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Count Dracula'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$master, possessor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Count Dracula'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 1 (Fair)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$master, possessor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Count Dracula'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 2 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$master, possessor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Count Dracula'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 3 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$employer, utilitarian relationship$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Count Dracula'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Szgany/Slovaks'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$best friends, colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John Seward'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Arthur Holmwood'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$friends, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John Seward'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Quincey P. Morris'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$colleague, former student/teacher, close friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. John Seward'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$best friends, comrades$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Arthur Holmwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Quincey P. Morris'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$ally, respected elder$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Arthur Holmwood'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$ally, comrade$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Quincey P. Morris'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Professor Van Helsing'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$co-conspirators, vampire coven$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Vampire Sister 1 (Fair)'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 2 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$co-conspirators, vampire coven$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Vampire Sister 1 (Fair)'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 3 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$co-conspirators, vampire coven$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Vampire Sister 2 (Dark)'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Vampire Sister 3 (Dark)'
WHERE n.title = 'Dracula'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Time Machine
-- Characters: 13, Relationships: 18
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Companion, Protector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Weena'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Close Friend, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Narrator'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Mortal Enemies, Antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Morlocks'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Acquaintances, Skeptical Dialogue$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Medical Man'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Acquaintances, Intellectual Dialogue$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Psychologist'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Host/Guest, Antagonistic Skepticism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Editor'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Acquaintances, Intellectual Rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Filby'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Observer/Subject, General Benevolence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Eloi'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintances, Enthusiastic Supporter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Very Young Man'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintances, Passive Listener$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Provincial Mayor'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Host/Guest, Skepticism$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Journalist'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Host/Guest, Passive Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Time Traveller'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Silent Man'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Prey/Predator, Mortal Fear$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Weena'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Morlocks'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Acquaintances, Shared Investigation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Medical Man'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintances, Shared Ride$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Editor'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintances, Mutual Observation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Filby'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Kinship, Community$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Eloi'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Weena'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Prey/Predator, Societal Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Eloi'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Morlocks'
WHERE n.title = 'The Time Machine'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The War of the Worlds
-- Characters: 7, Relationships: 7
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Spouse, Deep Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Narrator''s Wife'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Forced Companion, Conflict, Hostile$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Curate'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Fellow Survivor, Philosophical Opposites, Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Artilleryman'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Family, Brother$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Narrator''s Brother'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Colleague, Early Encounter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ogilvy'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Family, Trusted Guardian$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Narrator''s Cousin'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Family, Host/Guest, Survival Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Narrator''s Wife'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Narrator''s Cousin'
WHERE n.title = 'The War of the Worlds'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Strange Case of Dr. Jekyll and Mr. Hyde
-- Characters: 8, Relationships: 15
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Lifelong friends, Client/Lawyer, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Jekyll'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Investigator/Suspect, Antagonists, Object of loathing$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Hyde'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Old friends, Colleagues$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Lanyon'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Master/Servant, Investigative partners$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Poole'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Kinsman, Acquaintance, Walking companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Enfield'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Employer/Employee, Professional confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Guest'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Client/Lawyer, Acquaintance, Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Utterson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Danvers Carew'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Dual identity, Creator/Creation, Host/Parasite$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Jekyll'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Hyde'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Old friends, Estranged colleagues, Destroyer/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Jekyll'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Lanyon'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Master/Servant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Jekyll'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Poole'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Jekyll'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Enfield'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Tormentor/Witness, Destroyer/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Hyde'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dr. Lanyon'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist/Witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Hyde'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Enfield'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Murderer/Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Hyde'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sir Danvers Carew'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Professional acquaintances, Mutual contact$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Dr. Lanyon'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Poole'
WHERE n.title = 'The Strange Case of Dr. Jekyll and Mr. Hyde'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Life and Adventures of Robinson Crusoe
-- Characters: 20, Relationships: 34
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Master/Servant, Companion, Friend, Rescuer/Rescued$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friday'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Benefactor/Client, Friend, Financial Partner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Portuguese Captain'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Master/Servant, Escape Partner, Seller$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Xury'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Pet/Owner, Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Dog'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Ally, Co-worker, Rescuer/Rescued$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Spaniard'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Companion, Pet/Owner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Poll'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Financial Steward, Benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Old Widow'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Son/Father, Conflict, Guilt$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'RC''s Father'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$Ally, Rescuer/Rescued, Friend$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friday''s Father'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Captor/Slave, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sallee Patron'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.5,
    $desc$Son/Mother, Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'RC''s Mother'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Peer, Negative Influence, Accuser$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hull Companion'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Neighbor, Colleague$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Wells'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Family, Mentor, Business Partner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nephew'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Advisor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Yarmouth Master'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Ally, Comrade in arms, Commander$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mate'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Ally, Comrade in arms, Commander$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Passenger'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Escape Adversary, Slave$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Moor'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Adversary, Commander/Prisoner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Robinson Crusoe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Will Atkins'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Son/Father, Rescued/Rescuer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friday'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friday''s Father'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Allies, Co-workers, Colony Members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friday'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Spaniard'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintances, Professional Contact$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Portuguese Captain'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Old Widow'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Slave/Owner, Adversary$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Xury'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sallee Patron'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Fellow Slave, Escape Partner$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Xury'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Moor'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Allies, Co-workers, Mission Partners$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Spaniard'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Friday''s Father'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Subordinate/Master, Shipmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hull Companion'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Yarmouth Master'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Ally/Adversary, Mutiny Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mate'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Will Atkins'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Ally/Adversary, Mutiny Conflict$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Passenger'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Will Atkins'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Allies, Shipmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mate'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Passenger'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Client/Steward, Professional Contact$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nephew'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Old Widow'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Owner/Slave$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Portuguese Captain'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Xury'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Spouses, Parents$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'RC''s Father'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'RC''s Mother'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Allies, Comrade in arms$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friday'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mate'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Allies, Comrade in arms$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Friday'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Passenger'
WHERE n.title = 'The Life and Adventures of Robinson Crusoe'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Great Gatsby
-- Characters: 11, Relationships: 30
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$friends, confidants, narrator/subject, neighbors$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jay Gatsby'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$romantic interest, acquaintances, confidants$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jordan Baker'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$cousins, acquaintances, confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daisy Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$college acquaintances, husband of cousin, antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$acquaintances, witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Myrtle Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintances, witness$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$business acquaintances, indirect association$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Meyer Wolfshiem'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, funeral organizer/attendee$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Henry C. Gatz'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, shared observers, funeral attendees$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Owl Eyes'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, host's associate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nick Carraway'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Klipspringer'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$acquaintances, confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jordan Baker'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$lovers, former sweethearts, obsessive love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daisy Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$rivals, enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$killer/victim, brief encounter$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Myrtle Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$victim/avenger, murdered$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$business partners, mentor/protégé$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Meyer Wolfshiem'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$father/son$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Henry C. Gatz'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, admirer/host, funeral attendees$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Owl Eyes'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$host/boarder, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jay Gatsby'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Klipspringer'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$close friends, confidantes$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jordan Baker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Daisy Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintances, social circle$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jordan Baker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, entertainer/guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Jordan Baker'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Klipspringer'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$husband/wife, complicated marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Daisy Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Tom Buchanan'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$rivals, killer/victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Daisy Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Myrtle Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, entertainer/guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Daisy Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Klipspringer'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$lovers, affair, exploitative$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Myrtle Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$business acquaintances, customer/garage owner, rival, antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Buchanan'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Meyer Wolfshiem'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$husband/wife, unhappy marriage$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Myrtle Wilson'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'George Wilson'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$shared grief, funeral attendees$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Henry C. Gatz'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Owl Eyes'
WHERE n.title = 'The Great Gatsby'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- The Adventures of Tom Sawyer, Complete
-- Characters: 18, Relationships: 81
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$best friends, blood brothers, adventure companions, treasure hunters$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Huckleberry Finn'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$love interests, engaged, adventure companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Becky Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$best friends, pirate companions, playmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joe Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$aunt-nephew, guardian-ward, disciplinarian, loving$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Aunt Polly'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$sworn enemies, witness-murderer, treasure rivals, source of fear$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Injun Joe'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$half-brothers, antagonistic, rivals$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sid'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$cousins, supportive, kindly figure$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$befrienders, guilt-ridden, witness-framed$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Muff Potter'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$rivals, antagonistic, brief enemies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alfred Temple'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$beneficiary (indirect), acquaintances, guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$acquaintances, hero-revealer (indirect)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jones'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friends, playmates, whitewashing victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Rogers'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$former sweethearts, manipulative flirtation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Amy Lawrence'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, shared grief, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, respected elder, admirer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher, antagonistic, disciplined$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent, authority figure$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Tom Sawyer'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$friends, pirate companions, adventure companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joe Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$witness-murderer, feared enemy, tracker$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Injun Joe'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$household members, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$befrienders, pitying, witness-framed$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Muff Potter'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$beneficiary, adoptee, civilizing influence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$confidant, rescuer, informant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jones'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, traded items, pirate companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Rogers'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community member, shared mourning$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$beneficiary, guardian (financial)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Huckleberry Finn'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$schoolmates, playmates, picnic companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joe Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$schoolmates, friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$brief flirtation, manipulative, rivalry$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alfred Temple'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, social circle, guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$rivals, jealousy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Amy Lawrence'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friend's mother, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$daughter-father, loving family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$student-teacher, disciplined$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Becky Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$schoolmates, shared punishment$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sid'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jones'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friends, playmates, pirate companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ben Rogers'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$schoolmates, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Amy Lawrence'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$son-mother, loving family, disciplinarian$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, guest$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher, disciplined$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Joe Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$aunt-nephew, guardian-ward, loving$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sid'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$aunt-niece, guardian-ward, loving$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$friends, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$friends, shared grief$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community members, parents of friends$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$guardian-teacher, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$church member, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Aunt Polly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$accomplices, murderer-framed victim, manipulator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Injun Joe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Muff Potter'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$antagonist-target, revenge seeker$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Injun Joe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$antagonistic, pursued-pursuer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Injun Joe'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jones'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$cousins, household members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mary'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$guest, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sid'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$guest, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mary'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Widow Douglas'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mary'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$acquaintances, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mary'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mary'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mary'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$accused-judge, official interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Muff Potter'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher, disciplined$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alfred Temple'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alfred Temple'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$rescued-rescuer, grateful$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Widow Douglas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Jones'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$friends, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Widow Douglas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mrs. Harper'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$community leaders, social acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Widow Douglas'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$informant-official, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Jones'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Judge Thatcher'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher, disciplined$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ben Rogers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ben Rogers'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-teacher$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Amy Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$student-superintendent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Amy Lawrence'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$parent-teacher, community members$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$church member, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mrs. Harper'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$community leader, school oversight$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Judge Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Dobbins'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$community leader, church official$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Judge Thatcher'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Walters'
WHERE n.title = 'The Adventures of Tom Sawyer, Complete'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Wuthering Heights
-- Characters: 13, Relationships: 33
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$soulmates, eternal love, intense bond$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$enemies, rivals, tormentor/victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Edgar Linton'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$foster siblings, servant/master, antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nelly Dean'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$foster siblings, bitter enemies, manipulator/victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hindley Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$marital, victim/tormentor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Linton'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$guardian/ward, tormentor, possessive$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hareton Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$father/son, disgust, tool/manipulation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Linton Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$father-in-law/daughter-in-law, manipulator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$adopted son/father, benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$master/servant, religious antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joseph'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$landlord/tenant, initial acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lockwood'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$master/housekeeper, functional$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Zillah'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$husband/wife, lovers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Edgar Linton'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$foster siblings, mistress/servant, confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nelly Dean'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$siblings, childhood friends, estrangement$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hindley Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$sisters-in-law, acquaintances$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Linton'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$daughter/father, beloved child$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$master/servant, loyalty$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edgar Linton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Nelly Dean'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$siblings, protective$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edgar Linton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Isabella Linton'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$father/daughter, devoted$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edgar Linton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$landlord/tenant, business acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Edgar Linton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lockwood'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$foster siblings, servant/master, enduring attachment$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nelly Dean'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hindley Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$foster mother/charge, caretaker, sympathy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nelly Dean'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hareton Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$nurse/charge, caretaker, close bond$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nelly Dean'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$fellow servants, antagonists$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nelly Dean'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joseph'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$narrator/listener, sustained conversation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Nelly Dean'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lockwood'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.5,
    $desc$father/son, neglect, abuse$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hindley Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Hareton Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$son/father, estrangement$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hindley Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Earnshaw'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$mother/son, devotion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Isabella Linton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Linton Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$cousins, friends, eventual lovers$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hareton Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$master/servant, alliance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Hareton Earnshaw'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Joseph'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$cousins, marital, victim/manipulator$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Linton Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Catherine Heathcliff'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$acquaintances, brief encounters$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Catherine Heathcliff'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lockwood'
WHERE n.title = 'Wuthering Heights'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- Frankenstein; Or, The Modern Prometheus
-- Characters: 14, Relationships: 48
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10,
    $desc$Creator, Enemy, Persecutor, Creation, Destroyer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Creature'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Best friends, Confidant, Nurse, Fellow student$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Henry Clerval'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Adopted siblings, Cousins, Fianc
e, Wife, Lovers, Soulmate$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Elizabeth Lavenza'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Father-son, Family, Confidant (to a degree)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alphonse Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Rescuer, Confidant, Listener, Friend, Brother-figure (Walton's perspective), Mentor (Victor's warning)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Walton'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Mother-son, Family, Guiding influence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Brothers, Victim (indirectly), Loved one$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'William Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Family friend, Accused (Victor believes innocent), Victim (indirectly)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Justine Moritz'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Brothers, Family, Shared grief$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Learned about through Creature's narrative, Indirectly influenced by, Symbol of unprejudiced humanity$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Learned about through Creature's narrative, Indirectly influenced by, Agent of Creature's despair$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Felix De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Learned about through Creature's narrative, Indirectly influenced by, Agent of Creature's despair$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Agatha De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Learned about through Creature's narrative, Indirectly influenced by, Agent of Creature's despair$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Victor Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Safie'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Murderer, Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Henry Clerval'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Murderer, Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Elizabeth Lavenza'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Cause of suffering, Indirect murderer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alphonse Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Antagonist (indirect), Confronter, Narrative subject, Confidant (to a degree)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Robert Walton'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Murderer, Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'William Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Framer, Murderer (indirectly), Victim$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Justine Moritz'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Observed, Beneficiary (unknowing), Rejected (by family, not De Lacey himself), Sole kind human interaction$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Observed, Beneficiary (unknowing, learning), Violent rejector, Teacher (indirectly)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Felix De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Observed, Beneficiary (unknowing), Frightened rejector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Agatha De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Observed, Learner (indirectly), Frightened rejector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Safie'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Observed (portrait), Source of Locket (indirect)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Threatened (implicitly), Cause of suffering (indirectly, through William's death)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'The Creature'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Friends, Family (cousins), Confidants$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Henry Clerval'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Elizabeth Lavenza'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5,
    $desc$Family friend, Respected, Protector (of Victor's father's peace of mind)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Henry Clerval'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alphonse Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Family friend, Respected$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Henry Clerval'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Friends, Family (cousins)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Henry Clerval'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Adopted daughter, Father, Caregiver, Consoler$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Lavenza'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Alphonse Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Sister, Caretaker, Loved one$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Lavenza'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'William Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Friends, Quasi-sisters, Defender$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Lavenza'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Justine Moritz'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Adopted daughter, Adoptive mother, Benefactor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Lavenza'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Sister, Caretaker, Loved one$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Elizabeth Lavenza'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Father, Son, Loved one$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alphonse Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'William Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Employer, Guardian, Accused (reluctantly accepted guilt)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alphonse Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Justine Moritz'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Husband-wife, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alphonse Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Father, Son, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Alphonse Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6,
    $desc$Son, Mother, Loved one$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'William Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4,
    $desc$Brothers, Playmates$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'William Frankenstein'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Adopted daughter (informal), Benefactor, Nurse$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Justine Moritz'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Caroline Beaufort Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3,
    $desc$Family friend, Caretaker (implied for younger children), Accused (by society)$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Justine Moritz'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Frankenstein'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Father, Son, Family, Dependence$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Felix De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Father, Daughter, Family, Caregiver$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Agatha De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Adopted daughter, Teacher, Student$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Safie'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8,
    $desc$Brother, Sister, Family$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Felix De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Agatha De Lacey'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9,
    $desc$Lovers, Teacher, Student, Betrothed$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Felix De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Safie'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7,
    $desc$Friends, Quasi-sisters, Companions$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Agatha De Lacey'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Safie'
WHERE n.title = 'Frankenstein; Or, The Modern Prometheus'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;


-- ============================================
-- A Tale of Two Cities
-- Characters: 17, Relationships: 45
-- ============================================

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Spouses, Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Lucie Manette'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Father-in-law, Affection, Gratitude$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Doctor Manette'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Friendship, Rivalry, Savior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sydney Carton'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Friend, Trusted Confidante$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lorry'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Familial Tie, Protected$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Pross'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Conflicted Acquaintance, Denouncer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Mortal Enemy, Victim/Oppressor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Madame Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Antagonist, Legal Opponent$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Roger Cly'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Antagonist, Manipulated Aid$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Barsad'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Uncle/Nephew, Mutual Opposition$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Marquis St. Evrémonde'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Revolutionary Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Vengeance'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Colleague, Legal Counsel, Rival$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Stryver'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Father/Daughter, Familial Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Little Lucie'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Master/Servant, Obligation$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Gabelle'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.5,
    $desc$Acquaintance, Indirect Savior$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jerry Cruncher'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Fellow Prisoner, Sympathy$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Charles Darnay'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Seamstress'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    10.0,
    $desc$Father/Daughter, Primary Affection, Caretaker$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Doctor Manette'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.5,
    $desc$Object of Love, Sympathy, Unrequited Affection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sydney Carton'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.5,
    $desc$Friend, Guardian, Surrogate Father$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lorry'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Adopted Family, Devoted Guardian$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Pross'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Acquaintance, Former Protector$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Enemy, Feared Acquaintance$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Madame Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.8,
    $desc$Mother/Daughter, Familial Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Lucie Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Little Lucie'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Mutual Respect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Sydney Carton'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Long-time Friend, Rescuer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lorry'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.0,
    $desc$Familial Tie, Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Pross'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Former Servant/Master, Revolutionary Ally$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Ernest Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Revolutionary Connection$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Madame Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Grandfather/Granddaughter, Familial Love$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Doctor Manette'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Little Lucie'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Professional Acquaintance, Confidant$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Lorry'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Acquaintance, Mutual Respect$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Pross'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Manipulator/Manipulated, Antagonist$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Barsad'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    7.0,
    $desc$Colleague, Employee/Employer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Stryver'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Necessary Ally, Messenger$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jerry Cruncher'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Brief Emotional Connection, Final Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Sydney Carton'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Seamstress'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    6.5,
    $desc$Household Colleagues, Companion$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Lorry'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Miss Pross'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    3.0,
    $desc$Professional Acquaintance, Advisor$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Lorry'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Mr. Stryver'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Employer/Employee, Odd-job Man$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Mr. Lorry'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jerry Cruncher'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.0,
    $desc$Mortal Enemy, Physical Combatants$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Pross'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Madame Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Sister/Brother, Estrangement, Betrayer$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Miss Pross'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Barsad'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    9.5,
    $desc$Husband/Wife, Revolutionary Partners$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ernest Defarge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Madame Defarge'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Revolutionary Comrades, Political Allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Ernest Defarge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Vengeance'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    8.0,
    $desc$Revolutionary Leader/Lieutenant, Close Political Allies$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Madame Defarge'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'The Vengeance'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    5.0,
    $desc$Former Spy Partners, Accomplices$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'Roger Cly'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'John Barsad'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

INSERT INTO character_relationships (
    novel_id, source_character_id, target_character_id,
    weight, description
)
SELECT
    n.id,
    c1.id,
    c2.id,
    4.0,
    $desc$Mutual Antagonism, Exposed Spy/Gravedigger$desc$
FROM novels n
JOIN characters c1 ON c1.novel_id = n.id AND c1.common_name = 'John Barsad'
JOIN characters c2 ON c2.novel_id = n.id AND c2.common_name = 'Jerry Cruncher'
WHERE n.title = 'A Tale of Two Cities'
ON CONFLICT (source_character_id, target_character_id) DO UPDATE SET
    weight = EXCLUDED.weight,
    description = EXCLUDED.description,
    updated_at = CURRENT_TIMESTAMP;

