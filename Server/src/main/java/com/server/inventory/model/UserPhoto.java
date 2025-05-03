package com.server.inventory.model;

import jakarta.persistence.*;
import lombok.Getter;

@Entity
@Table(name = "user_photo")
@Getter
public class UserPhoto {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_user", nullable = false)
    private User user_join;

    @Column(name = "public_id", nullable = false)
    private String public_id;

    @Column(name = "url", nullable = false)
    private String url;

    public UserPhoto(){ }
}
