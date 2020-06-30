package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.Room;
import com.lifeisgg.attendance.entity.RoomAdmin;
import com.lifeisgg.attendance.entity.User;

import java.util.Map;

/**
 * @WebName: MP_AdminServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/14  19:39
 * “Welcome,my master”
 */
public interface MP_AdminService {
    Map<Object, Object> checkRoomNameAndAdress(Room room);
    Map<Object, Object> insertRoom(Room room, User user);
    Map<Object, Object> getRoomByAdmin(User user);
    Map<Object, Object> getAllUser();
    Map<Object, Object>  getRoomDetail(Room room);
    Map<Object, Object>  addOrDeleteNotice(RoomAdmin roomAdmin,Integer method);
    Map<Object, Object>  changeRoomStatus(Integer uid,Integer rid,Integer del);
    Map<Object, Object>  addOrDelAdmin(Integer rid,Integer uid,Integer method);
    Map<Object, Object>  getUserDetail(Integer uid);

}
