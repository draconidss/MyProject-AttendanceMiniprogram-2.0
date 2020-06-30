package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.dao.MemberDao;
import com.lifeisgg.attendance.dao.RoomAdminDao;
import com.lifeisgg.attendance.dao.RoomDao;
import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.LogDetail;
import com.lifeisgg.attendance.entity.Member;
import com.lifeisgg.attendance.entity.RoomAdmin;
import com.lifeisgg.attendance.service.MP_HomeService;
import com.lifeisgg.attendance.util.returnMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_HomeServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/4  15:17
 * “Welcome,my master”
 */
@Service("MP_HomeService")
public class MP_HomeServiceImpl implements MP_HomeService {
    @Resource
    private LogDao logDao;
    @Resource
    private RoomAdminDao roomAdminDao;
    @Resource
    private MemberDao memberDao;
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

    /*获取出入状态，在教室则返回教室日志等信息，没有则返回null，
    根据最新日志的status是否为0来判断*/
    @Override
    public Map<Object, Object> getStatus(Member member) {
        Map map = new HashMap();
        String msg;
        int code;
        member.setStatus(1);
        Member member_select = new Member();
        member_select = memberDao.getMember(member);
        if(member_select == null){
            code = 200;
            msg = "此时不在教室";
            map.put("statusInfo", member_select);
        }else{
            code = 201;
            msg = "此时在教室" + member_select.getRoom().getRname();
            /*返回状态信息*/
            map.put("statusInfo", member_select);
            /*获取教室日志*/
            Log log = new Log();
            log.setRid(member_select.getRid());
            map.put("roomLogInfo", logDao.getLogListDetail(log));
            /*获取教室公告信息*/
            RoomAdmin roomAdmin = new RoomAdmin();
            roomAdmin.setRid(member_select.getRid());
            map.put("adminInfo", roomAdminDao.getAdminList(roomAdmin));
            /*返回教室成员信息*/
            Member member_select2 = new Member();
            member_select2.setRid(member_select.getRid());
            map.put("memberInfo", memberDao.getMemberList(member_select2));
        }
        map.putAll(returnMsg.returnMsg(code, msg));
 /*       String msg;
        int code;
        *//*获取最新一条日志*//*
        log.setLimit(1);

        if (lastLogDetail.getStatus() == 0) {
            code = 200;
            msg = "此时不在教室";
            map.putAll(returnMsg.returnMsg(code, msg));
        } else if (lastLogDetail.getStatus() == 1) {
            code = 201;
            msg = "此时在教室" + lastLogDetail.getRoom().getRname();
            RoomAdmin roomAdmin = new RoomAdmin();
            roomAdmin.setRid(lastLogDetail.getRid());
            log.setUid(null);
            log.setLimit(null);
            log.setRid(lastLogDetail.getRid());
            map.putAll(returnMsg.returnMsg(code, msg));
            map.put("roomLogInfo", logDao.getLogListDetail(log));
            map.put("adminInfo", roomAdminDao.getAdminList(roomAdmin));
        }*/
        return map;
    }

    @Override
    public Map<Object, Object> entryRoom(Log log) {
        Map map = new HashMap();
        Integer uid = log.getUid();
        Integer rid = log.getRid();
        /*查找此人是否在教室*/
        Member member = new Member();
        member.setStatus(1);
        member.setUid(uid);
        member = memberDao.getMember(member);
        /*说明此时此人在某间教室*/
        if(member != null){
            map.putAll(returnMsg.returnMsg(202, "请先打卡退出教室"));
        }else{
            Date nowDate = new Date();
            log.setStatus(1);
            log.setLDate(nowDate);
            logDao.insert(log);
            member = new Member();
            member.setRid(rid);
            member.setUid(uid);
            /*如果第一次进入这间教室*/
            if(memberDao.getMember(member) == null){
                System.out.println("第一次进入");
                System.out.println(member);
                member.setStatus(1);
                member.setIsAdmin(0);
                member.setLog(1);
                long duration = (int)0;
                member.setDuration(duration);
                memberDao.insert(member);
            }else{
                System.out.println("不是第一次进入");
                System.out.println(member);
                member = memberDao.getMember(member);
                member.setStatus(1);
                member.setLog(member.getLog()+1);
                memberDao.update(member);
            }
            map.putAll(returnMsg.returnMsg(201, "进入教室成功"));
        }
        return map;
    }

    @Override
    public Map<Object, Object> leaveRoom(Log log) {
        Map map = new HashMap();
        Date outRoomDate = new Date();
        Log log_Copy = new Log();
        /*查找此人最新的一条日志获取其时间*/
        log_Copy.setUid(log.getUid());
        log_Copy.setLimit(1);
        LogDetail lastLogDetail = logDao.getLogDetail(log_Copy);
        /*如果status = 0说明此时没有在教室，则必须要先打卡进入教室才能出教室*/
        if (lastLogDetail.getStatus() == 0) {
            map.putAll(returnMsg.returnMsg(202, "请先打卡进入教室"));
        } else if (lastLogDetail.getStatus() == 1) {
            /*获取上次进入房间的时间*/
            Date inRoomDate = lastLogDetail.getLDate();
            Long duration = outRoomDate.getTime()-inRoomDate.getTime();
            System.out.println("时间差"+duration+"毫秒");
            log.setLDate(outRoomDate);
            log.setStatus(0);
            log.setDuring(duration);
            if( logDao.insert(log) == 1){
                System.out.println("插入后的log"+log);
                /*更新member表*/
                Member member = new Member();
                member.setRid(log.getRid());
                member.setUid(log.getUid());
                member = memberDao.getMember(member);
                member.setStatus(0);
                member.setLog(member.getLog()+1);
                member.setDuration(member.getDuration()+duration);
                memberDao.update(member);
                /*返回离开房间的日志*/
                log_Copy = new Log();
                log_Copy.setLid(log.getLid());
                log_Copy.setLimit(1);
                map.put("outLog",logDao.getLogDetail(log_Copy));
            }
            map.putAll(returnMsg.returnMsg(200, "退出教室成功"));
        }
        return map;
    }

}
