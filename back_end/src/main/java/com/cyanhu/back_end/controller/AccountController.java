package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class AccountController {
    @Autowired
    IUserService userService;

    @GetMapping("/user/account/info")
    public Map<String, String> getInfo() {
        return userService.getInfo();
    }

    @PostMapping("/user/account/token")
    public Map<String, String> getToken(@RequestBody Map<String, String> map) {
        String username = map.get("username");
        String password = map.get("password");
        return userService.getToken(username, password);
    }

    @PostMapping("/user/account/register")
    public Map<String, String> register(@RequestBody Map<String, String> map) {
        String username = map.get("username");
        String password = map.get("password");
        return userService.register(username, password);
    }
}
