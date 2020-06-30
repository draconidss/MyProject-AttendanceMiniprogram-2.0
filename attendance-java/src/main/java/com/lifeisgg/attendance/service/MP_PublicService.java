package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.Wxuser;

import java.util.Map;

/**
 * @WebName: MP_ProfileService
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/2  21:40
 * “Welcome,my master”
 */
public interface MP_PublicService {

    Map<Object,Object> login(Wxuser wxuser,Boolean isLogin);

    Map<Object, Object> getRoomList();
}
