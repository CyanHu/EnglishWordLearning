package com.cyanhu.back_end.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("learning_word")
public class LearningWord {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    private Integer wordId;

    private Integer learningCount;

    private LocalDateTime nextReviewTime;

    private LocalDateTime lastLearningTime;
}
