package com.spring.cms.controller;

import com.spring.cms.model.Job;
import com.spring.cms.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/jobs")
public class JobController {

    @Autowired
    private JobService jobService;

    // Create a new job
    @PostMapping
    public ResponseEntity<?> createJob(@RequestBody Job job) {
        try {
            Job createdJob = jobService.createJob(job);
            return ResponseEntity.ok(createdJob);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Get all jobs
    @GetMapping
    public ResponseEntity<List<Job>> getAllJobs() {
        List<Job> jobs = jobService.getAllJobs();
        return ResponseEntity.ok(jobs);
    }

    // Get job by ID
    @GetMapping("/{id}")
    public ResponseEntity<?> getJobById(@PathVariable Long id) {
        Optional<Job> job = jobService.getJobById(id);
        if (job.isPresent()) {
            return ResponseEntity.ok(job.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Update job
    @PutMapping("/{id}")
    public ResponseEntity<?> updateJob(@PathVariable Long id, @RequestBody Job job) {
        try {
            job.setId(id); // Ensure the ID is set
            Job updatedJob = jobService.updateJob(job);
            return ResponseEntity.ok(updatedJob);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Delete job
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteJob(@PathVariable Long id) {
        try {
            jobService.deleteJob(id);
            return ResponseEntity.ok("Job deleted successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // Search jobs by title
    @GetMapping("/search/title")
    public ResponseEntity<List<Job>> searchByTitle(@RequestParam String title) {
        return ResponseEntity.ok(jobService.searchByTitle(title));
    }

    // Search jobs by location
    @GetMapping("/search/location")
    public ResponseEntity<List<Job>> searchByLocation(@RequestParam String location) {
        return ResponseEntity.ok(jobService.searchByLocation(location));
    }

    // Search jobs by company name
    @GetMapping("/search/company")
    public ResponseEntity<List<Job>> searchByCompanyName(@RequestParam String companyName) {
        return ResponseEntity.ok(jobService.searchByCompanyName(companyName));
    }

    // Filter jobs by employment type
    @GetMapping("/filter/type")
    public ResponseEntity<List<Job>> filterByEmploymentType(@RequestParam String type) {
        return ResponseEntity.ok(jobService.filterByEmploymentType(type));
    }
} 