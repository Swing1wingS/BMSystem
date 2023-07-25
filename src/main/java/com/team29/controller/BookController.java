package com.team29.controller;

import com.team29.entity.*;
import com.team29.service.BookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
public class BookController {

    @Autowired
    BookService bookService;

    /* 查询图书 */
    @RequestMapping(value = "/books", method = RequestMethod.GET)
    public Result findBook(@RequestParam("key") String key,
                           @RequestParam("value") String value,
                           @RequestParam("page") Integer page,
                           @RequestParam("pageSize") Integer pageSize) {
        List<Book> bookList = new ArrayList<>();
        Integer[] amount = {0};
        String msg = bookService.findBook(key, value, page, pageSize, bookList, amount);
        BookResponse bookResponse = new BookResponse(amount[0], bookList);
        return msg == "success" ? Result.success(bookResponse) : Result.fail(msg);
    }

    /* 录入图书 */
    @RequestMapping(value = "/add_book", method = RequestMethod.POST)
    public Result addBook(@RequestBody Book book) {
        String msg = bookService.addBook(book);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 图书修改 */
    @RequestMapping(value = "/modify_book", method = RequestMethod.PATCH)
    public Result modifyBook(@RequestBody Book book) {
        String msg = bookService.modifyBook(book);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 图书删除 */
    @RequestMapping(value = "/delete_book/{b_Id}", method = RequestMethod.DELETE)
    public Result deleteBook(@PathVariable String b_Id) {
        String msg = bookService.deleteBook(b_Id);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 借阅图书 */
    @RequestMapping(value = "/borrow", method = RequestMethod.POST)
    public Result borrowBook(@RequestBody BorrowRequest borrowRequest) {
        String msg = bookService.borrowBook(borrowRequest);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 归还图书 */
    @RequestMapping(value = "/return", method = RequestMethod.POST)
    public Result returnBook(@RequestBody ReturnRequest returnRequest) {
        String msg = bookService.returnBook(returnRequest);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 续借图书 */
    @RequestMapping(value = "/renew", method = RequestMethod.POST)
    public Result renewBook(@RequestBody RenewRequest renewRequest) {
        String msg = bookService.renewBook(renewRequest);
        return msg == "success" ? Result.success() : Result.fail(msg);
    }

    /* 查询借阅记录 */
    @RequestMapping(value = "/borrow_records", method = RequestMethod.GET)
    public Result queryBookRecord(@RequestParam("u_id") String u_Id,
                                  @RequestParam("page") Integer page,
                                  @RequestParam("pageSize") Integer pageSize) {
        List<BookBorrowRecord> bookBorrowRecordList = new ArrayList<>();
        Integer[] amount = {0};
        String msg = bookService.findBookByUser(u_Id, page, pageSize, bookBorrowRecordList, amount);
        BorrowRecordResponse borrowRecordResponse = new BorrowRecordResponse(amount[0], bookBorrowRecordList);
        return msg == "success" ? Result.success(borrowRecordResponse) : Result.fail(msg);
    }
}
