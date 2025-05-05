package com.spring.cms.service;

import com.spring.cms.model.Job;
import com.spring.cms.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class JobService {

    @Autowired
    private JobRepository jobRepository;

    // Create a new job
    public Job createJob(Job job) {
        if (job.getPostedDate() == null) {
            job.setPostedDate(LocalDateTime.now());
        }
        return jobRepository.save(job);
    }

    // Get all jobs
    public List<Job> getAllJobs() {
        return jobRepository.findAll();
    }

    // Get job by ID
    public Optional<Job> getJobById(Long id) {
        return jobRepository.findById(id);
    }

    // Update job
    public Job updateJob(Job job) {
        if (job.getId() == null || !jobRepository.existsById(job.getId())) {
            throw new RuntimeException("Job not found");
        }
        return jobRepository.save(job);
    }

    // Delete job
    public void deleteJob(Long id) {
        if (!jobRepository.existsById(id)) {
            throw new RuntimeException("Job not found");
        }
        jobRepository.deleteById(id);
    }

    // Search jobs by title
    public List<Job> searchByTitle(String title) {
        return jobRepository.findByTitleContainingIgnoreCase(title);
    }

    // Search jobs by location
    public List<Job> searchByLocation(String location) {
        return jobRepository.findByLocationContainingIgnoreCase(location);
    }

    // Search jobs by company name
    public List<Job> searchByCompanyName(String companyName) {
        return jobRepository.findByCompanyNameContainingIgnoreCase(companyName);
    }

    // Filter jobs by employment type
    public List<Job> filterByEmploymentType(String employmentType) {
        return jobRepository.findByEmploymentType(employmentType);
    }
} 