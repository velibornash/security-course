package com.expo.security.repository;

import com.expo.security.model.Exercise;
import com.expo.security.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {
    List<Exercise> findByLessonOrderBySortOrderAsc(Lesson lesson);
    List<Exercise> findByLessonIdOrderBySortOrderAsc(Long lessonId);
    void deleteByLessonId(Long lessonId);
}
