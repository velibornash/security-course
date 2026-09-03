package com.expo.security.repository;

import com.expo.security.model.UserProgress;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserProgressRepository extends JpaRepository<UserProgress, Long> {
    Optional<UserProgress> findByUserIdAndLessonId(Long userId, Long lessonId);
    List<UserProgress> findByUserId(Long userId);
    long countByUserIdAndCompletedTrue(Long userId);
}
