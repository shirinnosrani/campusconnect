package com.campus.event.service;

import com.campus.event.model.User;
import com.campus.event.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository repo;

    public UserService(UserRepository repo) {
        this.repo = repo;
    }

    public User save(User user) {
        return repo.save(user);
    }

    public User login(String email, String password) {

        User user = repo.findByEmail(email);

        if (user == null) {
            return null;
        }

        // TEMP (your current DB is plain text)
        if (!password.equals(user.getPassword())) {
            return null;
        }
        return user;
    }

    public User findUserByEmail(String email) {
        return repo.findByEmail(email);
    }

}
