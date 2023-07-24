package com.team29.dao;

import com.team29.entity.Book;
import com.team29.entity.BookBorrowRecord;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface BookDao {

    @Select("select * from book limit #{start}, #{offset}")
    List<Book> findAllBooks(Integer start, Integer offset);

    @Select("select * from book where b_id=#{b_Id}")
    Book findBookById(String b_Id);

    @Select("select * from book where b_name=#{b_Name} limit #{start}, #{offset}")
    List<Book> findBookByName(String b_Name, Integer start, Integer offset);

    @Select("select * from book where b_press=#{b_Press} limit #{start}, #{offset}")
    List<Book> findBookByPress(String b_Press, Integer start, Integer offset);

    @Select("select * from book where b_author=#{b_Author} limit #{start}, #{offset}")
    List<Book> findBookByAuthor(String b_Author, Integer start, Integer offset);

    @Select("select * from book where b_isbn=#{b_Isbn} limit #{start}, #{offset}")
    List<Book> findBookByIsbn(String b_Isbn, Integer start, Integer offset);

    @Select("select book.*, BR_U_ID, BR_BORROW_DATE, BR_EXPECT_RETURN_DATE, BR_RETURN_DATE " +
            "from book, borrow_record " +
            "where b_id=br_b_id and BR_U_ID=#{u_Id} " +
            "limit #{start}, #{offset}")
    List<BookBorrowRecord> findBookByUser(String u_Id, Integer start, Integer offset);

    @Insert("insert into book " +
            "values(#{b_Id}, #{b_Name}, #{b_Author}, #{b_Press}, #{b_Pub_Year}, #{b_Total_Collection}," +
            " #{b_Cur_Collection}, #{b_Bs_Id}, #{b_Isbn}, #{b_Price}, #{b_Description})")
    void addBook(Book book);

    @Update("update book " +
            "set b_name=#{b_Name}, b_author=#{b_Author}, b_press=#{b_Press}, b_pub_year=#{b_Pub_Year}, b_total_collection=#{b_Total_Collection}," +
            " b_cur_collection=#{b_Cur_Collection}, b_bs_id=#{b_Bs_Id}, b_isbn=#{b_Isbn}, b_price=#{b_Price}, b_description=#{b_Description}" +
            "where b_id=#{b_Id}")
    void updateBook(Book book);

    @Delete("delete from book where b_id=#{b_Id}")
    void deleteBook(String b_Id);
}
