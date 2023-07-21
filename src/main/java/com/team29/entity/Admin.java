package com.team29.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
public class Admin {
    private String a_Id;
    private String a_Name;
    private String a_Password;

    @Override
    public String toString() {
        return "Admin{" +
                "a_Id='" + a_Id + '\'' +
                ", a_Name='" + a_Name + '\'' +
                ", a_Password='" + a_Password + '\'' +
                '}';
    }
}
