-- Migration: V19__add_search_indexes.sql
-- Enable PostgreSQL full-text search with trigram similarity and GIN indexes
-- Story 3.6: Scenario Search & Advanced Filtering

-- Enable pg_trgm extension for similarity search (handles typos)
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Add tsvector column for full-text search to root_user_scenarios
ALTER TABLE root_user_scenarios
ADD COLUMN search_vector tsvector;

-- Generate initial search_vector from existing descriptive fields
UPDATE root_user_scenarios
SET search_vector =
  to_tsvector('english', coalesce(title, '')) ||
  to_tsvector('english', coalesce(description, '')) ||
  to_tsvector('english', coalesce(what_if_question, '')) ||
  to_tsvector('english', coalesce(character_changes, '')) ||
  to_tsvector('english', coalesce(event_alterations, '')) ||
  to_tsvector('english', coalesce(setting_modifications, ''));

-- Create GIN index for fast full-text search on search_vector
CREATE INDEX idx_root_scenarios_search_vector ON root_user_scenarios USING GIN(search_vector);

-- Create index on created_at for date range filtering and sorting
CREATE INDEX idx_root_scenarios_created_at ON root_user_scenarios(created_at);

-- Trigger function to auto-update search_vector on insert/update
CREATE OR REPLACE FUNCTION root_scenarios_search_vector_trigger()
RETURNS trigger AS $$
BEGIN
  NEW.search_vector :=
    to_tsvector('english', coalesce(NEW.title, '')) ||
    to_tsvector('english', coalesce(NEW.description, '')) ||
    to_tsvector('english', coalesce(NEW.what_if_question, '')) ||
    to_tsvector('english', coalesce(NEW.character_changes, '')) ||
    to_tsvector('english', coalesce(NEW.event_alterations, '')) ||
    to_tsvector('english', coalesce(NEW.setting_modifications, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to auto-update search_vector
CREATE TRIGGER root_scenarios_search_vector_update
BEFORE INSERT OR UPDATE ON root_user_scenarios
FOR EACH ROW
EXECUTE FUNCTION root_scenarios_search_vector_trigger();

-- Create index on user_id for creator filtering
CREATE INDEX idx_root_scenarios_user_id ON root_user_scenarios(user_id);

-- Repeat for leaf_user_scenarios (optional: only if we want to search forked scenarios)
ALTER TABLE leaf_user_scenarios
ADD COLUMN search_vector tsvector;

-- Add optional scenario_category column to align with filtering needs
ALTER TABLE leaf_user_scenarios
ADD COLUMN IF NOT EXISTS scenario_category VARCHAR(32);

UPDATE leaf_user_scenarios
SET search_vector =
  to_tsvector('english', coalesce(title, '')) ||
  to_tsvector('english', coalesce(description, '')) ||
  to_tsvector('english', coalesce(what_if_question, ''));

CREATE INDEX idx_leaf_scenarios_search_vector ON leaf_user_scenarios USING GIN(search_vector);

CREATE OR REPLACE FUNCTION leaf_scenarios_search_vector_trigger()
RETURNS trigger AS $$
BEGIN
  NEW.search_vector :=
    to_tsvector('english', coalesce(NEW.title, '')) ||
    to_tsvector('english', coalesce(NEW.description, '')) ||
    to_tsvector('english', coalesce(NEW.what_if_question, ''));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER leaf_scenarios_search_vector_update
BEFORE INSERT OR UPDATE ON leaf_user_scenarios
FOR EACH ROW
EXECUTE FUNCTION leaf_scenarios_search_vector_trigger();

-- Add comment for documentation
COMMENT ON COLUMN root_user_scenarios.search_vector IS 'Full-text search vector (auto-generated from title, description, what_if_question, and scenario detail fields)';
COMMENT ON INDEX idx_root_scenarios_search_vector IS 'GIN index for fast full-text search';

COMMENT ON COLUMN leaf_user_scenarios.search_vector IS 'Full-text search vector (auto-generated from title, description, what_if_question)';
COMMENT ON COLUMN leaf_user_scenarios.scenario_category IS 'Optional category label for leaf scenarios';
