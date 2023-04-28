package com.cyanhu.back_end.controller;

import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.cyanhu.back_end.entity.LearningWordRecord;
import com.cyanhu.back_end.entity.dto.LearningRecordDTO;
import com.cyanhu.back_end.service.ILearningTimeRecordService;
import com.cyanhu.back_end.service.ILearningWordRecordService;
import com.cyanhu.back_end.service.ILearningWordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class LearningController {
    @Autowired
    ILearningTimeRecordService learningTimeRecordService;

    @Autowired
    ILearningWordRecordService learningWordRecordService;

    @Autowired
    ILearningWordService learningWordService;

    static int INTERVAL_TIME[] = {1, 1, 2, 4, 7, 15, 30};//复习间隔时间， 7次算学习完成，easy + 1， med - 2， diff 清0


    @PostMapping("/learning/record/add")
    public Map<String, Object> addLearningRecord(@RequestBody LearningRecordDTO learningRecordDTO) {
        Integer userId = learningRecordDTO.getUserId();
        String learningType = learningRecordDTO.getLearningType();
        learningTimeRecordService.save(new LearningTimeRecord(null, userId, learningRecordDTO.getStartTime(), learningRecordDTO.getEndTime()));
        for (Integer wordId : learningRecordDTO.getWordIdList()) {
            learningWordRecordService.save(new LearningWordRecord(null, userId, wordId, learningType, learningRecordDTO.getEndTime()));
        }
        return Map.of("error_message", "成功");
    }
    @GetMapping("/learning/{userId}/{wordId}/{level}")
    public Map<String, Object> updateLearningWord(@PathVariable Integer userId, @PathVariable Integer wordId, @PathVariable String level) {
        return null;
    }
}
