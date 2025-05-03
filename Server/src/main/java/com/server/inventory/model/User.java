package com.server.inventory.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "user")
@Data
@NoArgsConstructor
@ToString(exclude = "photos")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "dui", length = 10, unique = true, nullable = false)
    private String dui;

    @Column(name = "username", length = 16, unique = true, nullable = false)
    private String username;

    @Column(name = "name", length = 100, nullable = false)
    private String name;


    @Column(name = "surname", length = 100, nullable = false)
    private String surname;

    @Column(name = "email", length = 200, unique = true, nullable = false)
    private String email;

    @Column(name = "phone", unique = true, nullable = false)
    private int phone;

    @Column(name = "password", length = 200, nullable = false)
    private String password;

    @Column(name = "role", length = 17)
    private String role;

    @Column(name = "state")
    private Boolean state;

    @OneToMany(mappedBy = "user_join", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<UserPhoto> photos;
}