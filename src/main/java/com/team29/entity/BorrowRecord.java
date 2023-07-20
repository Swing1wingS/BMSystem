package com.team29.entity;

import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class BorrowRecord {
    private String br_U_Id;
    private String br_B_Id;
    private Date br_Borrow_Date;
    private Date br_Return_Date;

    public String getBr_U_Id() {
        return br_U_Id;
    }

    public void setBr_U_Id(String br_U_Id) {
        this.br_U_Id = br_U_Id;
    }

    public String getBr_B_Id() {
        return br_B_Id;
    }

    public void setBr_B_Id(String br_B_Id) {
        this.br_B_Id = br_B_Id;
    }

    public Date getBr_Borrow_Date() {
        return br_Borrow_Date;
    }

    public void setBr_Borrow_Date(Date br_Borrow_Date) {
        this.br_Borrow_Date = br_Borrow_Date;
    }

    public Date getBr_Return_Date() {
        return br_Return_Date;
    }

    public void setBr_Return_Date(Date br_Return_Date) {
        this.br_Return_Date = br_Return_Date;
    }

    @Override
    public String toString() {
        return "BorrowRecord{" +
                "br_U_Id='" + br_U_Id + '\'' +
                ", br_B_Id='" + br_B_Id + '\'' +
                ", br_Borrow_Date=" + br_Borrow_Date +
                ", br_Return_Date=" + br_Return_Date +
                '}';
    }
}
