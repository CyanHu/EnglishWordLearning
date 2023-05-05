package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface ILearningTimeRecordService extends IService<LearningTimeRecord> {
    long getTodayTimeByUserId(Integer userId);
    long getTotalTimeByUserId(Integer userId);
    List<Map<String, Object>> getRecentWeekTimeByUserId(Integer userId);
}
