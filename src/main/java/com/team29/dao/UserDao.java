package com.team29.dao;

import com.team29.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserDao {

    @Insert("insert into USER " +
            "values(#{u_Id}, #{u_Name}, #{u_Gender}, " +
            "#{u_Phone}, #{u_Email}, #{u_Password})")
    void addUser(User user);

    @Select("select * from USER limit #{start}, #{offset}")
    List<User> findAllUser(Integer start, Integer offset);

    @Select("select count(*) from user")
    Integer findNumberOfAllUser();

    @Select("select * from USER where u_id=#{id}")
    User findUserById(String id);

    @Select("select * from USER where u_name=#{name}")
    User findUserByName(String name);

    @Select("select u_id from USER")
    List<String> findAllUId();

    @Update("update user " +
            "set u_name=#{u_Name}, u_gender=#{u_Gender}, u_phone=#{u_Phone}, " +
            "u_email=#{u_Email}, u_password=#{u_Password} where u_id=#{u_Id}")
    void updateUser(User user);

    @Delete("delete from user where u_id=#{u_Id}")
    void deleteUser(String u_Id);
}
