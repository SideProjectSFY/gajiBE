package com.gaji.chat.application;

import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.gaji.chat.domain.repository.MessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ConversationFacade {

    private final ConversationRepository conversationRepository;
    private final MessageRepository messageRepository;

    @Transactional(readOnly = true)
    public boolean existsById(UUID conversationId) {
        return conversationRepository.existsById(conversationId);
    }

    @Transactional(readOnly = true)
    public Optional<Conversation> findById(UUID conversationId) {
        return conversationRepository.findById(conversationId);
    }

    @Transactional(readOnly = true)
    public Conversation getById(UUID conversationId) {
        return conversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));
    }

    @Transactional
    public void incrementLikeCount(UUID conversationId) {
        conversationRepository.incrementLikeCount(conversationId);
    }

    @Transactional
    public void decrementLikeCount(UUID conversationId) {
        conversationRepository.decrementLikeCount(conversationId);
    }

    @Transactional(readOnly = true)
    public List<Message> findMessagesByConversationId(UUID conversationId) {
        return messageRepository.findByConversationId(conversationId);
    }

    @Transactional
    public UUID saveAIMessage(UUID conversationId, String content) {
        if (!conversationRepository.existsById(conversationId)) {
            throw new com.gaji.common.exception.ResourceNotFoundException("Conversation not found: " + conversationId);
        }

        Message aiMessage = new Message();
        aiMessage.setConversationId(conversationId);
        aiMessage.setRole("assistant");
        aiMessage.setContent(content);

        messageRepository.save(aiMessage);
        conversationRepository.incrementMessageCount(conversationId);

        return aiMessage.getId();
    }

    @Transactional(readOnly = true)
    public Optional<Conversation> findFirstByScenarioId(UUID scenarioId) {
        return conversationRepository.findFirstByScenarioIdOrderByCreatedAtAsc(scenarioId);
    }

    @Transactional(readOnly = true)
    public List<Conversation> findAllById(List<UUID> ids) {
        return conversationRepository.findAllById(ids);
    }
}
