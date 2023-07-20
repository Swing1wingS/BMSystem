package com.team29.service.impl;

import com.team29.dao.BookDao;
import com.team29.entity.Book;
import com.team29.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.gson.GsonProperties;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    BookDao bookDao;

    @Override
    public List<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }
}
