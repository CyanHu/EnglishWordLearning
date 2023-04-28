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
@NoArgsConstructor
@AllArgsConstructor
@TableName("learning_word")
public class LearningWord implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    private Integer wordId;

    private Integer learningCount;

    private LocalDateTime nextReviewTime;

    private LocalDateTime lastLearningTime;

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

    public Integer getLearningCount() {
        return learningCount;
    }

    public void setLearningCount(Integer learningCount) {
        this.learningCount = learningCount;
    }

    public LocalDateTime getNextReviewTime() {
        return nextReviewTime;
    }

    public void setNextReviewTime(LocalDateTime nextReviewTime) {
        this.nextReviewTime = nextReviewTime;
    }

    public LocalDateTime getLastLearningTime() {
        return lastLearningTime;
    }

    public void setLastLearningTime(LocalDateTime lastLearningTime) {
        this.lastLearningTime = lastLearningTime;
    }

    @Override
    public String toString() {
        return "LearningWord{" +
            "id = " + id +
            ", userId = " + userId +
            ", wordId = " + wordId +
            ", learningCount = " + learningCount +
            ", nextReviewTime = " + nextReviewTime +
            ", lastLearningTime = " + lastLearningTime +
        "}";
    }
}
