package com.cyanhu.back_end.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cyanhu.back_end.pojo.Notice;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper extends BaseMapper<Notice> {
}
