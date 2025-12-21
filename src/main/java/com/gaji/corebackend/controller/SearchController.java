package com.gaji.corebackend.controller;

import com.gaji.corebackend.dto.BookResponse;
import com.gaji.corebackend.dto.ConversationResponse;
import com.gaji.corebackend.dto.SearchResponse;
import com.gaji.corebackend.dto.UserDTO;
import com.gaji.corebackend.entity.User;
import com.gaji.corebackend.mapper.UserMapper;
import com.gaji.corebackend.service.BookService;
import com.gaji.corebackend.service.ConversationService;
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
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/search")
@RequiredArgsConstructor
@Tag(name = "Search", description = "Global Search API")
public class SearchController {

    private final BookService bookService;
    private final ConversationService conversationService;
    private final UserMapper userMapper;

    @GetMapping
    @Operation(summary = "Global search", description = "Search for books, conversations, and users")
    public ResponseEntity<SearchResponse> search(
            @RequestParam String query,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "6") int size
    ) {
        if (query == null || query.trim().isEmpty()) {
            return ResponseEntity.ok(SearchResponse.builder()
                    .books(Collections.emptyList())
                    .conversations(Collections.emptyList())
                    .users(Collections.emptyList())
                    .build());
        }

        // Search Books with pagination
        Page<BookResponse> booksPage = bookService.findAll(page, size, null, "scenarios", query);
        List<BookResponse> books = booksPage.getContent();

        // Search Conversations with pagination
        List<ConversationResponse> conversations = conversationService.listPublicConversations(query, null, null, page, size);

        // Search Users with pagination
        List<User> users = userMapper.searchUsers(query);
        List<UserDTO> userDTOs = users.stream()
                .skip((long) page * size)
                .limit(size)
                .map(user -> UserDTO.builder()
                        .id(user.getId())
                        .username(user.getUsername())
                        .email(user.getEmail())
                        .bio(user.getBio())
                        .avatarUrl(user.getAvatarUrl())
                        .build())
                .collect(Collectors.toList());

        return ResponseEntity.ok(SearchResponse.builder()
                .books(books)
                .conversations(conversations)
                .users(userDTOs)
                .build());
    }
}
