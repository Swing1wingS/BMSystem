package com.team29.service;

import com.team29.entity.EnrollForm;
import com.team29.entity.User;

import java.util.List;

public interface UserService {

    User findUserById(String id);

    String addUser(EnrollForm enrollForm);

    String updateUserInfo(User user);

    void deleteUser(String id);

    String findAllUser(Integer page, Integer pageSize, List<User> userList, Integer[] amount);
}
