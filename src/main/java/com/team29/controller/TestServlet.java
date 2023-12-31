package com.team29.controller;

import com.team29.entity.*;
import com.team29.service.BookService;
import com.team29.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@RestController
public class TestServlet {

    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/testGet", method = RequestMethod.GET)
    public Result testGet(@RequestParam("u_id") String u_Id) {


        return Result.success();
    }


    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public Result test() {
        Integer a = 0;
        f(a);

        return Result.success(a);
    }

    void f(Integer x) {
        x = 1;
    }

    @RequestMapping(value = "/testPost", method = RequestMethod.POST)
    public Result testPost(@RequestBody User user) {

        String msg = userService.updateUserInfo(user);

        if (msg == "success")
            return Result.success();
        else
            return Result.fail(msg);
    }
}
