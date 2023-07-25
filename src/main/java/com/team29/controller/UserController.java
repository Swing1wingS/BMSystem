package com.team29.controller;

import com.team29.entity.EnrollForm;
import com.team29.entity.Result;
import com.team29.entity.User;
import com.team29.entity.UserResponse;
import com.team29.service.UserService;
import com.team29.service.impl.UserServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Slf4j
@RestController
public class UserController {

    @Autowired
    private UserService userService;


    /*
     * 1.1 添加用户，即注册功能
     */
    @PostMapping("/enroll")
    public Result addUser(@RequestBody EnrollForm enrollForm)
    {
        //调用service新增用户
        userService.addUser(enrollForm);
        return Result.success();
    }

    /*
     * 1.2 查询用户
     */
    @GetMapping(value="/user_info")
    public Result findUserById(@RequestParam("u_id") String u_Id)
    {
        log.info("根据id查询员工信息,id: {}",u_Id);
        User user=userService.findUserById(u_Id);
        return user != null ? Result.success(user) : Result.fail("没有该用户");
    }

    /*
     * 1.3  修改用户信息
     * 1.13 管理员修改用户
     */
    @PatchMapping("/modify_user")
    public Result update(@RequestBody User user)
    {
        log.info("更新用户信息 :{}",user);
        userService.updateUserInfo(user);
        //如果没有该id的用户好像也会返回success
        return Result.success();
    }

    /*
     * 1.12 管理员添加用户
     */
    @PostMapping("/add_user")
    public Result adminAddUser(@RequestBody EnrollForm enrollForm)
    {
        //调用service新增用户
        userService.addUser(enrollForm);
        return Result.success();
    }
    /*
     * 1.14 删除用户
     */
    @DeleteMapping("/delete_user/{u_Id}")
    public Result deleteUserById(@PathVariable String u_Id)
    {
        log.info("根据id查询员工信息,id: {}",u_Id);
        userService.deleteUser(u_Id);
        return Result.success();
    }

    /*
     * 1.16 查询所有用户信息
     */
    @GetMapping("/users")
    public Result findAllUsers(@RequestParam("page") Integer page, @RequestParam("pageSize") Integer pageSize)
    {
        List<User> userList = new ArrayList<>();
        Integer amount[] = {0};
        String msg = userService.findAllUser(page, pageSize, userList, amount);
        UserResponse userResponse = new UserResponse(amount[0], userList);
        return msg == "success" ? Result.success(userResponse) : Result.fail(msg);
    }
}
