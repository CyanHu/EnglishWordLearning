package com.cyanhu.back_end.service;

import com.cyanhu.back_end.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
public interface IUserService extends IService<User> {
    Map<String, Object> getInfo();
    Map<String, Object> getToken(String username, String password);
    Map<String, Object> register(String username, String password);
}
