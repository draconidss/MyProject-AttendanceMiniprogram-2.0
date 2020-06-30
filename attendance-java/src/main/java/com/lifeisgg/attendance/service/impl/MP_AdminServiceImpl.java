package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.*;
import com.lifeisgg.attendance.entity.*;
import com.lifeisgg.attendance.service.MP_AdminService;
import com.lifeisgg.attendance.util.returnMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_AdminServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/14  19:39
 * “Welcome,my master”
 */
@Service("AdminService")
public class MP_AdminServiceImpl implements MP_AdminService {
    @Resource
    private LogDao logDao;
    @Resource
    private UserDao userDao;
    @Resource
    private RoomAdminDao roomAdminDao;
    @Resource
    private MemberDao memberDao;
    @Resource
    private RoomDao roomDao;
    @Resource
    private WxuserDao wxuserDao;

    @Override
    public Map<Object, Object> getUserDetail(Integer uid) {
        Map map = new HashMap();
        User user = new User();
        Log log = new Log();
        Member member = new Member();
        user.setUid(uid);
        log.setUid(uid);
        member.setUid(uid);
        member.setIsAdmin(1);

        map.put("userDetail",userDao.getUser(user));
        map.put("userLog",logDao.getLogListDetail(log));
        map.put("userRoom",logDao.getRoomDurationList(log));
        map.put("userAdminRoom",memberDao.getMemberList(member));
        map.put("userAllDuration",logDao.getDurationList(log));
        return map;
    }

    @Override
    public Map<Object, Object> addOrDelAdmin(Integer rid,Integer uid,Integer method) {
        Map map = new HashMap();
        /*uid1操作员的成员id，uid2为被操作员的id*/
        Member member = new Member();
        member.setRid(rid);
        member.setUid(uid);
        /*增加管理员*/
        if(method == 1){
            /*不为空则更新*/
            if(memberDao.getMember(member)!=null){
                member.setIsAdmin(1);
                memberDao.update(member);
            }else{
                member.setStatus(0);
                member.setIsAdmin(1);
                member.setLog(0);
                member.setDuration((long) 0);
                memberDao.insert(member);
            }
            map.putAll(returnMsg.returnMsg(200, "添加管理员成功"));
        }
        /*删除成员*/
        else if(method == 0){
            member.setIsAdmin(0);
            memberDao.update(member);
            map.putAll(returnMsg.returnMsg(201, "删除管理员成功"));
        }
        return map;
    }

    @Override
    public Map<Object, Object> changeRoomStatus(Integer uid,Integer rid,Integer del) {
        Map map = new HashMap();
        /*开放实验室*/
        Room room = new Room();
        room.setDel(del);
        room.setRid(rid);
        if(del == 1){
            roomDao.update(room);
            map.putAll(returnMsg.returnMsg(200, "开放实验室成功"));
        }
        /*关闭实验室*/
        else if(del == 0){
            Member member = new Member();
            member.setStatus(1);
            member.setRid(rid);
            System.out.println(memberDao.getMemberList(member));
            if(memberDao.getMemberList(member).size() > 0 ){
                map.putAll(returnMsg.returnMsg(201, "还有人实验室"));
            }else{
                roomDao.update(room);
                map.putAll(returnMsg.returnMsg(202, "关闭实验室成功"));
            }
        }
        return map;
    }

    @Override
    public Map<Object, Object> addOrDeleteNotice(RoomAdmin roomAdmin,Integer method) {
        Map map = new HashMap();
        Member member = new Member();
        member.setRid(roomAdmin.getRid());
        member.setUid(roomAdmin.getUid());
        member = memberDao.getMember(member);
        User user = new User();
        user.setUid(roomAdmin.getUid());
        user = userDao.getUser(user);
        if(member !=null || user.getLevel() == 1){
            if(member.getIsAdmin() == 1 ){

                /*就添加*/
                if(method == 1){
                    roomAdmin.setAid(null);
                    roomAdminDao.insert(roomAdmin);
                    map.putAll(returnMsg.returnMsg(200, "插入成功"));
                }else if(method == 0){
                    roomAdmin.setDel(0);
                    roomAdminDao.update(roomAdmin);
                    map.putAll(returnMsg.returnMsg(201, "删除成功"));
                }


            }else{
                map.putAll(returnMsg.returnMsg(400, "权限不够"));
            }
        }

        return map;
    }
    /*查找房间的日志等详细信息*/
    @Override
    public Map<Object, Object> getRoomDetail(Room room) {
        Map map = new HashMap();
        /*返回房间日志信息*/
        Log log = new Log();
        log.setRid(room.getRid());
        map.put("roomLogInfo", logDao.getLogListDetail(log));
        /*获取教室公告信息*/
        RoomAdmin roomAdmin = new RoomAdmin();
        roomAdmin.setRid(room.getRid());
        map.put("adminInfo", roomAdminDao.getAdminList(roomAdmin));
        /*返回教室成员信息*/
        Member member = new Member();
        member.setRid(room.getRid());
        map.put("memberInfo", memberDao.getMemberList(member));
        return map;
    }

    /*查找我管理的房间*/
    @Override
    public Map<Object, Object> getAllUser() {
        Map map = new HashMap();
        map.put("userList",wxuserDao.getAllUser());
        return map;
    }

    @Override
    public Map<Object, Object> getRoomByAdmin(User user) {
        Map map = new HashMap();
        Member member = new Member();
        member.setUid(user.getUid());
        member.setIsAdmin(1);
        map.put("myAdminRoomList",memberDao.getMemberList(member));
        map.putAll(returnMsg.returnMsg(200, "获取我管理的房间"));
        return map;
    }

    /*增加实验室*/
    @Override
    public Map<Object, Object> insertRoom(Room room, User user) {
        Map map = new HashMap();
        Map map2 = new HashMap();
        map2 = this.checkRoomNameAndAdress(room);
//        如果字段不存在
        if(map2.get("room_rname")!=null || map2.get("room_address")!=null){
            map.putAll(returnMsg.returnMsg(400, "名称或地址已存在"));
        }else{
            Member member = new Member();
            member.setUid(user.getUid());
            member.setRid(room.getRid());
            member = memberDao.getMember(member);
            User user2 = new User();
            user2  = userDao.getUser(user);
            if(member.getIsAdmin() == 0&& user.getLevel() == 2){
                map.putAll(returnMsg.returnMsg(401, "不是这间管理员或超管"));
            }else{
                roomDao.insert(room);
                map.putAll(returnMsg.returnMsg(200, "插入成功"));
            }

        }

        return map;
    }

    /*检查名称和地址是否重复*/
    @Override
    public Map<Object, Object> checkRoomNameAndAdress(Room room){
        Map map = new HashMap();
        Room room_rname = new Room();
        Room room_address = new Room();
        if(room.getRname() == null){
            map.put("room_rname",null);
        }else{
            room_rname.setRname(room.getRname());
            map.put("room_rname",roomDao.getRoom(room_rname));
        }

        if(room.getAddress() == null){
            map.put("room_address",null);
        }else{
            room_address.setAddress(room.getAddress());
            map.put("room_address",roomDao.getRoom(room_address));
        }

        map.putAll(returnMsg.returnMsg(200, "检查成功"));
        return map;
    }
}
