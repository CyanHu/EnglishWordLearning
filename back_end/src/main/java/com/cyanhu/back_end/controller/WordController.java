package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.pojo.dto.AddedWordDataDTO;
import com.cyanhu.back_end.service.iter.WordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class WordController {
    @Autowired
    WordService wordService;

    @PostMapping("/word/add")
    public Map<String, Object> addWordData(@RequestBody AddedWordDataDTO dto) {
        System.out.println(dto);
        return wordService.addWordData(dto);
    }
}
