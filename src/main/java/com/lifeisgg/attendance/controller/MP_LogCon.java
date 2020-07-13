package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_LogService;
import com.lifeisgg.attendance.service.MP_ProfileService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: MP_LogCon
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  17:26
 * “Welcome,my master”
 */
/*小程序Log日志获取请求层*/
@RestController
@RequestMapping("MP/log")
public class MP_LogCon {
    @Resource
    private MP_LogService mP_LogService;

    @Resource
    private LogDao logDao;

    @RequestMapping("getLog")
    @ResponseBody
    public Map<Object, Object> getLog(Log log) {
        System.out.println("Log" + log);
        return mP_LogService.getLog(log);
    }

    @RequestMapping("getDuration")
    @ResponseBody
    public Map<Object, Object> getDuration(Log log) {
        System.out.println("Log" + log);
        return mP_LogService.getDuration(log);
    }

    @RequestMapping("getMyLab")
    @ResponseBody
    public Map<Object, Object> getMyLab(Log log) {
        System.out.println("Log" + log);
        return mP_LogService.getDuration(log);
    }


}


