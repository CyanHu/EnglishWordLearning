package com.cyanhu.back_end.entity.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.sql.Timestamp;


@Getter
@Setter
@Accessors(chain = true)
public class LearningDataVO {
    private int learningWordCounts;
    private int learningMinutes;
}
