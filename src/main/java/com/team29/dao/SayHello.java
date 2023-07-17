package com.team29.dao;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SayHello {

    @RequestMapping("/sayhello")
    public String getUserList() {
        return "创建成功！";
    }

}
