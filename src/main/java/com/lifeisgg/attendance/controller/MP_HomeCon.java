package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.Member;
import com.lifeisgg.attendance.service.MP_HomeService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.Map;

/**
 * @WebName: MP_HomeCon
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/4  15:16
 * “Welcome,my master”
 */
/*小程序Home界面出入状态获取请求层*/
@RestController
@RequestMapping("MP/home")
public class MP_HomeCon {
    @Resource
    private MP_HomeService mP_HomeService;

    /*获取房间列表*/
    @RequestMapping("getRoomList")
    @ResponseBody
    public Map<Object, Object> getRoomList() {
        return mP_HomeService.getRoomList();
    }

    /*获取出入状态，在教室则返回教室日志管理员公告等信息，没有则返回null，
    根据最新日志的status是否为0来判断*/
    @RequestMapping("getStatus")
    @ResponseBody
    public Map<Object, Object> getStatus(Member member) {
        System.out.println("member" + member);
        return mP_HomeService.getStatus(member);
    }

    /*进入房间后，先判断是否已经不在教室，在的话就提醒先打卡离开之前的教室，
    如果不在教室，就往日志表插入一条日志并返回此教室日志管理员公告等信息**/
    @RequestMapping("entryRoom")
    @ResponseBody
    public Map<Object, Object> entryRoom(Log log) {
        System.out.println("log" + log);
        return mP_HomeService.entryRoom(log);
    }

    /*先判断是否在房间，如果在就退出*/
    @RequestMapping("leaveRoom")
    @ResponseBody
    public Map<Object, Object> leaveRoom(Log log) {
        System.out.println("log" + log);
        return mP_HomeService.leaveRoom(log);
    }

    @RequestMapping("test")
    @ResponseBody
    public boolean test() throws InterruptedException {
        Date date = new Date();
        Thread.currentThread().sleep(6000);
        Date date2 = new Date();
        long start = date.getTime();
        long end = date2.getTime();
        long result = date.getTime() -date2.getTime();
        System.out.println("差：" + result);
        return true;
    }

}
