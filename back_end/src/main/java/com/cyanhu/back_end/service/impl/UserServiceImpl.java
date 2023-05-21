package com.cyanhu.back_end.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.cyanhu.back_end.entity.User;
import com.cyanhu.back_end.entity.UserRole;
import com.cyanhu.back_end.entity.vo.UserVO;
import com.cyanhu.back_end.mapper.UserMapper;
import com.cyanhu.back_end.mapper.UserRoleMapper;
import com.cyanhu.back_end.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cyanhu.back_end.utils.JwtUtil;
import com.cyanhu.back_end.utils.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.ArrayList;
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

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public Map<String, Object> getInfo() {
        UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
        UserDetailsImpl loginUser = (UserDetailsImpl) token.getPrincipal();
        User user = loginUser.getUser();

        Map<String, Object> map = new HashMap<>();
        map.put("error_message", "成功");
        map.put("id", user.getId().toString());
        map.put("username", user.getAvatar());
        map.put("roleList", loginUser.getAuthorities().stream().map(GrantedAuthority::getAuthority).toList());

        return map;

    }

    @Override
    public Map<String, Object> getToken(String username, String password) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
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
        data.put("token", jwt);
        UserVO userVO = new UserVO().setUserId(user.getId()).setUsername(username).setAvatar(user.getAvatar()).setRoleList(loginUser.getAuthorities().stream().map(GrantedAuthority::getAuthority).toList());
        data.put("user", userVO);
        map.put("data", data);
        return map;
    }

    @Override
    public Map<String, Object> register(String username, String password, String confirmedPassword) {
        Map<String, Object> map = new HashMap<>();

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

        if (!password.equals(confirmedPassword)) {
            map.put("error_message", "两者密码不一致");
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
        userRoleMapper.insert(new UserRole().setUserId(user.getId()).setRoleName("ROLE_USER"));
        map.put("error_message", "成功");
        return map;
    }
}
