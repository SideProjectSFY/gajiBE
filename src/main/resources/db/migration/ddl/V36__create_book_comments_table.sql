-- V36: Create book_comments table
-- Social feature: users can comment on books

CREATE TABLE book_comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    book_id UUID NOT NULL REFERENCES novels(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL CHECK (LENGTH(content) >= 1 AND LENGTH(content) <= 1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for query performance
CREATE INDEX idx_book_comments_book_id ON book_comments(book_id, created_at DESC);
CREATE INDEX idx_book_comments_user_id ON book_comments(user_id);

-- Add comments for documentation
COMMENT ON TABLE book_comments IS 'User comments on books';
COMMENT ON COLUMN book_comments.book_id IS 'Book being commented on';
COMMENT ON COLUMN book_comments.user_id IS 'User who wrote the comment';
COMMENT ON COLUMN book_comments.content IS 'Comment text (1-1000 characters)';
