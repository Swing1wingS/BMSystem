package com.team29.service.impl;

import com.team29.dao.BookDao;
import com.team29.dao.BorrowRecordDao;
import com.team29.entity.*;
import com.team29.service.BookService;
import com.team29.utils.DateOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class BookServiceImpl implements BookService {

    @Autowired
    BookDao bookDao;

    @Autowired
    BorrowRecordDao borrowRecordDao;

    @Override
    public String findBook(String key, String value, Integer page, Integer pageSize, List<Book> bookList) {
        List<Book> books;
        switch (key){
            case "all":
                books = bookDao.findAllBooks((page - 1) * pageSize, pageSize);
                for(int i = 0; i < books.size(); ++i)
                    bookList.add(books.get(i));
                break;
            case "id":
                Book book = bookDao.findBookById(value);
                bookList.add(book);
                break;
            case "name":
                books = bookDao.findBookByName(value, (page - 1) * pageSize, pageSize);
                for(int i = 0; i < books.size(); ++i)
                    bookList.add(books.get(i));
                break;
            case "author":
                books = bookDao.findBookByAuthor(value, (page - 1) * pageSize, pageSize);
                for(int i = 0; i < books.size(); ++i)
                    bookList.add(books.get(i));
                break;
            case "press":
                books = bookDao.findBookByPress(value, (page - 1) * pageSize, pageSize);
                for(int i = 0; i < books.size(); ++i)
                    bookList.add(books.get(i));
                break;
            case "ISBN":
                books = bookDao.findBookByIsbn(value, (page - 1) * pageSize, pageSize);
                for(int i = 0; i < books.size(); ++i)
                    bookList.add(books.get(i));
                break;
            default:
                return "无此选项可查询";
        }
        return "success";
    }

    @Override
    public String addBook(Book book) {
        try {
            bookDao.addBook(book);
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String modifyBook(Book book) {
        try {
            Book newBook = bookDao.findBookById(book.getB_Id());
            //log.info(newBook.toString());
            //log.info(book.toString());
            // 通过getDeclaredFields()方法获取对象类中的所有属性（含私有）
            Field[] fields = book.getClass().getDeclaredFields();
            for (Field field : fields) {

                field.setAccessible(true); // 设置允许通过反射访问私有变量
                Object value = field.get(book);

                // 对于不为空的User属性，则需要更改
                if (value != null) {
                    field.set(newBook, value);
                }
            }

            //log.info(newBook.toString());
            bookDao.updateBook(newBook);

        } catch(Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String deleteBook(String b_Id) {
        try {
            bookDao.deleteBook(b_Id);
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String borrowBook(BorrowRequest borrowRequest) {
        try {
            // 数据库中查找到已有记录
            if (borrowRecordDao.findBorrowRecord(borrowRequest.getU_id(), borrowRequest.getB_id()) != null) {
                return "已经借阅过该图书，请勿重复借阅。";
            }

            BorrowRecord borrowRecord = new BorrowRecord(borrowRequest, 7);
            borrowRecordDao.addBorrowRecord(borrowRecord);
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String returnBook(ReturnRequest returnRequest) {
        try {
            BorrowRecord borrowRecord = borrowRecordDao.findBorrowRecord(returnRequest.getU_id(), returnRequest.getB_id());
            if (borrowRecord == null) {  // 对于该(uId, bId)而言，不存在尚未归还的记录
                return "还没有借阅过该图书噢。";
            }
            borrowRecordDao.setReturnDate(returnRequest.getU_id(), returnRequest.getB_id(), returnRequest.getTime());
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String renewBook(RenewRequest renewRequest) {
        try {
            BorrowRecord borrowRecord = borrowRecordDao.findBorrowRecord(renewRequest.getU_id(), renewRequest.getB_id());
            if (borrowRecord == null) {
               return "还没有借过这本书噢。";
            }

            Date expectReturnDate = borrowRecord.getBr_Expect_Return_Date();
            if (DateOperation.plusDate(renewRequest.getTime(), 5).compareTo(expectReturnDate) < 0) {
                return "尚未到续借时间，请在还书前5天内续借。";
            }

            Date newExpectReturnDate = DateOperation.plusDate(renewRequest.getTime(), 5);   // 续借5天
            borrowRecordDao.setExpectReturnDate(renewRequest.getU_id(), renewRequest.getB_id(), newExpectReturnDate);
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

    @Override
    public String findBookByUser(String uId, Integer page, Integer pageSize, List<BookBorrowRecord> bookBorrowRecordList) {
        try {
            List<BookBorrowRecord> bookBorrowRecords = bookDao.findBookByUser(uId, (page - 1) * pageSize, pageSize);

            for(int i = 0; i < bookBorrowRecords.size(); ++i)
                bookBorrowRecordList.add(bookBorrowRecords.get(i));
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

}
