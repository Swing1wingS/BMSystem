package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookShelf {
    private String bs_Id;
    private String bs_BookCategory;

    @Override
    public String toString() {
        return "BookShelf{" +
                "bs_Id='" + bs_Id + '\'' +
                ", bs_BookCategory='" + bs_BookCategory + '\'' +
                '}';
    }
}
