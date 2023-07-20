package com.team29.entity;

import org.springframework.stereotype.Component;

@Component
public class User {
    private String u_Id;
    private String u_Name;
    private String u_Gender;
    private String u_Phone;
    private String u_Email;
    private String u_Password;

    public String getU_Id() {
        return u_Id;
    }

    public void setU_Id(String u_Id) {
        this.u_Id = u_Id;
    }

    public String getU_Name() {
        return u_Name;
    }

    public void setU_Name(String u_Name) {
        this.u_Name = u_Name;
    }

    public String getU_Gender() {
        return u_Gender;
    }

    public void setU_Gender(String u_Gender) {
        this.u_Gender = u_Gender;
    }

    public String getU_Phone() {
        return u_Phone;
    }

    public void setU_Phone(String u_Phone) {
        this.u_Phone = u_Phone;
    }

    public String getU_Email() {
        return u_Email;
    }

    public void setU_Email(String u_Email) {
        this.u_Email = u_Email;
    }

    public String getU_Password() {
        return u_Password;
    }

    public void setU_Password(String u_Password) {
        this.u_Password = u_Password;
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
