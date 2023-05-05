package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.LearningWordRecord;
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
public interface ILearningWordRecordService extends IService<LearningWordRecord> {
    int getTodayWordCountsByUserId(Integer userId);
    int getTotalWordCountsByUserId(Integer userId);

    List<Map<String, Object>> getRecentWeekWordCountsByUserId(Integer userId);
}
