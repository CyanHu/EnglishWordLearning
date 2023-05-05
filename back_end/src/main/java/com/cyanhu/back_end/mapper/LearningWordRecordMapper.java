package com.cyanhu.back_end.mapper;

import com.cyanhu.back_end.entity.LearningWordRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface LearningWordRecordMapper extends BaseMapper<LearningWordRecord> {
    Integer getTodayWordCountsByUserId(Integer userId);
    Integer getTotalWordCountsByUserId(Integer userId);
    List<Map<String, Object>> getRecentWeekWordCountsByUserId(Integer userId);
}
