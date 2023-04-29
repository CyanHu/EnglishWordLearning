package com.cyanhu.back_end.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.cyanhu.back_end.entity.User;
import com.cyanhu.back_end.mapper.UserMapper;
import com.cyanhu.back_end.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cyanhu.back_end.utils.JwtUtil;
import com.cyanhu.back_end.utils.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cyanhu
 * @since 2023-04-28
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired(required = false)
    private UserMapper userMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public Map<String, String> getInfo() {
        UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl loginUser = (UserDetailsImpl) token.getPrincipal();
        User user = loginUser.getUser();

        Map<String, String> map = new HashMap<>();
        map.put("error_message", "成功");
        map.put("id", user.getId().toString());
        map.put("username", user.getAvatar());
        return map;

    }

    @Override
    public Map<String, String> getToken(String username, String password) {
        Map<String, String> map = new HashMap<>();
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username, password);
        Authentication authentication;
        try {
            authentication = authenticationManager.authenticate(authenticationToken);
        } catch (Exception e) {
            map.put("error_message", "用户名不存在或密码错误");
            return map;
        }
        UserDetailsImpl loginUser = (UserDetailsImpl) authentication.getPrincipal();
        User user = loginUser.getUser();
        String jwt = JwtUtil.createJWT(user.getId().toString());


        map.put("error_message", "成功");
        map.put("token", jwt);

        return map;
    }

    @Override
    public Map<String, String> register(String username, String password) {
        Map<String, String> map = new HashMap<>();
        if (username == null) {
            map.put("error_message", "用户名不能为空");
            return map;
        }
        if (password == null) {
            map.put("error_message", "密码不能为空");
            return map;
        }

        username = username.trim();
        if (username.length() == 0) {
            map.put("error_message", "用户名不能为空");
            return map;
        }

        if (password.length() == 0) {
            map.put("error_message", "密码不能为空");
            return map;
        }

        if (username.length() > 100) {
            map.put("error_message", "用户名长度不能大于100");
            return map;
        }

        if (password.length() > 100) {
            map.put("error_message", "密码长度不能大于100");
            return map;
        }


        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        List<User> users = userMapper.selectList(queryWrapper);
        if (!users.isEmpty()) {
            map.put("error_message", "用户名已存在");
            return map;
        }

        String encodedPassword = passwordEncoder.encode(password);
        String avatar = "https://cc-pic-1306321037.cos.ap-shanghai.myqcloud.com/avatar/202304161828131.png";
        User user = new User().setUsername(username).setPassword(encodedPassword).setAvatar(avatar);
        userMapper.insert(user);

        map.put("error_message", "成功");
        return map;
    }
}
