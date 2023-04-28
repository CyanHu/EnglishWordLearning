package com.cyanhu.back_end.entity.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WordBookDTO {
    private String bookTitle;
    private String bookDescription;
    private String bookType;
    private Integer userId;
    private MultipartFile bookFile;
}
