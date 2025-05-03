package com.server.inventory.service.impl;

import com.server.inventory.dto.*;
import com.server.inventory.model.User;
import com.server.inventory.repository.UserRepository;
import com.server.inventory.service.interfaces.UserServices;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServicesImpl implements UserServices {

    private final UserRepository repository;

    private final PasswordEncoder passwordEncoder;

    public UserServicesImpl(@Lazy UserRepository repository, PasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Optional<User> signUp(SignUp body) {
        User data = new User();
        data.setDui(body.getDui());
        data.setUsername(body.getUsername());
        data.setEmail(body.getEmail());
        data.setName(body.getName());
        data.setSurname(body.getSurname());
        data.setPassword(passwordEncoder.encode(body.getPassword()));
        data.setPhone(body.getPhone());
        data.setRole(body.getRole());
        data.setState(body.getState());
        return Optional.of(repository.save(data));
    }

    @Override
    public Optional<User> login(String username, String password) {
        User findUser = repository.findByUsername(username);
        if (findUser == null || !passwordEncoder.matches(password, findUser.getPassword())) {
            return Optional.empty();
        }
        return Optional.of(findUser);
    }

    @Override
    public Optional<List<User>> getUsers() {
        return Optional.of(repository.findAll());
    }

    @Override
    public Optional<User> findUserById(Long id) {
        return repository.findById(id);
    }
}
