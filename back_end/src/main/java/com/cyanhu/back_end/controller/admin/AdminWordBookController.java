package com.cyanhu.back_end.controller.admin;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
public class AdminWordBookController {
    @GetMapping("/admin/wordBook/test")
    public String test() {
        return "res";
    }
}
