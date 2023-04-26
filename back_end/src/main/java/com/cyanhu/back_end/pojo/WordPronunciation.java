package com.cyanhu.back_end.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WordPronunciation {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer wordId;
    private String type;
    private String phoneticSymbol;
}