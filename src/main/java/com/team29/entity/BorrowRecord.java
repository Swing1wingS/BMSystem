package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
public class BorrowRecord {
    private String br_U_Id;
    private String br_B_Id;
    private Date br_Borrow_Date;
    private Date br_Return_Date;

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
