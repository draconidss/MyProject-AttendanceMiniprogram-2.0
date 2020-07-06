package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Member;
import com.lifeisgg.attendance.entity.Room;
import com.lifeisgg.attendance.entity.RoomAdmin;
import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.service.MP_AdminService;
import com.lifeisgg.attendance.service.MP_HomeService;
import com.lifeisgg.attendance.service.MP_ProfileService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @WebName: MP_AdminCon
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/14  19:36
 * “Welcome,my master”
 */
@RestController
@RequestMapping("MP/admin")
public class MP_AdminCon {
    @Resource
    private MP_HomeService mP_HomeService;
    @Resource
    private MP_AdminService mP_AdminService;
    @Resource
    private MP_ProfileService mP_ProfileService;


    @RequestMapping("getUserDetail")
    @ResponseBody
    public Map<Object, Object> getUserDetail(Integer uid) {
        return mP_AdminService.getUserDetail(uid);
    }

    @RequestMapping("addOrDelAdmin")
    @ResponseBody
    public Map<Object, Object> addOrDelAdmin(Integer rid,Integer uid,Integer method) {
        return mP_AdminService.addOrDelAdmin(rid,uid,method);
    }

    @RequestMapping("changeRoomStatus")
    @ResponseBody
    public Map<Object, Object> changeRoomStatus(Integer uid,Integer rid,Integer del) {
        return mP_AdminService.changeRoomStatus(uid,rid,del);
    }



    /*添加或删除公告*/
    @RequestMapping("addOrDeleteNotice")
    @ResponseBody
    public Map<Object, Object> addOrDeleteNotice(RoomAdmin roomAdmin,Integer method) {
        System.out.println("roomAdmin" + roomAdmin);
        return mP_AdminService.addOrDeleteNotice(roomAdmin,method);
    }

    /*获取所有用户*/
    @RequestMapping("getRoomDetail")
    @ResponseBody
    public Map<Object, Object> getRoomDetail(Room room) {
        return mP_AdminService.getRoomDetail(room);
    }

    /*获取所有用户*/
    @RequestMapping("getAllUser")
    @ResponseBody
    public Map<Object, Object> getAllUser() {
        return mP_AdminService.getAllUser();
    }

    /*获取管理员所管理的房间*/
    @RequestMapping("getRoomByAdmin")
    @ResponseBody
    public Map<Object, Object> getRoomByAdmin(User user) {
        System.out.println("user" + user);
        return mP_AdminService.getRoomByAdmin(user);
    }

        /*t添加教室前检查是否重复*/
    @RequestMapping("checkRoom")
    @ResponseBody
    public Map<Object, Object> checkRoom(Room room) {
        System.out.println("Room" + room);
        return mP_AdminService.checkRoomNameAndAdress(room);
    }

    @RequestMapping("insertRoom")
    @ResponseBody
    public Map<Object, Object> insertRoom(Room room, User user) {
        System.out.println("Room" + room);
        System.out.println("user" + user);
        return mP_AdminService.insertRoom(room,user);
    }
}
