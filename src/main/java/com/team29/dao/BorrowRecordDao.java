package com.team29.dao;

import com.team29.entity.Book;
import com.team29.entity.BorrowRecord;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface BorrowRecordDao {

    @Insert("insert into borrow_record values(#{br_U_Id}, #{br_B_Id}, #{br_Borrow_Date}, #{br_Return_Date})")
    void addBorrowRecord(BorrowRecord borrowRecord);

    @Update("update borrow_record set return_date=#{return_Date} where u_id=#{u_Id} and b_id=#{b_Id}")
    void setReturnDate(String u_Id, String b_Id, Date return_Date);
}
