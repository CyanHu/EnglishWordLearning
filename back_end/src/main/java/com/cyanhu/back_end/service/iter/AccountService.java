package com.cyanhu.back_end.service.iter;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cyanhu.back_end.pojo.User;

import java.util.Map;

public interface AccountService {
    Map<String, String> getInfo();
    Map<String, String> getToken(String username, String password);
    Map<String, String> register(String username, String password);
}
