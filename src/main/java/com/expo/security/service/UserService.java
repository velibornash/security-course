package com.expo.security.service;

import com.expo.security.model.QuizAttempt;
import com.expo.security.model.Role;
import com.expo.security.model.User;
import com.expo.security.repository.QuizAttemptRepository;
import com.expo.security.repository.UserProgressRepository;
import com.expo.security.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final QuizAttemptRepository attemptRepository;
    private final UserProgressRepository progressRepository;
    private final EmailService emailService;

    @Transactional
    public User register(String firstName, String lastName, String email, String password) {
        if (userRepository.existsByEmail(email)) {
            throw new RuntimeException("Email već postoji");
        }
        User user = User.builder()
                .firstName(firstName)
                .lastName(lastName)
                .email(email)
                .password(passwordEncoder.encode(password))
                .role(Role.USER)
                .enabled(true)
                .build();
        return userRepository.save(user);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen"));
    }

    public List<User> getAllUsers() {
        return userRepository.findAllByOrderByCreatedAtDesc();
    }

    @Transactional
    public User createUser(String firstName, String lastName, String email, String password) {
        return register(firstName, lastName, email, password);
    }

    @Transactional
    public void deleteUser(Long id) {
        progressRepository.deleteByUserId(id);
        attemptRepository.deleteByUserId(id);
        userRepository.deleteById(id);
    }

    /**
     * Generates a new random password, updates the user, sends it by email,
     * and records the send timestamp.
     */
    @Transactional
    public User sendCredentials(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen"));
        String rawPassword = generateRandomPassword(10);
        user.setPassword(passwordEncoder.encode(rawPassword));
        user.setEmailSentAt(java.time.LocalDateTime.now());
        userRepository.save(user);
        emailService.sendCredentials(user, rawPassword);
        return user;
    }

    public QuizAttempt getLatestAttempt(Long userId) {
        return attemptRepository.findByUserIdOrderByAttemptedAtDesc(userId).stream().findFirst().orElse(null);
    }

    private String generateRandomPassword(int len) {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
