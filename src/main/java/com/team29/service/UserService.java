package com.team29.service;

import com.team29.entity.BookBorrowRecord;
import com.team29.entity.User;

import java.util.List;

public interface UserService {

    User findUserById(String id);

    void addUser(User user);

    String updateUserInfo(User user);

}
