package com.team29.entity;

public class BookShelf {
    private String bs_Id;
    private String bs_BookCategory;

    public String getBs_Id() {
        return bs_Id;
    }

    public void setBs_Id(String bs_Id) {
        this.bs_Id = bs_Id;
    }

    public String getBs_BookCategory() {
        return bs_BookCategory;
    }

    public void setBs_BookCategory(String bs_BookCategory) {
        this.bs_BookCategory = bs_BookCategory;
    }

    @Override
    public String toString() {
        return "BookShelf{" +
                "bs_Id='" + bs_Id + '\'' +
                ", bs_BookCategory='" + bs_BookCategory + '\'' +
                '}';
    }
}
