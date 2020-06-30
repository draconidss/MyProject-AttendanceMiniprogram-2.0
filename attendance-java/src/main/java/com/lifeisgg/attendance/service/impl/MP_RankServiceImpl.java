package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.LogDuring;
import com.lifeisgg.attendance.service.MP_RankService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @WebName: MP_RankServiceImpl
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/13  17:29
 * “Welcome,my master”
 */

@Service("MP_RankService")
public class MP_RankServiceImpl implements MP_RankService {
    @Resource
    private LogDao logDao;

    /*获取本周或本月排行榜*/
    @Override
    public Map<Object,Object> getRank(Integer duration){
        Map map = new HashMap();
        String msg;
        int code;
        Log log = new Log();
        Date date = new Date();
        log.setLDate(date);

        /*为1查询本周活跃度*/
        if(duration == 1){
            map.put("durationList",logDao.getWeekDurationList(log));
        }else{
            map.put("durationList",logDao.getMonthDurationList(log));
        }

       /* map.put("durationList",logDao.getRoomDurationList(log));*/
        return map;
    }
}
