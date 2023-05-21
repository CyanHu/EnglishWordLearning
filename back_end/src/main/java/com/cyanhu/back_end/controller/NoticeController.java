package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cyanhu.back_end.entity.BookWord;
import com.cyanhu.back_end.entity.Notice;
import com.cyanhu.back_end.entity.WordBook;
import com.cyanhu.back_end.mapper.NoticeMapper;

import com.cyanhu.back_end.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
public class NoticeController {
    @Autowired
    INoticeService noticeService;

    @PostMapping("/notice/add")
    Map<String, Object> addNotice(@RequestBody Notice notice) {
        notice.setNoticeTime(LocalDateTime.now());
        System.out.println(notice);
        noticeService.save(notice);
        return Map.of("error_message", "添加成功");
    }

    @GetMapping("/notice/all")
    Map<String, Object> getAll() {
        List<Notice> notices = noticeService.list(null);
        return Map.of("error_message", "成功", "data", Map.of("notices", notices));
    }

    @PostMapping(value = "/notice/delete/{noticeId}")
    public Map<String, Object>  deleteNotice(@PathVariable Integer noticeId) {

        noticeService.removeById(noticeId);

        return Map.of("error_message", "删除成功");

    }

    @PostMapping(value = "/notice/update")
    public Map<String, Object>  updateWordBook(@RequestBody Notice notice) {
        noticeService.updateById(notice);
        return Map.of("error_message", "更新成功");
    }

}
