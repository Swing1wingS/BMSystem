package com.team29.service;

import com.team29.entity.Book;
import org.springframework.stereotype.Service;

import java.util.List;

public interface BookService {

    // 获取所有书籍信息
    List<Book> getAllBooks();
}
