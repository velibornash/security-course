package com.expo.security.repository;

import com.expo.security.model.Section;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SectionRepository extends JpaRepository<Section, Long> {
    List<Section> findAllByOrderBySortOrderAsc();
}
