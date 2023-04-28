package com.cyanhu.back_end.entity.dto;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LearningRecordDTO {
    private Integer userId;
    private String learningType;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private List<Integer> wordIdList;
}
