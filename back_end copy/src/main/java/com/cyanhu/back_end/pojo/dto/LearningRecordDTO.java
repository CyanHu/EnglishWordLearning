package com.cyanhu.back_end.pojo.dto;


import com.cyanhu.back_end.pojo.LearningTimeRecord;
import com.cyanhu.back_end.pojo.LearningWordRecord;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LearningRecordDTO {
    private Integer userId;
    private String learningType;
    private Timestamp startTime;
    private Timestamp endTime;
    private List<Integer> wordIdList;
}
