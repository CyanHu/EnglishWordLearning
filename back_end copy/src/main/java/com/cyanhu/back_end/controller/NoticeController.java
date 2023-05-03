package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cyanhu.back_end.mapper.NoticeMapper;
import com.cyanhu.back_end.pojo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class NoticeController {
    @Autowired
    NoticeMapper noticeMapper;

    @PostMapping("/notice/add")
    Map<String, Object> addNotice(@RequestBody Notice notice) {
        System.out.println(notice);
        noticeMapper.insert(notice);
        return Map.of("error_message", "成功");
    }

    @GetMapping("/notice/all")
    Map<String, Object> getAll() {
        List<Notice> notices = noticeMapper.selectList(null);
        return Map.of("error_message", "成功", "data", Map.of("notices", notices));
    }
}
