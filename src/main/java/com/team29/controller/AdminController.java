package com.team29.controller;

import com.team29.entity.Admin;
import com.team29.entity.Result;
import com.team29.entity.User;
import com.team29.service.AdminService;
import com.team29.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
public class AdminController {

    @Autowired
    private AdminService adminService;
    /*
     * 1.7 查询管理员个人信息
     */
    @GetMapping(value="/admin_info")
    public Result findUserById(@RequestParam("a_id") String a_Id)
    {
        log.info("根据id查询员工信息,id: {}",a_Id);
        Admin admin=adminService.findAdminById(a_Id);
        return admin!=null?Result.success(admin):Result.fail("没有该管理员");
    }
    /*
     * 1.8 修改管理员信息
     */
    @PatchMapping("/modify_admin")
    public Result update(@RequestBody Admin admin)
    {
        log.info("更新用户信息 :{}",admin);
        adminService.updateAdminInfo(admin);
        //如果没有该id的用户好像也会返回success
        return Result.success();
    }
}
