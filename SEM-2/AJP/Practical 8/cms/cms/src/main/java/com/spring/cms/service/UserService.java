package com.spring.cms.service;

import com.spring.cms.model.User;
import com.spring.cms.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public User registerUser(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Username already exists");
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists");
        }

        // Encode the password before saving
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    public User loginUser(String username, String password) {
        System.out.println("Attempting login with username/email: " + username);
        
        // Try to find user by username first
        Optional<User> userOptional = userRepository.findByUsername(username);
        System.out.println("Found by username: " + userOptional.isPresent());
        
        // If not found by username, try email
        if (!userOptional.isPresent()) {
            userOptional = userRepository.findByEmail(username);
            System.out.println("Found by email: " + userOptional.isPresent());
        }
        
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            System.out.println("User found: " + user.getUsername());
            boolean passwordMatches = passwordEncoder.matches(password, user.getPassword());
            System.out.println("Password matches: " + passwordMatches);
            if (passwordMatches) {
                return user;
            }
        }
        throw new RuntimeException("Invalid username/email or password");
    }
} 