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
import org.springframework.web.multipart.MultipartFile;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.InputStream;
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

    @Transactional
    public String sendCredentialsToAllPending() {
        List<User> pending = userRepository.findAll().stream()
                .filter(u -> u.getEmailSentAt() == null).toList();
        int ok = 0, fail = 0;
        for (User u : pending) {
            try {
                sendCredentials(u.getId());
                ok++;
            } catch (Exception e) {
                fail++;
            }
        }
        return "Poslato " + ok + " od " + pending.size() + " mejlova"
                + (fail > 0 ? " (" + fail + " grešaka)." : ".");
    }

    @Transactional
    public String importUsersFromExcel(MultipartFile file) {
        int created = 0, skipped = 0, errors = 0;
        StringBuilder details = new StringBuilder();
        try (InputStream is = file.getInputStream();
             Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;
                String firstName = cellValue(row, 0);
                String lastName = cellValue(row, 1);
                String email = cellValue(row, 2);
                String company = cellValue(row, 3);
                String password = cellValue(row, 4);
                if (email.isBlank()) {
                    if (firstName.isBlank() && lastName.isBlank()) continue; // skip empty rows
                    errors++;
                    details.append("Red ").append(i + 1).append(": prazan email. ");
                    continue;
                }
                if (userRepository.existsByEmail(email)) {
                    skipped++;
                    continue;
                }
                try {
                    String pwd = password.isBlank() ? generateRandomPassword(10) : password;
                    register(firstName, lastName, email, pwd, company);
                    created++;
                } catch (Exception e) {
                    errors++;
                    details.append("Red ").append(i + 1).append(": ").append(e.getMessage()).append(" ");
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Greška pri čitanju fajla: " + e.getMessage());
        }
        String report = "Kreirano: " + created + ", preskočeno (duplikati): " + skipped + ", greške: " + errors + ".";
        if (details.length() > 0) report += " Detalji: " + details;
        return report;
    }

    private String cellValue(Row row, int idx) {
        Cell c = row.getCell(idx);
        if (c == null) return "";
        try {
            c.setCellType(CellType.STRING);
        } catch (Exception ignored) {
        }
        String v = c.getStringCellValue();
        return v == null ? "" : v.trim();
    }
}

