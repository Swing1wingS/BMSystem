package com.team29.service;

import com.team29.entity.*;

import java.util.List;

public interface BookService {

    String findBook(String key, String value, Integer page, Integer pageSize, List<Book> bookList, Integer[] amount);

    String addBook(Book book);

    String modifyBook(Book book);

    String deleteBook(String b_Id);

    String borrowBook(BorrowRequest borrowRequest);

    String returnBook(ReturnRequest returnRequest);

    String renewBook(RenewRequest renewRequest);

    String findBookByUser(String uId, Integer page, Integer pageSize, List<BookBorrowRecord> bookBorrowRecordList, Integer[] amount);
}
