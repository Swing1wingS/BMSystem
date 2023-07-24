package com.team29.service;

import com.team29.entity.Book;
import com.team29.entity.BookQueryRequest;

import java.util.List;

public interface BookQueryService {
    List<Book> findBook(BookQueryRequest bookQueryRequest);
}
