package com.cyanhu.back_end.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cyanhu.back_end.entity.BookWord;
import com.cyanhu.back_end.entity.UserSelectedBook;
import com.cyanhu.back_end.mapper.BookWordMapper;
import com.cyanhu.back_end.mapper.UserSelectedBookMapper;
import com.cyanhu.back_end.service.IBookWordService;
import com.cyanhu.back_end.service.IUserSelectedBookService;
import com.cyanhu.back_end.service.IUserService;
import org.springframework.stereotype.Service;

@Service
public class UserSelectedBookServiceImpl extends ServiceImpl<UserSelectedBookMapper, UserSelectedBook> implements IUserSelectedBookService {
}
