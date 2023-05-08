package com.cyanhu.back_end.mapper;

import com.cyanhu.back_end.entity.LearningWord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface LearningWordMapper extends BaseMapper<LearningWord> {
    int getNonLearningWordCount(@Param("userId")Integer userId, @Param("bookId")Integer bookId);
    List<Integer> getNonLearningWordIdList(@Param("userId")Integer userId, @Param("bookId")Integer bookId);
}
