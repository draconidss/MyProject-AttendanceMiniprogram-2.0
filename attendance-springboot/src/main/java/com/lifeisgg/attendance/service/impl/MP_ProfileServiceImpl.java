package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.UserDao;
import com.lifeisgg.attendance.dao.WxuserDao;
import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_ProfileService;
import com.lifeisgg.attendance.util.returnMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_ProfileServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  12:37
 * “Welcome,my master”
 */
@Service("MP_ProfileService")
public class MP_ProfileServiceImpl implements MP_ProfileService {
    @Resource
    private WxuserDao wxuserDao;
    @Resource
    private UserDao userDao;


    /*检查手机或邮箱是否已经存在*/
    @Override
    public Map<Object, Object> checkExist(User user) {
        Map map = new HashMap();
        String msg;
        int code;
        String phone = user.getPhone();
        String email = user.getEmail();
        /*为空说明手机号没有注册,就返回电话号码*/
        User userCopy = new User();
        userCopy.setPhone(phone);
        userCopy = userDao.getUser(userCopy);
        if (userCopy == null) {
            map.put("phone", phone);
            map.put("msgP", "恭喜，电话号码不存在可以使用");
        } else {
            map.put("phone", null);
            map.put("msgP", "警告，电话号码已存在");
        }

//        暂停邮箱检测
        /*为空说明邮箱没有注册,就返回null*/
/*        userCopy = new User();
        userCopy.setEmail(email);
        userCopy = userDao.getByEntity(userCopy);
        if (userCopy == null) {
            map.put("email", email);
            map.put("msgE", "恭喜，邮箱不存在可以使用");
        } else {
            map.put("email", null);
            map.put("msgE", "警告，邮箱已存在");
        }*/
        return map;
    }

    @Override
    public Map<Object, Object> realProfile(Wxuser wxuser, User user) {
        Map map = new HashMap();
        String msg;
        int code;
        Map mapCheck = new HashMap();
        mapCheck = this.checkExist(user);
        /*实名前再次检查是否已存在*/
        if (mapCheck.get("phone") == null ) {
            return returnMsg.returnMsg(400, "电话号码已存在");
        } else {
            userDao.insert(user);
            wxuser.setUid(user.getUid());
            System.out.println("更新前的wxuser" + wxuser);
            wxuserDao.update(wxuser);
            System.out.println("更新后的wxuser" + wxuser);
            map.put("wxuserInfo", wxuser);
            map.put("userInfo", userDao.getUser(user));
            map.putAll(returnMsg.returnMsg(200, "实名注册成功"));
        }
        return map;
    }

    /*测试用成为超级管理员*/
    @Override
    public Map<Object, Object> beAdmin(User user) {
        Map map = new HashMap();
        String msg;
        int code;
        user.setLevel(1);
        userDao.update(user);
        map.putAll(returnMsg.returnMsg(200, "成为超级管理员成功"));
        return map;
    }


}
