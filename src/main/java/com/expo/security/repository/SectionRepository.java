package com.expo.security.repository;

import com.expo.security.model.Section;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SectionRepository extends JpaRepository<Section, Long> {
    List<Section> findAllByOrderBySortOrderAsc();

    @Query("SELECT s FROM Section s LEFT JOIN FETCH s.lessons ORDER BY s.sortOrder")
    List<Section> findAllWithLessons();
}
