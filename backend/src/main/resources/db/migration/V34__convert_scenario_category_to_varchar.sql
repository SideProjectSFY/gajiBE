-- V34: Convert scenario_category from ENUM to VARCHAR
-- Reason: Hibernate @Enumerated has issues with PostgreSQL custom ENUM types
-- Using VARCHAR(50) allows JPA @Enumerated(EnumType.STRING) to work properly

-- Step 1: Drop the index that uses the ENUM column
DROP INDEX IF EXISTS idx_root_scenarios_category;

-- Step 2: Convert column to VARCHAR
ALTER TABLE root_user_scenarios
ALTER COLUMN scenario_category TYPE VARCHAR(50) USING scenario_category::text;

-- Step 3: Recreate index on VARCHAR column
CREATE INDEX idx_root_scenarios_category ON root_user_scenarios(scenario_category);

-- Step 4: Drop the ENUM type (no longer needed)
DROP TYPE IF EXISTS scenario_category;
