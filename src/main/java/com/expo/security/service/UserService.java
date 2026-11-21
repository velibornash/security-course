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
    public User register(String firstName, String lastName, String email, String password, String company) {
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
                .company(company)
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
    public User createUser(String firstName, String lastName, String email, String password, String company) {
        return register(firstName, lastName, email, password, company);
    }

    @Transactional
    public User updateUser(Long id, String firstName, String lastName, String email, String password, String company) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Korisnik nije pronađen"));
        if (email != null && !email.isBlank() && !email.equals(user.getEmail())) {
            if (userRepository.existsByEmail(email)) {
                throw new RuntimeException("Email već postoji");
            }
            user.setEmail(email);
        }
        if (firstName != null && !firstName.isBlank()) user.setFirstName(firstName);
        if (lastName != null && !lastName.isBlank()) user.setLastName(lastName);
        if (password != null && !password.isBlank()) {
            user.setPassword(passwordEncoder.encode(password));
        }
        if (company != null) {
            user.setCompany(company);
        }
        return userRepository.save(user);
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
