package com.cyanhu.back_end.service.iter;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cyanhu.back_end.pojo.LearningWord;
import com.cyanhu.back_end.pojo.dto.LearningRecordDTO;

public interface LearningService extends IService<LearningWord> {
    void addLearningRecord(LearningRecordDTO learningRecordDTO);

    boolean updateLearningWord(LearningWord learningWord);
}
