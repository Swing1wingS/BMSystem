package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
public class Book {
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

    @Override
    public String toString() {
        return "Book{" +
                "b_Id='" + b_Id + '\'' +
                ", b_Name='" + b_Name + '\'' +
                ", b_Author='" + b_Author + '\'' +
                ", b_Press='" + b_Press + '\'' +
                ", b_Pub_Year=" + b_Pub_Year +
                ", b_Total_Collection=" + b_Total_Collection +
                ", b_Cur_Collection=" + b_Cur_Collection +
                ", b_Bs_Id='" + b_Bs_Id + '\'' +
                ", b_Isbn='" + b_Isbn + '\'' +
                ", b_Price=" + b_Price +
                ", b_Description='" + b_Description + '\'' +
                '}';
    }
}
