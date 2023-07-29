package com.team29.service.impl;

import com.team29.dao.UserDao;
import com.team29.entity.EnrollForm;
import com.team29.entity.User;
import com.team29.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Random;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;


    @Override
    public User findUserById(String id) {
        return userDao.findUserById(id);
    }

    @Override
    public String addUser(EnrollForm enrollForm) {
        try {
            if (userDao.findUserByName(enrollForm.getName()) != null) {
                return "该用户名已存在。";
            }

            User user = new User(enrollForm);

            Random random = new Random();
            List<String> uIdList = userDao.findAllUId();
            String uId = "U" + random.nextInt(999);

            // 找到现有数据库中不存在的uId
            while (uIdList.contains(uId))
                uId = "U" + random.nextInt(999);

            user.setU_Id(uId);
            userDao.addUser(user);
        } catch (Exception e) {
            return e.toString();
        }

        return "success";
    }

    @Override
    public String updateUserInfo(User user) {

        User newUser = userDao.findUserById(user.getU_Id());
        // log.info(newUser.toString());
        try {
            // 通过getDeclaredFields()方法获取对象类中的所有属性（含私有）
            Field[] fields = user.getClass().getDeclaredFields();
            for (Field field : fields) {

                field.setAccessible(true); // 设置允许通过反射访问私有变量
                Object value = field.get(user);

                // 对于不为空的User属性，则需要更改
                if (value != null) {
                    field.set(newUser, value);
                }
            }
            // log.info(user.toString());
            // log.info(newUser.toString());
            userDao.updateUser(newUser);
        }
        catch (Exception e)
        {
            return e.toString();
        }
        return "success";
    }

    @Override
    public void deleteUser(String id) {
        userDao.deleteUser(id);
    }

    @Override
    public String findAllUser(Integer page, Integer pageSize, List<User> userList, Integer[] amount) {
        try {
            List<User> users = userDao.findAllUser((page - 1) * pageSize, pageSize);
            userList.addAll(users);
            amount[0] = userDao.findNumberOfAllUser();
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }

}
