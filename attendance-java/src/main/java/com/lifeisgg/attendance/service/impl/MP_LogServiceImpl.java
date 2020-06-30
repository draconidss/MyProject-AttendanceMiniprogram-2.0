package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.LogDetail;
import com.lifeisgg.attendance.entity.LogDuring;
import com.lifeisgg.attendance.service.MP_LogService;
import com.lifeisgg.attendance.util.returnMsg;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @WebName: MP_LogServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  17:28
 * “Welcome,my master”
 */
@Service("MP_LogService")
public class MP_LogServiceImpl implements MP_LogService {
    @Resource
    private LogDao logDao;

    /*通过uid和rid来查询日志*/
    @Override
    public Map<Object, Object> getLog(Log log){
        Map map = new HashMap();
        String msg;
        int code;
        List<LogDetail> logListDetail = logDao.getLogListDetail(log);
        map.put("logList",logListDetail);
        if(log.getRid() == null){
            msg = "查找全部日志成功，共"+logListDetail.size()+"条记录";
        }else{
            msg = "查找在"+ logListDetail.get(0).getRoom().getRname()+"全部日志成功，共"+logListDetail.size()+"条记录";
        }
        map.putAll(returnMsg.returnMsg(200, msg));
        return map;
    }

    /*根据uid或rid是否为空返回不同的总during*/
    @Override
    public Map<Object, Object> getDuration(Log log){
        Map map = new HashMap();
        String msg;
        int code;
        List<LogDuring> durationList = logDao.getDurationList(log);
        map.put("durationList",durationList);
        Integer uid = log.getUid();
        Integer rid = log.getRid();
        code = 200;

        if(durationList != null){
            if(uid == null&&rid == null){
                msg = "请求成功查询获取每个人的总时长，共"+durationList.size()+"条记录";
                map.put("roomDurationList",logDao.getRoomDurationList(log));
            }else if(uid == null&&rid != null){
                msg = "请求成功查询获取获取"+durationList.get(0).getRname()+"教室每个人的总时长，共"+durationList.size()+"条记录";
            }else if(uid != null&&rid == null) {
                msg = "请求用户"+durationList.get(0).getNickName()+"总时长，共"+durationList.size()+"条记录";
                map.put("roomDurationList",logDao.getRoomDurationList(log));
            }else{
                msg = "请求用户"+durationList.get(0).getNickName()+"总时长在"+durationList.get(0).getRname()+"，共"+durationList.size()+"条记录";
            }

        }else{
            msg = "请求失败";
            code = 400;
        }
        map.putAll(returnMsg.returnMsg(code, msg));
        return map;
    }

    /*获取我的教室*/
    @Override
    public Map<Object, Object> getMyLab(Log log){
        Map map = new HashMap();

        return map;
    }
}
