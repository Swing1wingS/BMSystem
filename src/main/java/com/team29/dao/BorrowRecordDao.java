package com.team29.dao;

import com.team29.entity.Book;
import com.team29.entity.BorrowRecord;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface BorrowRecordDao {

    @Insert("insert into borrow_record " +
            "values(#{br_U_Id}, #{br_B_Id}, #{br_Borrow_Date}, " +
            "#{br_Expect_Return_Date}, #{br_Return_Date})")
    void addBorrowRecord(BorrowRecord borrowRecord);

    // 对应 归还图书
    @Update("update borrow_record " +
            "set br_return_date=curdate() " +
            "where br_u_id=#{u_Id} and br_b_id=#{b_Id} and br_return_date is null")
    void setReturnDate(String u_Id, String b_Id, Date return_Date);

    // 对应 续借图书
    @Update("update borrow_record " +
            "set br_expect_return_date=DATE_ADD(br_expect_return_date, interval 3 day) " +
            "where br_u_id=#{u_Id} and br_b_id=#{b_Id} and br_return_date is null")
    void setExpectReturnDate(String u_Id, String b_Id, Date expect_return_Date);
}
