package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_ProfileService;
import com.lifeisgg.attendance.service.MP_PublicService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @WebName: MP_ProfileCon
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  12:35
 * “Welcome,my master”
 */
/*小程序profile界面请求层*/
@RestController
@RequestMapping("MP/profile")
public class MP_ProfileCon {
    @Resource
    private MP_ProfileService mP_ProfileService;

    /*检查手机或邮箱是否已经注册*/
    @RequestMapping("checkExist")
    @ResponseBody
    public Map<Object,Object> checkExist(User user) {
        System.out.println("user"+user);
        return mP_ProfileService.checkExist(user);
    }

    /*实名注册*/
    @RequestMapping("realProfile")
    @ResponseBody
    public Map<Object,Object> realProfile(Wxuser wxuser, User user) {
        System.out.println("wxuser"+wxuser);
        System.out.println("user"+user);
        return mP_ProfileService.realProfile(wxuser,user);
    }

    /*测试用，成为超级管理员*/
    @RequestMapping("test/beAdmin")
    @ResponseBody
    public Map<Object,Object> beAdmin(User user) {
        System.out.println("user"+user);
        return mP_ProfileService.beAdmin(user);
    }
}
