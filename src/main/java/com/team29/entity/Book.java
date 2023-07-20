package com.team29.entity;

import org.springframework.stereotype.Component;

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

    public String getB_Id() {
        return b_Id;
    }

    public void setB_Id(String b_Id) {
        this.b_Id = b_Id;
    }

    public String getB_Name() {
        return b_Name;
    }

    public void setB_Name(String b_Name) {
        this.b_Name = b_Name;
    }

    public String getB_Author() {
        return b_Author;
    }

    public void setB_Author(String b_Author) {
        this.b_Author = b_Author;
    }

    public String getB_Press() {
        return b_Press;
    }

    public void setB_Press(String b_Press) {
        this.b_Press = b_Press;
    }

    public Integer getB_Pub_Year() {
        return b_Pub_Year;
    }

    public void setB_Pub_Year(Integer b_Pub_Year) {
        this.b_Pub_Year = b_Pub_Year;
    }

    public Integer getB_Total_Collection() {
        return b_Total_Collection;
    }

    public void setB_Total_Collection(Integer b_Total_Collection) {
        this.b_Total_Collection = b_Total_Collection;
    }

    public Integer getB_Cur_Collection() {
        return b_Cur_Collection;
    }

    public void setB_Cur_Collection(Integer b_Cur_Collection) {
        this.b_Cur_Collection = b_Cur_Collection;
    }

    public String getB_Bs_Id() {
        return b_Bs_Id;
    }

    public void setB_Bs_Id(String b_Bs_Id) {
        this.b_Bs_Id = b_Bs_Id;
    }

    public String getB_Isbn() {
        return b_Isbn;
    }

    public void setB_Isbn(String b_Isbn) {
        this.b_Isbn = b_Isbn;
    }

    public double getB_Price() {
        return b_Price;
    }

    public void setB_Price(double b_Price) {
        this.b_Price = b_Price;
    }

    public String getB_Description() {
        return b_Description;
    }

    public void setB_Description(String b_Description) {
        this.b_Description = b_Description;
    }

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
