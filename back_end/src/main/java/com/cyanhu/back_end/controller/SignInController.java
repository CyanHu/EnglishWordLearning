package com.cyanhu.back_end.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.entity.SignInRecord;
import com.cyanhu.back_end.entity.vo.SingleSignInRecordVO;
import com.cyanhu.back_end.service.ILearningTimeRecordService;
import com.cyanhu.back_end.service.ILearningWordRecordService;
import com.cyanhu.back_end.service.ILearningWordService;
import com.cyanhu.back_end.service.ISignInRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.Map;

@RestController
public class SignInController {
    @Autowired
    ISignInRecordService signInRecordService;
    @Autowired
    ILearningTimeRecordService learningTimeRecordService;
    @Autowired
    ILearningWordRecordService learningWordRecordService;

    @GetMapping("/signIn/single/{userId}")
    public Map<String, Object> getSingleSignInRecordVO(@PathVariable Integer userId) {
        Boolean isSignIn = signInRecordService.isSingInByUserId(userId);
        long signInDay = signInRecordService.count(new QueryWrapper<SignInRecord>().eq("user_id", userId));
        SingleSignInRecordVO singleSignInRecordVO = new SingleSignInRecordVO();
        singleSignInRecordVO.setSignIn(isSignIn).setSignInDay((int)signInDay);
        return Map.of("error_message", "成功", "data", singleSignInRecordVO);
    }
    @PostMapping("/signIn/single/{userId}")
    public Map<String, Object> SignIn(@PathVariable Integer userId) {
        Boolean isSignIn = signInRecordService.isSingInByUserId(userId);
        if (isSignIn) {
            return Map.of("error_message", "已经签到了");
        }
        long todayTime = learningTimeRecordService.getTodayTimeByUserId(userId);
        int todayMinutes = (int) (todayTime / 60);
        int todayWordCounts = learningWordRecordService.getTodayWordCountsByUserId(userId);
        if (todayMinutes < 10 || todayWordCounts < 20) {
            return Map.of("error_message", "未达标");
        }
        signInRecordService.save(new SignInRecord().setUserId(userId).setSignInTime(LocalDateTime.now()));
        return Map.of("error_message", "成功");
    }

}
