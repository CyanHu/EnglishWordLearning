package com.cyanhu.back_end.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@AllArgsConstructor
@NoArgsConstructor
@TableName("learning_word_record")
public class LearningWordRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    private Integer wordId;

    private String learningType;

    private LocalDateTime learningTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getWordId() {
        return wordId;
    }

    public void setWordId(Integer wordId) {
        this.wordId = wordId;
    }

    public String getLearningType() {
        return learningType;
    }

    public void setLearningType(String learningType) {
        this.learningType = learningType;
    }

    public LocalDateTime getLearningTime() {
        return learningTime;
    }

    public void setLearningTime(LocalDateTime learningTime) {
        this.learningTime = learningTime;
    }

    @Override
    public String toString() {
        return "LearningWordRecord{" +
            "id = " + id +
            ", userId = " + userId +
            ", wordId = " + wordId +
            ", learningType = " + learningType +
            ", learningTime = " + learningTime +
        "}";
    }
}
