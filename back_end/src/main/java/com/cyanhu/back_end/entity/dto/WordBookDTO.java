package com.cyanhu.back_end.entity.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import lombok.*;
import lombok.experimental.Accessors;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@Accessors(chain = true)
public class WordBookDTO {
    private String bookTitle;
    private String bookDescription;
    private String bookType;
    private Integer userId;
    private MultipartFile bookFile;
}
