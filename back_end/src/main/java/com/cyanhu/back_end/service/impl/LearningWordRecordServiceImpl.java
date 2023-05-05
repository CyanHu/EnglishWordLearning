package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.LearningWordRecord;
import com.cyanhu.back_end.mapper.LearningWordRecordMapper;
import com.cyanhu.back_end.service.ILearningWordRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class LearningWordRecordServiceImpl extends ServiceImpl<LearningWordRecordMapper, LearningWordRecord> implements ILearningWordRecordService {
    @Autowired
    LearningWordRecordMapper learningWordRecordMapper;
    @Override
    public int getTodayWordCountsByUserId(Integer userId) {
        Integer counts = learningWordRecordMapper.getTodayWordCountsByUserId(userId);
        if (counts == null) return 0;
        return counts;
    }

    @Override
    public int getTotalWordCountsByUserId(Integer userId) {
        Integer counts = learningWordRecordMapper.getTotalWordCountsByUserId(userId);
        if (counts == null) return 0;
        return counts;
    }

    @Override
    public List<Map<String, Object>> getRecentWeekWordCountsByUserId(Integer userId) {
        return learningWordRecordMapper.getRecentWeekWordCountsByUserId(userId);
    }
}
