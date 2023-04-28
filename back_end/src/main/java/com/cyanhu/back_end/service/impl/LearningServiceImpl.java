package com.cyanhu.back_end.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cyanhu.back_end.mapper.LearningTimeRecordMapper;
import com.cyanhu.back_end.mapper.LearningWordMapper;
import com.cyanhu.back_end.mapper.LearningWordRecordMapper;
import com.cyanhu.back_end.pojo.LearningTimeRecord;
import com.cyanhu.back_end.pojo.LearningWord;
import com.cyanhu.back_end.pojo.LearningWordRecord;
import com.cyanhu.back_end.pojo.dto.LearningRecordDTO;
import com.cyanhu.back_end.service.iter.LearningService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LearningServiceImpl extends ServiceImpl<LearningWordMapper, LearningWord> implements LearningService {
    @Autowired
    LearningTimeRecordMapper learningTimeRecordMapper;
    @Autowired
    LearningWordRecordMapper learningWordRecordMapper;
    @Autowired
    LearningWordMapper learningWordMapper;

    static int INTERVAL_TIME[] = {1, 1, 2, 4, 7, 15, 30};//复习间隔时间， 7次算学习完成，easy + 1， med - 2， diff 清0

    @Transactional
    @Override
    public void addLearningRecord(LearningRecordDTO learningRecordDTO) {
        Integer userId = learningRecordDTO.getUserId();
        String learningType = learningRecordDTO.getLearningType();
        learningTimeRecordMapper.insert(new LearningTimeRecord(null, learningRecordDTO.getStartTime(), learningRecordDTO.getEndTime(), userId));

        for (Integer wordId : learningRecordDTO.getWordIdList()) {
            learningWordRecordMapper.insert(new LearningWordRecord(null, userId, wordId, learningType, learningRecordDTO.getEndTime()));
        }
    }

    @Override
    public boolean updateLearningWord(LearningWord learningWord) {
        return true;
    }

}
