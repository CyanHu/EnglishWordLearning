package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.WordBook;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface IWordBookService extends IService<WordBook> {
    List<String> getBookWordList(Integer bookId);

}
