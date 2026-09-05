package com.expo.security.repository;

import com.expo.security.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Long> {
    List<Lesson> findBySectionIdOrderBySortOrderAsc(Long sectionId);
    List<Lesson> findAllByOrderBySortOrderAsc();
    List<Lesson> findByTitleContainingIgnoreCase(String title);

    @Query("SELECT l FROM Lesson l JOIN FETCH l.section s ORDER BY s.sortOrder, l.sortOrder")
    List<Lesson> findAllBySectionSortOrderThenLessonSortOrder();
}
