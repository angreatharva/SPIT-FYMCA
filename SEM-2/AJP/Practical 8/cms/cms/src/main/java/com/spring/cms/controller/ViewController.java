package com.spring.cms.controller;

import com.spring.cms.model.Job;
import com.spring.cms.service.JobService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class ViewController {

    @Autowired
    private JobService jobService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("title", "Job Portal - Login");
        return "index";
    }
    
    @GetMapping("/home")
    public String home(Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            // If not logged in, redirect to login page
            return "redirect:/";
        }
        
        model.addAttribute("title", "Job Portal Dashboard");
        return "home";
    }
    
    @GetMapping("/jobs/post")
    public String postJob(Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        model.addAttribute("title", "Post a New Job");
        model.addAttribute("job", new Job());
        return "post-job";
    }
    
    @GetMapping("/jobs/view")
    public String viewJobs(Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        List<Job> jobs = jobService.getAllJobs();
        model.addAttribute("title", "View All Jobs");
        model.addAttribute("jobs", jobs);
        return "view-jobs";
    }
    
    @GetMapping("/jobs/update")
    public String updateJobSelection(Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        List<Job> jobs = jobService.getAllJobs();
        model.addAttribute("title", "Select Job to Update");
        model.addAttribute("jobs", jobs);
        return "update-job-selection";
    }
    
    @GetMapping("/jobs/update/{id}")
    public String updateJob(@PathVariable Long id, Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        Optional<Job> jobOptional = jobService.getJobById(id);
        if (jobOptional.isEmpty()) {
            return "redirect:/jobs/update";
        }
        
        model.addAttribute("title", "Update Job");
        model.addAttribute("job", jobOptional.get());
        return "update-job";
    }
    
    @GetMapping("/jobs/delete")
    public String deleteJob(Model model, HttpSession session) {
        // Check if user is logged in
        Object user = session.getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        
        List<Job> jobs = jobService.getAllJobs();
        model.addAttribute("title", "Delete Job");
        model.addAttribute("jobs", jobs);
        return "delete-job";
    }
} 