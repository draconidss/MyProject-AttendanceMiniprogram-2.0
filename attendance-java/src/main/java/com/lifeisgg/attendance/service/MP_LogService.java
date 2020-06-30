package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.Log;

import java.util.List;
import java.util.Map;

/**
 * @WebName: MP_LogService
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  17:29
 * “Welcome,my master”
 */
public interface MP_LogService {
    Map<Object, Object> getLog(Log log);

    Map<Object, Object> getDuration(Log log);

    Map<Object, Object> getMyLab(Log log);
}
