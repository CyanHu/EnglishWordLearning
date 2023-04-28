package com.cyanhu.back_end.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LearningTimeRecord {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Timestamp startTime;
    private Timestamp endTime;
    private Integer userId;
}