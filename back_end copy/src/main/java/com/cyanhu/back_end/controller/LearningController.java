package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.pojo.dto.LearningRecordDTO;
import com.cyanhu.back_end.service.iter.LearningService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class LearningController {
    @Autowired
    LearningService learningService;


    @PostMapping("/learning/record/add")
    public Map<String, Object> addLearningRecord(@RequestBody LearningRecordDTO learningRecordDTO) {
        learningService.addLearningRecord(learningRecordDTO);
        return Map.of("error_message", "成功");
    }
    @GetMapping("/learning/{userId}/{wordId}/{level}")
    public Map<String, Object> updateLearningWord(@PathVariable Integer userId, @PathVariable Integer wordId, @PathVariable String level) {
        return null;
    }
}
