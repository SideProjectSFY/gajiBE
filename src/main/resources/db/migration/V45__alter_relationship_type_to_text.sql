-- V45: Alter relationship_type to TEXT for longer descriptions
ALTER TABLE character_relationships
    ALTER COLUMN relationship_type TYPE TEXT;

