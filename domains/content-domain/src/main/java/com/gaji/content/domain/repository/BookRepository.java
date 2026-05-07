package com.gaji.content.domain.repository;

import com.gaji.content.domain.model.Book;
import java.util.List;
import java.util.UUID;

public interface BookRepository {
    List<Book> findBooks(int offset, int limit, String genre, String sort, String search);
    int countBooks(String genre);
    Book findBookById(UUID id);
}
