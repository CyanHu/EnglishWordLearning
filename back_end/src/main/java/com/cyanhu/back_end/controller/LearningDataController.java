package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.cyanhu.back_end.entity.vo.LearningDataBriefVO;
import com.cyanhu.back_end.entity.vo.LearningDataVO;
import com.cyanhu.back_end.service.ILearningTimeRecordService;
import com.cyanhu.back_end.service.ILearningWordRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class LearningDataController {
    @Autowired
    ILearningTimeRecordService learningTimeRecordService;
    @Autowired
    ILearningWordRecordService learningWordRecordService;
    @GetMapping("/learningData/brief/{userId}")
    public Map<String, Object> getLearningDataBriefVO(@PathVariable Integer userId) {
        LearningDataBriefVO learningDataBriefVO = new LearningDataBriefVO();
        long todayTime = learningTimeRecordService.getTodayTimeByUserId(userId);
        long totalTime = learningTimeRecordService.getTotalTimeByUserId(userId);
        int todayMinutes = (int) (todayTime / 60);
        int totalMinutes = (int) (totalTime / 60);
        int todayWordCounts = learningWordRecordService.getTodayWordCountsByUserId(userId);
        int totalWordCounts = learningWordRecordService.getTotalWordCountsByUserId(userId);

        learningDataBriefVO.setTodayLearningData(new LearningDataVO().setLearningMinutes(todayMinutes).setLearningWordCounts(todayWordCounts));
        learningDataBriefVO.setTotalLearningData(new LearningDataVO().setLearningMinutes(totalMinutes).setLearningWordCounts(totalWordCounts));
        return Map.of("error_message", "成功", "data", learningDataBriefVO);
    }

}
