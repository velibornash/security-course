package com.expo.security.repository;

import com.expo.security.model.QuizAttempt;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface QuizAttemptRepository extends JpaRepository<QuizAttempt, Long> {
    List<QuizAttempt> findByUserIdOrderByAttemptedAtDesc(Long userId);
    Optional<QuizAttempt> findByCertificateCode(String certificateCode);
    Optional<QuizAttempt> findFirstByUserIdAndPassedTrueOrderByAttemptedAtDesc(Long userId);
}
