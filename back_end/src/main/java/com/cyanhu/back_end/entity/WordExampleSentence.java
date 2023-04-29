package com.cyanhu.back_end.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
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
@TableName("word_example_sentence")
public class WordExampleSentence {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer wordId;

    private String sentence;

    private String sentenceTranslation;

    private String source;
}
