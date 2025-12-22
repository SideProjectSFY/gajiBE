-- V46: Add gutenberg_id column and populate mock data
-- Project Gutenberg ID를 추가하여 로컬 origin_txt 파일과 연결

-- 1. 컬럼 추가
ALTER TABLE novels
ADD COLUMN IF NOT EXISTS gutenberg_id INTEGER UNIQUE;

-- 2. 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_novels_gutenberg_id ON novels(gutenberg_id);

-- 3. Mock 데이터에 gutenberg_id 추가 (로컬 파일과 매칭)
-- 중복 방지: 각 title의 첫 번째 매칭만 업데이트
UPDATE novels SET gutenberg_id = 11 WHERE id = (SELECT id FROM novels WHERE title = 'Alice''s Adventures in Wonderland' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 42 WHERE id = (SELECT id FROM novels WHERE title = 'The Strange Case of Dr Jekyll and Mr Hyde' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1342 WHERE id = (SELECT id FROM novels WHERE title = 'Pride and Prejudice' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1400 WHERE id = (SELECT id FROM novels WHERE title = 'Great Expectations' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 74 WHERE id = (SELECT id FROM novels WHERE title = 'The Adventures of Tom Sawyer' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 84 WHERE id = (SELECT id FROM novels WHERE title = 'Frankenstein' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 345 WHERE id = (SELECT id FROM novels WHERE title = 'Dracula' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 2852 WHERE id = (SELECT id FROM novels WHERE title = 'The Hound of the Baskervilles' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 120 WHERE id = (SELECT id FROM novels WHERE title = 'Treasure Island' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1260 WHERE id = (SELECT id FROM novels WHERE title = 'Jane Eyre' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 768 WHERE id = (SELECT id FROM novels WHERE title = 'Wuthering Heights' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 161 WHERE id = (SELECT id FROM novels WHERE title = 'Sense and Sensibility' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 158 WHERE id = (SELECT id FROM novels WHERE title = 'Emma' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 15 WHERE id = (SELECT id FROM novels WHERE title = 'Moby-Dick' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 64317 WHERE id = (SELECT id FROM novels WHERE title = 'The Great Gatsby' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1661 WHERE id = (SELECT id FROM novels WHERE title = 'The Adventures of Sherlock Holmes' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 98 WHERE id = (SELECT id FROM novels WHERE title = 'A Tale of Two Cities' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 35 WHERE id = (SELECT id FROM novels WHERE title = 'The Time Machine' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 36 WHERE id = (SELECT id FROM novels WHERE title = 'The War of the Worlds' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1257 WHERE id = (SELECT id FROM novels WHERE title = 'The Three Musketeers' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1184 WHERE id = (SELECT id FROM novels WHERE title = 'The Count of Monte Cristo' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 164 WHERE id = (SELECT id FROM novels WHERE title = 'Twenty Thousand Leagues Under the Sea' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 521 WHERE id = (SELECT id FROM novels WHERE title = 'Robinson Crusoe' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 155 WHERE id = (SELECT id FROM novels WHERE title = 'The Moonstone' AND gutenberg_id IS NULL LIMIT 1);
UPDATE novels SET gutenberg_id = 1513 WHERE id = (SELECT id FROM novels WHERE title = 'Romeo and Juliet' AND gutenberg_id IS NULL LIMIT 1);

-- 4. 중복 데이터 제거
-- 같은 제목의 책이 여러 개 있을 경우, gutenberg_id가 있는 것만 남기고 삭제
-- gutenberg_id가 없는 중복도 1개만 남기고 삭제
DELETE FROM novels a
WHERE a.id NOT IN (
    SELECT DISTINCT ON (title) id
    FROM novels
    ORDER BY title, 
             CASE WHEN gutenberg_id IS NOT NULL THEN 0 ELSE 1 END,  -- gutenberg_id 있는 것 우선
             id  -- 같은 우선순위면 첫 번째 id
);

-- 5. 코멘트
COMMENT ON COLUMN novels.gutenberg_id IS 'Project Gutenberg book ID for tracking source';

-- 참고: gutenberg_id가 NULL인 책들도 유지 (프론트엔드 사용 가능)
-- - 1984, The Hobbit, Harry Potter, The Chronicles of Narnia
-- 최종 결과: 29개 책 (24개 gutenberg_id 보유, 5개 NULL)
