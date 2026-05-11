package com.gaji.shared.contract.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SearchResponse {
    private List<BookResponse> books;
    private List<ConversationResponse> conversations;
    private List<ConversationMessageSearchResponse> conversationMessageResults;
    private List<UserDTO> users;
}
