package com.cyanhu.back_end.entity.vo;

import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class LearningDataBriefVO {
    private LearningDataVO todayLearningData;
    private LearningDataVO totalLearningData;
}
