-- V35: Create book_likes table
-- Social feature: users can like books

-- Add like_count column to novels table
ALTER TABLE novels ADD COLUMN IF NOT EXISTS like_count INTEGER DEFAULT 0;

-- Create book_likes table
CREATE TABLE book_likes (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    book_id UUID REFERENCES novels(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, book_id)
);

-- Indexes for query performance
CREATE INDEX idx_book_likes_user ON book_likes(user_id);
CREATE INDEX idx_book_likes_book ON book_likes(book_id);
CREATE INDEX idx_book_likes_user_created ON book_likes(user_id, created_at DESC);

-- Add comments for documentation
COMMENT ON TABLE book_likes IS 'User likes on books';
COMMENT ON COLUMN book_likes.user_id IS 'User who liked the book';
COMMENT ON COLUMN book_likes.book_id IS 'Book that was liked';

-- Create trigger to update like_count automatically
CREATE OR REPLACE FUNCTION update_book_like_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE novels
        SET like_count = like_count + 1
        WHERE id = NEW.book_id;
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE novels
        SET like_count = GREATEST(like_count - 1, 0)
        WHERE id = OLD.book_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_book_like_count
AFTER INSERT OR DELETE ON book_likes
FOR EACH ROW
EXECUTE FUNCTION update_book_like_count();
