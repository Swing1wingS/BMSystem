package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {
    private Integer code;   // 1 -> 成功，0 -> 失败
    private String msg;     // 提示信息
    private Object data;    // 有请求数据则返回数据

    // 返回操作是否成功
    public static Result success() {
        return new Result(1, "success", null);
    }

    // 请求数据
    public static Result success(Object data) {
        return new Result(1, "success", data);
    }

    // 返回失败信息
    public static Result fail(String msg) {
        return new Result(0, msg, null);
    }
}
