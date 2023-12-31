package com.team29.dao;

import com.team29.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface AdminDao {

    @Select("select * from admin")
    List<Admin> findAllAdmin();

    @Select("select a_password from admin where a_id=#{a_Id}")
    String findPassword(String a_Id);

    @Select("select * from ADMIN where a_id=#{id}")
    Admin findAdminById(String id);

    @Select("select * from admin where a_name=#{name}")
    Admin findAdminByName(String name);

    @Update("update admin set a_name=#{a_Name}, a_password=#{a_Password} where a_id=#{a_Id}")
    void updateAdmin(Admin admin);

}
