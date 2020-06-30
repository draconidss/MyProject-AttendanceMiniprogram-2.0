package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.Member;

import java.util.Map;

/**
 * @WebName: MP_HomeService
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/4  15:17
 * “Welcome,my master”
 */
public interface MP_HomeService {

    Map<Object, Object> getRoomList();

    Map<Object, Object> getStatus(Member member);

    Map<Object, Object> entryRoom(Log log);

    Map<Object, Object> leaveRoom(Log log);
}
