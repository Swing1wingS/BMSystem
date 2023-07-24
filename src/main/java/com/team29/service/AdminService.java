package com.team29.service;

import com.team29.entity.Admin;
import com.team29.entity.User;

public interface AdminService {
    Admin findAdminById(String id);

    String updateAdminInfo(Admin admin);
}
