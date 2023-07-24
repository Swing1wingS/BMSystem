package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Component
public class User {
    private String u_Id;
    private String u_Name;
    private String u_Gender;
    private String u_Phone;
    private String u_Email;
    private String u_Password;

    public User(User user) {
        this.u_Id = user.u_Id;
        this.u_Name = user.u_Name;
        this.u_Gender = user.u_Gender;
        this.u_Phone = user.u_Phone;
        this.u_Email = user.u_Email;
        this.u_Password = user.u_Password;
    }

    // 该构造函数没有设置u_Id的值
    public User(EnrollForm enrollForm) {
        this.setU_Name(enrollForm.getName());
        this.setU_Gender(enrollForm.getGender());
        this.setU_Phone(enrollForm.getPhone());
        this.setU_Email(enrollForm.getEmail());
        this.setU_Password(enrollForm.getPassword());
    }

    @Override
    public String toString() {
        return "User{" +
                "u_Id='" + u_Id + '\'' +
                ", u_Name='" + u_Name + '\'' +
                ", u_Gender='" + u_Gender + '\'' +
                ", u_Phone='" + u_Phone + '\'' +
                ", u_Email='" + u_Email + '\'' +
                ", u_Password='" + u_Password + '\'' +
                '}';
    }
}
