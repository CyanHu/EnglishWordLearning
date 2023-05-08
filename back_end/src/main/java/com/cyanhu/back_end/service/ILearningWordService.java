package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.LearningWord;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface ILearningWordService extends IService<LearningWord> {
    int getNonLearningWordCount(Integer userId, Integer bookId);
    List<Integer> getNonLearningWordIdList(Integer userId, Integer bookId);
}
