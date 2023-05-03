package com.cyanhu.back_end.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LearningDataBriefVO {
    private LearningDataVO todayLearningData;
    private LearningDataVO totalLearningData;
}
