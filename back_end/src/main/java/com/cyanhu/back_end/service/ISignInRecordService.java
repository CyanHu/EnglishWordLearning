package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.SignInRecord;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface ISignInRecordService extends IService<SignInRecord> {
    Boolean isSingInByUserId(Integer userId);
}
