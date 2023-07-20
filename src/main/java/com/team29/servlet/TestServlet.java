package com.team29.servlet;

import com.team29.entity.Book;
import com.team29.entity.BorrowRecord;
import com.team29.entity.Result;
import com.team29.entity.User;
import com.team29.service.BookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@RestController
public class TestServlet {

    @Autowired
    private BookService bookService;

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public Result test() {
        //List<Book> bookList = bookService.getAllBooks();

        //log.info(bookList.toString());

        //Date date = new Date(System.currentTimeMillis());
//
//        List<BorrowRecord> brList = new ArrayList<>();
//        BorrowRecord br0 = new BorrowRecord();
//        br0.setBr_B_Id("012345678901");
//        br0.setBr_U_Id("012345678901");
//        br0.setBr_Borrow_Date(new Date(System.currentTimeMillis()));
//        br0.setBr_Return_Date(new Date(System.currentTimeMillis()));
//        brList.add(br0);
//
//        br0.setBr_B_Id("012312674351");
//        br0.setBr_U_Id("102235435891");
//        br0.setBr_Borrow_Date(new Date(System.currentTimeMillis()));
//        br0.setBr_Return_Date(new Date(System.currentTimeMillis()));
//        brList.add(br0);

        User u = new User();
        u.setU_Id("012345678901");
        u.setU_Name("JYX");
        u.setU_Email("123@qq.com");
        u.setU_Password("123");
        u.setU_Gender("男");
        u.setU_Phone("12345678901");

        return Result.success(u);
    }

}
