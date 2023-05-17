package com.cyanhu.back_end.mapper;

import com.cyanhu.back_end.entity.WordBook;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface WordBookMapper extends BaseMapper<WordBook> {
    List<String> getBookWordList(Integer bookId);
}
