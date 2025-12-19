-- V40: User Mock Data for Testing and Development
-- Adding test users with known credentials for development and E2E testing
-- Password for all test users: "password123" (BCrypt hash with strength 12)
-- Hash: $2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC

INSERT INTO users (id, email, username, password_hash, bio, avatar_url, created_at, updated_at) VALUES
  -- Main test users with distinct personas
  (
    '550e8400-e29b-41d4-a716-446655440001',
    'jane.austen@gaji.com',
    'jane_austen',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Lover of classic literature and romantic tales. Currently exploring Pride and Prejudice scenarios.',
    'https://i.pravatar.cc/150?img=1',
    '2025-01-01 10:00:00',
    '2025-01-01 10:00:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440002',
    'sherlock.holmes@gaji.com',
    'detective_holmes',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Master detective and mystery enthusiast. Investigating the most intriguing plot twists in literature.',
    'https://i.pravatar.cc/150?img=12',
    '2025-01-02 11:30:00',
    '2025-01-02 11:30:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440003',
    'fantasy.lover@gaji.com',
    'fantasy_explorer',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Lost in fantastical worlds. Currently diving deep into Tolkien and Rowling universes.',
    'https://i.pravatar.cc/150?img=25',
    '2025-01-03 09:15:00',
    '2025-01-03 09:15:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440004',
    'horror.fan@gaji.com',
    'midnight_reader',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Gothic horror enthusiast. Reading Dracula and Frankenstein under the moonlight.',
    'https://i.pravatar.cc/150?img=33',
    '2025-01-04 23:45:00',
    '2025-01-04 23:45:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440005',
    'scifi.geek@gaji.com',
    'time_traveler',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Science fiction aficionado. Exploring alternate timelines in classic sci-fi literature.',
    'https://i.pravatar.cc/150?img=45',
    '2025-01-05 14:20:00',
    '2025-01-05 14:20:00'
  ),
  
  -- Additional test users for various scenarios
  (
    '550e8400-e29b-41d4-a716-446655440006',
    'book.collector@gaji.com',
    'book_collector',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Avid reader with a diverse collection spanning all genres. Always seeking the next great story.',
    'https://i.pravatar.cc/150?img=52',
    '2025-01-06 08:00:00',
    '2025-01-06 08:00:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440007',
    'new.reader@gaji.com',
    'new_reader',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Just started my journey into interactive literature. Excited to explore!',
    'https://i.pravatar.cc/150?img=60',
    '2025-01-10 16:30:00',
    '2025-01-10 16:30:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440008',
    'story.writer@gaji.com',
    'story_weaver',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Aspiring writer learning from the masters. Creating my own alternative storylines.',
    'https://i.pravatar.cc/150?img=15',
    '2025-01-07 12:45:00',
    '2025-01-07 12:45:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440009',
    'history.buff@gaji.com',
    'history_enthusiast',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Historical fiction lover. Reimagining pivotal moments in classic literature.',
    'https://i.pravatar.cc/150?img=27',
    '2025-01-08 10:10:00',
    '2025-01-08 10:10:00'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440010',
    'test.user@gaji.com',
    'test_user',
    '$2b$12$yyWWM.U.dFk5swMLsaYLBuFIe2x8N8shIcSTFl7Y9aNaH2PXze6rC', -- password123
    'Test account for E2E testing and development purposes.',
    'https://i.pravatar.cc/150?img=70',
    '2025-01-09 13:00:00',
    '2025-01-09 13:00:00'
  );

-- Add comments for documentation
COMMENT ON TABLE users IS 'Mock user data: All test users have password "password123" (BCrypt strength 12)';
