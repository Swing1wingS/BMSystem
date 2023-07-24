package com.team29.service.impl;

import com.team29.dao.AdminDao;
import com.team29.dao.UserDao;
import com.team29.entity.LoginForm;
import com.team29.entity.Result;
import com.team29.service.LoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private AdminDao adminDao;

    @Override
    public Result login(LoginForm loginForm)
    {
        switch (loginForm.getType()) {
            case 0 -> {
                String userPassword = userDao.findPassword(loginForm.getId());
                if (userPassword.equals(loginForm.getPassword())) return Result.success();
                else return Result.fail("wrong password");
            }
            case 1 -> {
                String adminPassword = adminDao.findPassword(loginForm.getId());
                if (adminPassword.equals(loginForm.getPassword())) return Result.success();
                else return Result.fail("wrong password");
            }
        }
        return Result.fail("登录运行错误");
    }
}
