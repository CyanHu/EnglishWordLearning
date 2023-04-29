package com.cyanhu.back_end.service.impl;

import com.cyanhu.back_end.entity.SignInRecord;
import com.cyanhu.back_end.mapper.SignInRecordMapper;
import com.cyanhu.back_end.service.ISignInRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class SignInRecordServiceImpl extends ServiceImpl<SignInRecordMapper, SignInRecord> implements ISignInRecordService {
    @Autowired
    SignInRecordMapper signInRecordMapper;
    @Override
    public Boolean isSingInByUserId(Integer userId) {
        return signInRecordMapper.isSingInByUserId(userId);
    }
}
