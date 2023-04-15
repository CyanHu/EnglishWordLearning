package com.cyanhu.back_end.service.user.account;


import java.util.Map;

public interface LoginService {
    Map<String, String> getToken(String username, String password);
}
