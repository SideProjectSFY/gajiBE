package com.gaji.search.api.controller;

import com.gaji.shared.contract.dto.BookResponse;
import com.gaji.shared.contract.dto.ConversationMessageSearchResponse;
import com.gaji.shared.contract.dto.ConversationResponse;
import com.gaji.shared.contract.dto.SearchResponse;
import com.gaji.shared.contract.dto.UserDTO;
import com.gaji.auth.application.UserFacade;
import com.gaji.chat.application.MessageService;
import com.gaji.content.application.BookService;
import com.gaji.chat.application.ConversationService;
import com.gaji.common.security.CurrentUser;
import com.gaji.common.security.UserPrincipal;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/v1/search")
@RequiredArgsConstructor
@Tag(name = "Search", description = "Global Search API")
public class SearchController {

    private final BookService bookService;
    private final ConversationService conversationService;
    private final MessageService messageService;
    private final UserFacade userFacade;

    @GetMapping
    @Operation(summary = "Global search", description = "Search for books, public conversations, users, and owned conversation message matches")
    public ResponseEntity<SearchResponse> search(
            @CurrentUser(required = false) UserPrincipal currentUser,
            @RequestParam String query,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size
    ) {
        if (query == null || query.trim().isEmpty()) {
            return ResponseEntity.ok(SearchResponse.builder()
                    .books(Collections.emptyList())
                    .conversations(Collections.emptyList())
                    .conversationMessageResults(Collections.emptyList())
                    .users(Collections.emptyList())
                    .build());
        }

        // Search Books with pagination
        Page<BookResponse> booksPage = bookService.findAll(page, size, null, "scenarios", query);
        List<BookResponse> books = booksPage.getContent();

        // Search Conversations with pagination
        List<ConversationResponse> conversations = conversationService.listPublicConversations(query, null, null, page, size);

        // Search Users with pagination
        List<UserDTO> userDTOs = userFacade.searchUsers(query, page, size);

        // Search the authenticated user's own conversation messages.
        List<ConversationMessageSearchResponse> conversationMessageResults =
                currentUser == null || currentUser.getUserId() == null
                        ? Collections.emptyList()
                        : messageService.searchOwnedConversationMessageCards(currentUser, query, size);

        return ResponseEntity.ok(SearchResponse.builder()
                .books(books)
                .conversations(conversations)
                .conversationMessageResults(conversationMessageResults)
                .users(userDTOs)
                .build());
    }
}
