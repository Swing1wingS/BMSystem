package com.team29.dao;

import com.team29.entity.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface BookDao {

    @Select("select * from book")
    List<Book> getAllBooks();


}
