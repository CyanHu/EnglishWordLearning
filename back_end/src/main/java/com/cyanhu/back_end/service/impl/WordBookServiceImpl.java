package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.WordBook;
import com.cyanhu.back_end.mapper.WordBookMapper;
import com.cyanhu.back_end.service.IWordBookService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class WordBookServiceImpl extends ServiceImpl<WordBookMapper, WordBook> implements IWordBookService {

    @Autowired
    WordBookMapper wordBookMapper;
    @Override
    public List<String> getBookWordList(Integer bookId) {
        return wordBookMapper.getBookWordList(bookId);
    }
}
