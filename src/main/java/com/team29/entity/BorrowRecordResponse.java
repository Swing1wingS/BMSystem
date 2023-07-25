package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BorrowRecordResponse {
    Integer amount;
    List<BookBorrowRecord> bookBorrowRecordList;
}
