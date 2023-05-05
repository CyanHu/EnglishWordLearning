package com.cyanhu.back_end.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
public class Notice {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String title;

    private String content;

    private String noticeType;

    private LocalDateTime noticeTime;

    private String description;

    private String pictureUrl;
}
