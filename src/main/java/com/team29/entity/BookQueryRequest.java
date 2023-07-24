package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookQueryRequest {
    private String id;
    private String name;
    private String author;
    private String press;
    private String ISBN;
    private Integer page;
    private Integer pageSize;
}
