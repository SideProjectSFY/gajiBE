package com.gaji.chat.infrastructure.persistence;

import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class MessageRepositoryImpl implements MessageRepository {

    private final MessageJpaRepository jpaRepository;

    @Override
    public Message save(Message message) {
        return jpaRepository.save(message);
    }

    @Override
    public List<Message> saveAll(Iterable<Message> messages) {
        return jpaRepository.saveAll(messages);
    }

    @Override
    public Optional<Message> findById(UUID id) {
        return jpaRepository.findById(id);
    }

    @Override
    public void deleteById(UUID id) {
        jpaRepository.deleteById(id);
    }

    @Override
    public List<Message> findByConversationId(UUID conversationId) {
        return jpaRepository.findByConversationId(conversationId);
    }

    @Override
    public List<Message> findRecentByConversationId(UUID conversationId, Pageable pageable) {
        return jpaRepository.findRecentByConversationId(conversationId, pageable);
    }
}
