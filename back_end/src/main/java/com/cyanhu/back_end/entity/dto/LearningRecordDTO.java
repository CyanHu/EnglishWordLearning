package com.cyanhu.back_end.entity.dto;



import lombok.*;
import lombok.experimental.Accessors;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
public class LearningRecordDTO {
    private Integer userId;
    private String learningType;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private List<Integer> wordIdList;

    @Override
    public String toString() {
        return "LearningRecordDTO{" +
                "userId=" + userId +
                ", learningType='" + learningType + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", wordIdList=" + wordIdList +
                '}';
    }
}
