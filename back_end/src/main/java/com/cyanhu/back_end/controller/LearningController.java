package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.cyanhu.back_end.entity.LearningWord;
import com.cyanhu.back_end.entity.LearningWordRecord;
import com.cyanhu.back_end.entity.User;
import com.cyanhu.back_end.entity.dto.LearningRecordDTO;
import com.cyanhu.back_end.entity.dto.UpdatedLearningWordDTO;
import com.cyanhu.back_end.service.ILearningTimeRecordService;
import com.cyanhu.back_end.service.ILearningWordRecordService;
import com.cyanhu.back_end.service.ILearningWordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
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
        System.out.println(learningRecordDTO);
        Integer userId = learningRecordDTO.getUserId();
        String learningType = learningRecordDTO.getLearningType();
        learningTimeRecordService.save(new LearningTimeRecord().setUserId(userId).setStartTime(learningRecordDTO.getStartTime()).setEndTime(learningRecordDTO.getEndTime()));
        for (Integer wordId : learningRecordDTO.getWordIdList()) {
            learningWordRecordService.save(new LearningWordRecord().setUserId(userId).setWordId(wordId).setLearningType(learningType).setLearningTime(learningRecordDTO.getEndTime()));
        }
        return Map.of("error_message", "成功");
    }
    @PostMapping("/learning/word/update")
    public Map<String, Object> updateLearningWord(@RequestBody UpdatedLearningWordDTO updatedLearningWordDTO) {
        Integer userId = updatedLearningWordDTO.getUserId();
        Integer learningCount = updatedLearningWordDTO.getLearningCount();
        String level = updatedLearningWordDTO.getLevel();
        Integer wordId = updatedLearningWordDTO.getWordId();
        QueryWrapper<LearningWord> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId);
        wrapper.eq("word_id", wordId);
        LearningWord learningWord = learningWordService.getOne(wrapper);
        boolean flag = learningWord != null;
        LocalDateTime leaningTime = LocalDateTime.now();
        int reviewDay = 0;
        if ("easy".equals(level)) {
            learningCount ++;
        }
        else if ("medium".equals(level)) {
            if (learningCount <= 2) {
                learningCount = 0;
            } else {
                learningCount -= 2;
            }
        } else {
            learningCount = 0;
        }
        reviewDay = INTERVAL_TIME[learningCount];
        LocalDateTime reviewTime = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0).plusDays(reviewDay);
        learningWord = new LearningWord().setLearningCount(learningCount).setWordId(wordId).setUserId(userId).setLastLearningTime(leaningTime).setNextReviewTime(reviewTime);
        if (!flag) {
            learningWordService.save(learningWord);
        } else {
            learningWordService.update(learningWord, wrapper);
        }
        return Map.of("error_message", "成功");
    }
}
