package com.team29.entity;

import org.springframework.stereotype.Component;

@Component
public class Admin {
    private String a_Id;
    private String a_Name;
    private String a_Password;

    public String getA_Id() {
        return a_Id;
    }

    public void setA_Id(String a_Id) {
        this.a_Id = a_Id;
    }

    public String getA_Name() {
        return a_Name;
    }

    public void setA_Name(String a_Name) {
        this.a_Name = a_Name;
    }

    public String getA_Password() {
        return a_Password;
    }

    public void setA_Password(String a_Password) {
        this.a_Password = a_Password;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "a_Id='" + a_Id + '\'' +
                ", a_Name='" + a_Name + '\'' +
                ", a_Password='" + a_Password + '\'' +
                '}';
    }
}
