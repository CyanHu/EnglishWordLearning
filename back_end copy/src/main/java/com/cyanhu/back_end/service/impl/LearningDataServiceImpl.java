package com.cyanhu.back_end.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cyanhu.back_end.mapper.LearningTimeRecordMapper;
import com.cyanhu.back_end.mapper.LearningWordRecordMapper;
import com.cyanhu.back_end.pojo.LearningTimeRecord;
import com.cyanhu.back_end.pojo.LearningWord;
import com.cyanhu.back_end.pojo.LearningWordRecord;
import com.cyanhu.back_end.pojo.vo.LearningDataBriefVO;
import com.cyanhu.back_end.service.iter.LearningDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class LearningDataServiceImpl implements LearningDataService {
    @Autowired
    LearningTimeRecordMapper learningTimeRecordMapper;
    @Autowired
    LearningWordRecordMapper learningWordRecordMapper;

    @Override
    public LearningDataBriefVO getLearnDataBrief(int userId) {
        QueryWrapper<LearningTimeRecord> timeRecordQueryWrapper = new QueryWrapper<>();
        timeRecordQueryWrapper.select("sum(end_time - start_time) as sumAll");
        QueryWrapper<LearningWordRecord> wordRecordQueryWrapper = new QueryWrapper<>();
        return null;
    }

    @Override
    public Map<String, Object> getRecentWeekLearnData(int userId) {
        return null;
    }

    @Override
    public Map<String, Object> getRecentYearLearnData(int userId) {
        return null;
    }
}
