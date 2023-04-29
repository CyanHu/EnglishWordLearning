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
@TableName("word_book")
public class WordBook {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String bookType;

    private Integer userId;

    private String bookTitle;

    private String bookDescription;
}
