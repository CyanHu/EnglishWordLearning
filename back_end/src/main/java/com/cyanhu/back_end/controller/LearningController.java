package com.cyanhu.back_end.controller;

import cn.hutool.core.date.DateTime;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.cyanhu.back_end.entity.*;
import com.cyanhu.back_end.entity.dto.LearningRecordDTO;
import com.cyanhu.back_end.entity.dto.ReviewItemDTO;
import com.cyanhu.back_end.entity.vo.ReviewItemVO;
import com.cyanhu.back_end.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
public class LearningController {
    @Autowired
    ILearningTimeRecordService learningTimeRecordService;

    @Autowired
    ILearningWordRecordService learningWordRecordService;

    @Autowired
    ILearningWordService learningWordService;

    static int[] INTERVAL_TIME = {1, 1, 2, 4, 7, 15, 30};//复习间隔时间， 7次算学习完成，easy + 1， med - 2， diff 清0


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
    @PostMapping("/learning/review/{userId}")
    public Map<String, Object> review(@RequestBody List<ReviewItemDTO> ReviewList, @PathVariable Integer userId) {
        for (ReviewItemDTO reviewItemDTO : ReviewList) {
            Integer learningWordId = reviewItemDTO.getLearningWordId();
            String firstType = reviewItemDTO.getFirstType();
            LearningWord learningWord = learningWordService.getById(learningWordId);
            int learningCount = learningWord.getLearningCount();
            int wordId = learningWord.getWordId();
            LocalDateTime leaningTime = LocalDateTime.now();
            if ("认识".equals(firstType)) {
                learningCount ++;
            }
            else if ("模糊".equals(firstType)) {
                if (learningCount <= 2) {
                    learningCount = 0;
                } else {
                    learningCount -= 2;
                }
            } else {
                learningCount = 0;
            }
            LocalDateTime nextReviewTime = getNextReviewTime(learningCount);
            UpdateWrapper<LearningWord> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("id", learningWordId).set("learning_count", learningCount).set("last_learning_time", LocalDateTime.now()).set("next_review_time", nextReviewTime);
            learningWordService.update(updateWrapper);
        }
        return Map.of("error_message", "成功");
    }

    @PostMapping("learning/learning/{userId}")
    public Map<String, Object> learning(@RequestBody List<Integer> learningList, @PathVariable Integer userId) {

        LearningWord learningWord = new LearningWord().setLastLearningTime(LocalDateTime.now()).setLearningCount(1).setNextReviewTime(getNextReviewTime(1)).setUserId(userId);
        for (Integer wordId : learningList) {
            learningWord.setId(null).setWordId(wordId);
            learningWordService.save(learningWord);
        }

        return Map.of("error_message", "成功");
    }

    LocalDateTime getNextReviewTime(int learningCount) {
        int reviewDay = INTERVAL_TIME[learningCount];
        LocalDateTime nextReviewTime = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0).withNano(0).plusDays(reviewDay);
        return nextReviewTime;
    }


    @Autowired
    IUserSelectedBookService userSelectedBookService;

    @GetMapping("/learning/brief/{userId}")
    public Map<String, Object> getLearningBrief(@PathVariable Integer userId) {
        UserSelectedBook userSelectedBook = userSelectedBookService.getOne(new QueryWrapper<UserSelectedBook>().eq("user_id", userId));
        if (userSelectedBook == null) return Map.of("error_message", "未选择单词书");
        int nonLearningWordCount = learningWordService.getNonLearningWordCount(userId, userSelectedBook.getBookId());
        int needReviewWordCount = (int) learningWordService.count(new QueryWrapper<LearningWord>().le("next_review_time", DateTime.now()));
        return Map.of("error_message", "成功", "data", Map.of("nonLearningWordCount", nonLearningWordCount, "needReviewWordCount", needReviewWordCount));
    }

    @GetMapping("/learning/reviewWordIdList/{userId}")
    public Map<String, Object> getReviewWordIdVOList(@PathVariable Integer userId) {
        QueryWrapper<LearningWord> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.last("limit 10");
        queryWrapper.le("next_review_time", DateTime.now());
        List<LearningWord> list = learningWordService.list(queryWrapper);
        List<ReviewItemVO> reviewItemVOList =  list.stream().map(e->new ReviewItemVO().setLearningWordId(e.getId()).setWordId(e.getWordId())).toList();
        return Map.of("error_message", "成功", "data", Map.of("reviewItemVOList", reviewItemVOList));
    }

    @GetMapping("/learning/nonLearningWordIdList/{userId}")
    public Map<String, Object> getNonLearningWordIdList(@PathVariable Integer userId) {
        UserSelectedBook userSelectedBook = userSelectedBookService.getOne(new QueryWrapper<UserSelectedBook>().eq("user_id", userId));
        if (userSelectedBook == null) return Map.of("error_message", "未选择单词书");
        Integer bookId = userSelectedBook.getBookId();
        List<Integer> nonLearningWordIdList = learningWordService.getNonLearningWordIdList(userId, bookId);
        return Map.of("error_message", "成功", "data", Map.of("nonLearningWordIdList", nonLearningWordIdList));
    }



}
