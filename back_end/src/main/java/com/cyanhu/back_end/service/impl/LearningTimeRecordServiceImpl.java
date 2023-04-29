package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.cyanhu.back_end.mapper.LearningTimeRecordMapper;
import com.cyanhu.back_end.service.ILearningTimeRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class LearningTimeRecordServiceImpl extends ServiceImpl<LearningTimeRecordMapper, LearningTimeRecord> implements ILearningTimeRecordService {
    @Autowired
    LearningTimeRecordMapper learningTimeRecordMapper;
    @Override
    public long getTodayTimeByUserId(Integer userId) {
        Long time = learningTimeRecordMapper.getTodayTimeByUserId(userId);
        if (time == null) return 0;
        return time;
    }

    @Override
    public long getTotalTimeByUserId(Integer userId) {
        Long time = learningTimeRecordMapper.getTotalTimeByUserId(userId);
        if (time == null) return 0;
        return time;
    }
}
