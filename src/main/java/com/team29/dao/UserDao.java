package com.team29.dao;

import com.team29.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface UserDao {

    @Insert("insert into USER values(#{u_Id}, #{u_Name}, #{u_Gender}, #{u_Phone}, #{u_Email}, #{u_Password})")
    void addUser(User user);

    @Select("select * from USER limit (#{page}-1)*#{pageSize}, #{pageSize}")
    List<User> findAllUser(Integer page, Integer pageSize);

    @Select("select * from USER where u_id=#{id}")
    User findUserById(String id);

    @Update("update user set u_name=#{u_Name}, u_gender=#{u_Gender}, u_phone=#{u_Phone}, u_email=#{u_Email}, u_password=#{u_Password} where u_id=#{u_Id}")
    void updateUser(User user);

    @Delete("delete from book where u_id=#{u_Id}")
    void deleteUser(String u_Id);


}
