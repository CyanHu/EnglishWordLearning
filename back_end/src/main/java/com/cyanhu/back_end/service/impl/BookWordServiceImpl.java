package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.BookWord;
import com.cyanhu.back_end.mapper.BookWordMapper;
import com.cyanhu.back_end.service.IBookWordService;
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
public class BookWordServiceImpl extends ServiceImpl<BookWordMapper, BookWord> implements IBookWordService {

}
