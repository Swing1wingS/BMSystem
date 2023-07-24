package com.team29.controller;

import com.team29.entity.LoginForm;
import com.team29.entity.Result;
import com.team29.service.LoginService;
import com.team29.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


@Slf4j
@RestController
public class LoginController {

    @Autowired
    private LoginService loginService;
    /*
     * 1.15 登录功能
     */
    @PostMapping("/login")
    public Result login(@RequestBody LoginForm loginform)
    {
        log.info("信息: {}",loginform.getId());
        Result result = loginService.login(loginform);
        return result;
    }
}
