package com.team29.service.impl;

import com.team29.dao.BookDao;
import com.team29.entity.Book;
import com.team29.entity.BookQueryRequest;
import com.team29.service.BookQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookQueryServiceImpl implements BookQueryService {
    @Autowired
    BookDao bookDao;

    @Override
    public List<Book> findBook(BookQueryRequest bookQueryRequest) {
        String id = bookQueryRequest.getId();
        return null;

    }
}
