package com.gaji.chat.application;

import com.gaji.ai.application.AiChatProxyService;
import com.gaji.chat.domain.model.Conversation;
import com.gaji.chat.domain.model.Message;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndex;
import com.gaji.chat.domain.repository.ConversationMessageSearchIndexHit;
import com.gaji.chat.domain.repository.ConversationMessageSearchResult;
import com.gaji.chat.domain.repository.ConversationRepository;
import com.gaji.chat.domain.repository.MessageRepository;
import com.gaji.chat.domain.repository.RagChatTurnMetadataRepository;
import com.gaji.common.security.UserPrincipal;
import com.gaji.content.application.ContentReadFacade;
import com.gaji.scenario.application.ScenarioFacade;
import com.gaji.shared.contract.dto.ConversationMessageSearchResponse;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.support.TransactionTemplate;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class MessageServiceConversationSearchTest {

    @Mock
    private ConversationRepository conversationRepository;
    @Mock
    private MessageRepository messageRepository;
    @Mock
    private ConversationFacade conversationFacade;
    @Mock
    private RedisTemplate<String, String> redisTemplate;
    @Mock
    private ScenarioFacade scenarioFacade;
    @Mock
    private ContentReadFacade contentReadFacade;
    @Mock
    private AiChatProxyService aiChatProxyService;
    @Mock
    private TransactionTemplate transactionTemplate;
    @Mock
    private RagChatTurnMetadataRepository ragChatTurnMetadataRepository;
    @Mock
    private ConversationMessageSearchIndex conversationMessageSearchIndex;

    @Test
    void conversationMessageSearchUsesElasticsearchIndexWhenEnabled() {
        UUID userId = UUID.randomUUID();
        UUID conversationId = UUID.randomUUID();
        UUID messageId = UUID.randomUUID();
        LocalDateTime now = LocalDateTime.now();
        Message recent = Message.builder()
                .id(messageId)
                .conversationId(conversationId)
                .role("assistant")
                .content("Darcy explains the letter.")
                .createdAt(now)
                .build();
        when(conversationMessageSearchIndex.isEnabled()).thenReturn(true);
        when(conversationMessageSearchIndex.searchOwnedConversationMessageCards(userId, "Darcy", 6))
                .thenReturn(List.of(new ConversationMessageSearchIndexHit(
                        conversationId,
                        "Chatting with Elizabeth",
                        4,
                        now,
                        "Darcy letter"
                )));
        when(messageRepository.findRecentByConversationId(eq(conversationId), any(Pageable.class)))
                .thenReturn(List.of(recent));

        List<ConversationMessageSearchResponse> responses = service()
                .searchOwnedConversationMessageCards(principal(userId), "Darcy", 6);

        assertThat(responses).hasSize(1);
        assertThat(responses.get(0).getConversationId()).isEqualTo(conversationId);
        assertThat(responses.get(0).getMessageHitCount()).isEqualTo(4);
        assertThat(responses.get(0).getRecentMessages()).hasSize(1);
        assertThat(responses.get(0).getRecentMessages().get(0).getMessageId()).isEqualTo(messageId);
        verify(messageRepository, never()).searchOwnedConversationMessageCards(any(), any(), anyInt());
    }

    @Test
    void conversationMessageSearchFallsBackToPostgresWhenElasticsearchFails() {
        UUID userId = UUID.randomUUID();
        UUID conversationId = UUID.randomUUID();
        LocalDateTime now = LocalDateTime.now();
        when(conversationMessageSearchIndex.isEnabled()).thenReturn(true);
        when(conversationMessageSearchIndex.searchOwnedConversationMessageCards(userId, "Darcy", 6))
                .thenThrow(new RuntimeException("elasticsearch unavailable"));
        when(messageRepository.searchOwnedConversationMessageCards(userId, "Darcy", 6))
                .thenReturn(List.of(new ConversationMessageSearchResult(
                        conversationId,
                        "Fallback conversation",
                        2,
                        now,
                        "Darcy appears in PostgreSQL fallback",
                        List.of()
                )));

        List<ConversationMessageSearchResponse> responses = service()
                .searchOwnedConversationMessageCards(principal(userId), "Darcy", 6);

        assertThat(responses).hasSize(1);
        assertThat(responses.get(0).getConversationTitle()).isEqualTo("Fallback conversation");
        verify(messageRepository).searchOwnedConversationMessageCards(userId, "Darcy", 6);
    }

    @Test
    void deleteMessageDeletesDatabaseRowAndSearchDocument() {
        UUID userId = UUID.randomUUID();
        UUID conversationId = UUID.randomUUID();
        UUID messageId = UUID.randomUUID();
        Conversation conversation = Conversation.builder()
                .id(conversationId)
                .userId(userId)
                .scenarioId(UUID.randomUUID())
                .title("Reader notes")
                .messageCount(3)
                .build();
        Message message = Message.builder()
                .id(messageId)
                .conversationId(conversationId)
                .role("user")
                .content("Darcy interpretation")
                .createdAt(LocalDateTime.now())
                .build();
        when(conversationRepository.findById(conversationId)).thenReturn(Optional.of(conversation));
        when(messageRepository.findById(messageId)).thenReturn(Optional.of(message));

        service().deleteMessage(conversationId, messageId, principal(userId));

        verify(messageRepository).deleteById(messageId);
        verify(conversationRepository).updateMessageCount(conversationId, 2);
        verify(conversationMessageSearchIndex).deleteMessage(messageId);
    }

    private MessageService service() {
        return new MessageService(
                conversationRepository,
                messageRepository,
                conversationFacade,
                redisTemplate,
                scenarioFacade,
                contentReadFacade,
                aiChatProxyService,
                transactionTemplate,
                ragChatTurnMetadataRepository,
                conversationMessageSearchIndex
        );
    }

    private UserPrincipal principal(UUID userId) {
        return UserPrincipal.builder()
                .userId(userId)
                .email("reader@example.com")
                .username("reader")
                .role("USER")
                .build();
    }
}
