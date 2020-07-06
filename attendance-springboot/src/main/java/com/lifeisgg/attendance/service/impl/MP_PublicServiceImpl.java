package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.RoomDao;
import com.lifeisgg.attendance.dao.UserDao;
import com.lifeisgg.attendance.dao.WxuserDao;
import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_PublicService;
import com.lifeisgg.attendance.util.returnMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_PublicServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/2  21:39
 * “Welcome,my master”
 */
//用于处理小程序profile界面的请求
@Service("MP_PublicService")
public class MP_PublicServiceImpl implements MP_PublicService {
    @Resource
    private WxuserDao wxuserDao;
    @Resource
    private UserDao userDao;
    @Resource
    private RoomDao roomDao;

    /*获取房间列表*/
    @Override
    public Map<Object, Object> getRoomList(){
        Map map = new HashMap();
        map.put("roomList",roomDao.getRoomList());
        map.putAll(returnMsg.returnMsg(200, "获取教室成功"));
        return map;
    }

    @Override
    public Map<Object, Object> login(Wxuser wxuser, Boolean isLogin) {
        Map map = new HashMap();
        String msg;
        int code;
        Wxuser wxuserCopy = new Wxuser();
        User userCopy = new User();

        String openid = wxuser.getOpenid();
        wxuserCopy.setOpenid(openid);
        /*根据openid查找不存在此记录，就插入*/
        if (wxuserDao.getByEntity(wxuserCopy) == null) {
            System.out.println("不存在,需要插入记录在微信用户表");
            if (wxuserDao.insert(wxuser) == 1) {
                map.putAll(returnMsg.returnMsg(200, "新用户插入成功"));
            }
            map.put("userInfo", null);
        } else {
            /* openid存在此记录就更新*/
            /*如果是点击登录就要更新lastLoginDate为现在*/
            System.out.println("更新wxuser");
            wxuser.setRegDate(null);
            if (isLogin == false) {
                wxuser.setLastLoginDate(null);
            }
            wxuserDao.update(wxuser);
            /*如果uid为空说明没有实名认证*/
            wxuserCopy = wxuserDao.getByEntity(wxuserCopy);
            if (wxuserCopy.getUid() == null) {
                map.putAll(returnMsg.returnMsg(201, "uid为空，未实名"));
                map.put("userInfo", null);
            } else {
                map.putAll(returnMsg.returnMsg(202, "uid不为空，已实名"));
                userCopy.setUid(wxuserCopy.getUid());
                map.put("userInfo", userDao.getUser(userCopy));
            }
        }
        map.put("wxuserInfo", wxuserDao.getByEntity(wxuserCopy));
        return map;
    }
}
