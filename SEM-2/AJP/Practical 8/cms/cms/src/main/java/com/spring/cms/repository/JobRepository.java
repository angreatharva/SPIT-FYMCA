package com.spring.cms.repository;

import com.spring.cms.model.Job;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface JobRepository extends JpaRepository<Job, Long> {
    List<Job> findByTitleContainingIgnoreCase(String title);
    List<Job> findByLocationContainingIgnoreCase(String location);
    List<Job> findByCompanyNameContainingIgnoreCase(String companyName);
    List<Job> findByEmploymentType(String employmentType);
} 