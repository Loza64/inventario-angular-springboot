package com.server.inventory.repository;

import com.server.inventory.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

@EnableJpaRepositories
@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username);

    /*
    @Query("select u from User u where u.id = :id")
    User findUserById(@Param("id") Long id);
    */
}
