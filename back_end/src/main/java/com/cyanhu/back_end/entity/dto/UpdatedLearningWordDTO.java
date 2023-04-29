package com.cyanhu.back_end.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class UpdatedLearningWordDTO {
    private Integer userId;
    private Integer wordId;
    private Integer learningCount;
    private String level;
}
