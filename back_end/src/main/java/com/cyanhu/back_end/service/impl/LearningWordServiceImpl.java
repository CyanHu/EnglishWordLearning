package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.LearningWord;
import com.cyanhu.back_end.mapper.LearningWordMapper;
import com.cyanhu.back_end.service.ILearningWordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class LearningWordServiceImpl extends ServiceImpl<LearningWordMapper, LearningWord> implements ILearningWordService {
    @Autowired
    LearningWordMapper learningWordMapper;

    @Override
    public int getNonLearningWordCount(Integer userId, Integer bookId) {
        return learningWordMapper.getNonLearningWordCount(userId, bookId);
    }

    @Override
    public List<Integer> getNonLearningWordIdList(Integer userId, Integer bookId) {
        return learningWordMapper.getNonLearningWordIdList(userId, bookId);
    }
}
