package com.drivego.report;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ReportRepository extends JpaRepository<Report, Long> {

    List<Report> findByTypeOrderByCreatedAtDesc(String type);

    List<Report> findByOrderByCreatedAtDesc();

    Optional<Report> findByName(String name);
}
