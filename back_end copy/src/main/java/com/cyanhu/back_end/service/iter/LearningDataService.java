package com.cyanhu.back_end.service.iter;

import com.cyanhu.back_end.pojo.vo.LearningDataBriefVO;
import com.cyanhu.back_end.pojo.vo.LearningDataVO;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public interface LearningDataService {
    LearningDataBriefVO getLearnDataBrief(int userId);
    Map<String, Object> getRecentWeekLearnData(int userId);
    Map<String, Object> getRecentYearLearnData(int userId);
}
