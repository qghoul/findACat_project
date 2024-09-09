package com.khpi.mvc.service;

import com.khpi.mvc.models.ContactInfo;
import com.khpi.mvc.models.User;
import com.khpi.mvc.models.Role;
import com.khpi.mvc.repositories.*;
import jakarta.persistence.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    @PersistenceContext
    private EntityManager em;
    @Autowired
    RoleRepository roleRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    PasswordEncoder bCryptPasswordEncoder;
    @Override /*Implementation for login by Email*/
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email);
        if (user == null) {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
        return user.toUserDetails();
    }
    public User findUserById(Long userId) {
        Optional<User> userFromDb = userRepository.findById(userId);
        return userFromDb.orElse(new User());
    }
    public User findUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    public User findUserByEmail(String email){ return userRepository.findByEmail(email);}
    public List<User> allUsers() {
        return userRepository.findAll();
    }
    public User save(User user){ return userRepository.save(user);}
    public boolean saveUser(User user, String telegramUsername, String phoneNumber) {
        User userFromDBByUsername = userRepository.findByUsername(user.getUsername());
        if (userFromDBByUsername != null) {
            return false;
        }
        User userFromDBByEmail = userRepository.findByEmail(user.getEmail());
        if (userFromDBByEmail != null) {
            return false;
        }
        ContactInfo contactInfo = new ContactInfo();
        if(!telegramUsername.isEmpty()){
            contactInfo.setTelegramUsername(telegramUsername);
        }
        if(!phoneNumber.isEmpty()){
            contactInfo.setPhoneNumber(phoneNumber);
        }
        contactInfo.setUser(user);
        user.setContactInfo(contactInfo);
        user.setRoles(Collections.singleton(new Role(1L, "ROLE_USER")));
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return true;
    }
    public boolean deleteUser(Long userId) {
        if (userRepository.findById(userId).isPresent()) {
            userRepository.deleteById(userId);
            return true;
        }
        return false;
    }
    public List<User> usergtList(Long idMin) {
        return em.createQuery("SELECT u FROM User u WHERE u.id > :paramId", User.class)
                .setParameter("paramId", idMin).getResultList();
    }
}
