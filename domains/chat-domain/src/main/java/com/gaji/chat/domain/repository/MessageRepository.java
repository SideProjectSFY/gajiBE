package com.gaji.chat.domain.repository;

import com.gaji.chat.domain.model.Message;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MessageRepository {

    Message save(Message message);

    List<Message> saveAll(Iterable<Message> messages);

    Optional<Message> findById(UUID id);
    
    void deleteById(UUID id);

    List<Message> findByConversationId(UUID conversationId);

    List<Message> findRecentByConversationId(UUID conversationId, Pageable pageable);

    List<MessageSearchResult> searchOwnedMessages(UUID userId, String query, Pageable pageable);

    List<MessageSearchResult> searchOwnedMessagesInConversation(
            UUID userId,
            UUID conversationId,
            String query,
            Pageable pageable
    );

    List<ConversationMessageSearchResult> searchOwnedConversationMessageCards(
            UUID userId,
            String query,
            int limit
    );
}

