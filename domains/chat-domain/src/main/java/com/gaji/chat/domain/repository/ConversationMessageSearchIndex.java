package com.gaji.chat.domain.repository;

import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;

import java.util.List;
import java.util.UUID;

public interface ConversationMessageSearchIndex {

    boolean isEnabled();

    void indexMessage(Conversation conversation, Message message);

    default void indexMessages(Conversation conversation, List<Message> messages) {
        messages.forEach(message -> indexMessage(conversation, message));
    }

    default void deleteMessage(UUID messageId) {
    }

    default void deleteConversation(UUID conversationId) {
    }

    default void updateConversationTitle(UUID conversationId, String title) {
    }

    default void updateConversationVisibility(UUID conversationId, boolean isPrivate) {
    }

    default int retryFailedOperations() {
        return 0;
    }

    List<ConversationMessageSearchIndexHit> searchOwnedConversationMessageCards(
            UUID userId,
            String query,
            int limit
    );
}
