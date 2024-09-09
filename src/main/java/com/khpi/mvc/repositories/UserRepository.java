package com.khpi.mvc.repositories;

import com.khpi.mvc.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository
        extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findByEmail(String email);
}
