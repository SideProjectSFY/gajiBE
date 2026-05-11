package com.gaji.chat.application;

import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndex;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.content.application.ContentFacade;
import com.gaji.scenario.application.ScenarioFacade;
import com.gaji.shared.contract.dto.UpdateConversationRequest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ConversationServiceIndexSyncTest {

    @Mock
    private ConversationRepository conversationRepository;
    @Mock
    private MessageRepository messageRepository;
    @Mock
    private ConversationMessageSearchIndex conversationMessageSearchIndex;
    @Mock
    private ScenarioFacade scenarioFacade;
    @Mock
    private ContentFacade contentFacade;

    @Test
    void updateConversationSyncsTitleAndVisibilityToSearchIndex() {
        UUID conversationId = UUID.randomUUID();
        Conversation conversation = Conversation.builder()
                .id(conversationId)
                .userId(UUID.randomUUID())
                .scenarioId(UUID.randomUUID())
                .title("Before")
                .isPrivate(false)
                .build();
        when(conversationRepository.findById(conversationId)).thenReturn(Optional.of(conversation));

        service().updateConversation(
                conversationId,
                UpdateConversationRequest.builder()
                        .title("After")
                        .isPrivate(true)
                        .build()
        );

        verify(conversationRepository).save(conversation);
        verify(conversationMessageSearchIndex).updateConversationTitle(conversationId, "After");
        verify(conversationMessageSearchIndex).updateConversationVisibility(conversationId, true);
    }

    @Test
    void updateConversationDoesNotSyncVisibilityWhenItDoesNotChange() {
        UUID conversationId = UUID.randomUUID();
        Conversation conversation = Conversation.builder()
                .id(conversationId)
                .userId(UUID.randomUUID())
                .scenarioId(UUID.randomUUID())
                .title("Before")
                .isPrivate(true)
                .build();
        when(conversationRepository.findById(conversationId)).thenReturn(Optional.of(conversation));

        service().updateConversation(
                conversationId,
                UpdateConversationRequest.builder()
                        .isPrivate(true)
                        .build()
        );

        verify(conversationMessageSearchIndex, never()).updateConversationTitle(conversationId, "Before");
        verify(conversationMessageSearchIndex, never()).updateConversationVisibility(conversationId, true);
    }

    @Test
    void deleteConversationDeletesSearchDocuments() {
        UUID conversationId = UUID.randomUUID();
        Conversation conversation = Conversation.builder()
                .id(conversationId)
                .userId(UUID.randomUUID())
                .scenarioId(UUID.randomUUID())
                .title("Conversation")
                .build();
        when(conversationRepository.findById(conversationId)).thenReturn(Optional.of(conversation));

        service().deleteConversation(conversationId);

        verify(conversationRepository).deleteById(conversationId);
        verify(conversationMessageSearchIndex).deleteConversation(conversationId);
    }

    private ConversationService service() {
        return new ConversationService(
                conversationRepository,
                messageRepository,
                conversationMessageSearchIndex,
                scenarioFacade,
                contentFacade
        );
    }
}
