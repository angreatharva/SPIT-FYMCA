package com.spring.cms.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
public class Home {
    @GetMapping("/api/status")
    public String home(){
        return "Application is Working!! "+new Date();
    }
}
