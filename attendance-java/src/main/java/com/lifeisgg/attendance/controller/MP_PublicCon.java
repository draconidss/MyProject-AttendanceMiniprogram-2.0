package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_PublicService;
import com.lifeisgg.attendance.service.UserService;
import com.lifeisgg.attendance.service.WxuserService;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_Profile
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/2  21:31
 * “Welcome,my master”
 */
/*小程序公共方法Con层*/
@RestController
@RequestMapping("MP/public")
public class MP_PublicCon {
    @Resource
    private MP_PublicService mP_PublicService;
    private  Wxuser wxuser;

    /*获取房间列表*/
    @RequestMapping("getRoomList")
    @ResponseBody
    public Map<Object, Object> getRoomList() {
        return mP_PublicService.getRoomList();
    }

    /*小程序登录状态检测*/
    @RequestMapping("login")
    @ResponseBody
    public Map<Object,Object> login(Wxuser wxuser,Boolean isLogin) {
        System.out.println(wxuser);
        System.out.println(isLogin);
       return mP_PublicService.login(wxuser,isLogin);
    }

    @PostMapping("/profile/insert")
    @ResponseBody
    public boolean insert(Wxuser wxuser, Boolean isLogin) {
        System.out.println(wxuser);
        System.out.println(isLogin);
       /* System.out.println("insert-------------");
        System.out.println(wxuser.toString());
        Map map = new HashMap();
        System.out.println( "返回为"+wxuserService.insert(wxuser));
        return true;*/
        return true;
    }

}
