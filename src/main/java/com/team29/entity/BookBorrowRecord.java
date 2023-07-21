package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BookBorrowRecord {
    private String b_Id;
    private String b_Name;
    private String b_Author;
    private String b_Press;
    private Integer b_Pub_Year;
    private Integer b_Total_Collection;
    private Integer b_Cur_Collection;
    private String b_Bs_Id;
    private String b_Isbn;
    private double b_Price;
    private String b_Description;
    private String br_U_Id;
    private Date br_Borrow_Date;
    private Date br_Return_Date;
}
