package com.team29.service.impl;

import com.team29.dao.AdminDao;
import com.team29.dao.UserDao;
import com.team29.entity.*;
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
        IdForm idForm;
        switch (loginForm.getType()) {
            case 0 :
                User user = userDao.findUserByName(loginForm.getName());
                if (user == null) {
                    return Result.fail("该用户名称不存在");
                }
                idForm = new IdForm(0, user.getU_Id());
                if (user.getU_Password().equals(loginForm.getPassword())) return Result.success(idForm);
                else return Result.fail("wrong password");
            case 1 :
                Admin admin = adminDao.findAdminByName(loginForm.getName());
                if (admin == null) {
                    return Result.fail("该管理员名称不存在");
                }
                idForm = new IdForm(1, admin.getA_Id());
                if (admin.getA_Password().equals(loginForm.getPassword())) return Result.success(idForm);
                else return Result.fail("wrong password");
        }
        return Result.fail("登录运行错误");
    }
}
