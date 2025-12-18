package com.tap.dao;

import java.util.List;
import com.tap.model.User;

public interface UserDAO {
    User validateUser(String username, String password);
    boolean registerUser(User user);
}
