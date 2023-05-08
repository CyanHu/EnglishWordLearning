package com.cyanhu.back_end.entity.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@Accessors(chain = true)
@AllArgsConstructor
public class ReviewItemVO {
    private Integer wordId;
    private Integer learningWordId;
}
