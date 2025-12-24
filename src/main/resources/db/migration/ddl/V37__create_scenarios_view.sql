-- Create scenarios view combining all scenario types
-- This view is used by the BookMapper for counting scenarios per book
-- base_scenarios don't have what_if_question or is_private, so we provide defaults
-- leaf_user_scenarios don't have novel_id, so we join with root_user_scenarios to get it

CREATE OR REPLACE VIEW scenarios AS
SELECT 
    id,
    novel_id,
    title,
    NULL::text AS what_if_question,
    false AS is_private,
    created_at,
    updated_at,
    creator_id AS user_id,
    'base' AS scenario_type
FROM base_scenarios

UNION ALL

SELECT 
    id,
    novel_id,
    title,
    what_if_question,
    is_private,
    created_at,
    updated_at,
    user_id,
    'root' AS scenario_type
FROM root_user_scenarios

UNION ALL

SELECT 
    l.id,
    r.novel_id,
    l.title,
    l.what_if_question,
    l.is_private,
    l.created_at,
    l.updated_at,
    l.user_id,
    'leaf' AS scenario_type
FROM leaf_user_scenarios l
INNER JOIN root_user_scenarios r ON l.parent_scenario_id = r.id;
