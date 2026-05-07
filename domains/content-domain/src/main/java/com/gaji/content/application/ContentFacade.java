package com.gaji.content.application;

import com.gaji.content.domain.model.Book;
import com.gaji.content.domain.model.Novel;
import com.gaji.content.domain.repository.BookRepository;
import com.gaji.content.domain.repository.NovelRepository;
import com.gaji.shared.contract.dto.BookResponse;
import com.gaji.shared.contract.dto.NovelResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ContentFacade {

    private final BookRepository bookRepository;
    private final NovelRepository novelRepository;

    @Transactional(readOnly = true)
    public boolean existsBook(UUID bookId) {
        return bookRepository.findBookById(bookId) != null;
    }

    @Transactional(readOnly = true)
    public Optional<BookResponse> findBookResponseById(UUID bookId) {
        Book book = bookRepository.findBookById(bookId);
        return Optional.ofNullable(book).map(BookResponse::from);
    }

    @Transactional(readOnly = true)
    public boolean existsNovel(UUID novelId) {
        return novelRepository.existsById(novelId);
    }

    @Transactional(readOnly = true)
    public Optional<NovelResponse> findNovelResponseById(UUID novelId) {
        return novelRepository.findById(novelId).map(NovelResponse::from);
    }

    @Transactional(readOnly = true)
    public NovelResponse getNovelResponse(UUID novelId) {
        return findNovelResponseById(novelId)
                .orElseThrow(() -> new IllegalArgumentException("Novel not found: " + novelId));
    }

    @Transactional(readOnly = true)
    public java.util.List<NovelResponse> findAllNovelResponsesByIds(java.util.List<UUID> novelIds) {
        if (novelIds == null || novelIds.isEmpty()) {
            return java.util.Collections.emptyList();
        }
        return novelRepository.findAllById(novelIds).stream()
                .map(NovelResponse::from)
                .collect(java.util.stream.Collectors.toList());
    }
}
