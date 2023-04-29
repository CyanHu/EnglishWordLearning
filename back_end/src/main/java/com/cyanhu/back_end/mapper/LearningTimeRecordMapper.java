package com.cyanhu.back_end.mapper;

import com.cyanhu.back_end.entity.LearningTimeRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface LearningTimeRecordMapper extends BaseMapper<LearningTimeRecord> {
    Long getTodayTimeByUserId(Integer userId);
    Long getTotalTimeByUserId(Integer userId);
}
