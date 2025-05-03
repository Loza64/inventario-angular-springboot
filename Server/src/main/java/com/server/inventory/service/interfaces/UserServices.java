package com.server.inventory.service.interfaces;

import com.server.inventory.dto.SignUp;
import com.server.inventory.model.User;

import java.util.List;
import java.util.Optional;

public interface UserServices {
    Optional<User> signUp(SignUp body);
    Optional<User> login(String username, String password);
    Optional<List<User>> getUsers();
    Optional<User> findUserById(Long id);
}
