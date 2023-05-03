package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.mapper.UserMapper;
import com.cyanhu.back_end.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {
    @Autowired
    UserMapper userMapper;

    @RequestMapping("/user/all")
    public List<User> getAll() {
        return userMapper.selectList(null);
    }

}
