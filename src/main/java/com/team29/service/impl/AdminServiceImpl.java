package com.team29.service.impl;

import com.team29.dao.AdminDao;
import com.team29.entity.Admin;
import com.team29.service.AdminService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminDao adminDao;
    @Override
    public Admin findAdminById(String id) {return adminDao.findAdminById(id);}
    @Override
    public String updateAdminInfo(Admin admin) {

        Admin newAdmin = adminDao.findAdminById(admin.getA_Id());
        // log.info(newUser.toString());
        try {
            // 通过getDeclaredFields()方法获取对象类中的所有属性（含私有）
            Field[] fields = admin.getClass().getDeclaredFields();
            for (Field field : fields) {

                field.setAccessible(true); // 设置允许通过反射访问私有变量
                Object value = field.get(admin);

                // 对于不为空的User属性，则需要更改
                if (value != null) {
                    field.set(newAdmin, value);
                }
            }
            // log.info(user.toString());
            // log.info(newUser.toString());
            adminDao.updateAdmin(newAdmin);
        }
        catch (Exception e)
        {
            return e.toString();
        }
        return "success";
    }
}
