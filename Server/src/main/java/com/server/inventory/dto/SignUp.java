package com.server.inventory.dto;

import lombok.Getter;

@Getter
public class SignUp {
    private Long id;
    private String dui;
    private String username;
    private String name;
    private String surname;
    private String email;
    private int phone;
    private String password;
    private String role;
    private Boolean state;
}
