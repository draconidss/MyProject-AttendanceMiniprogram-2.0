package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;

import java.util.Map;

/**
 * @WebName: MP_ProfileService
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  12:37
 * “Welcome,my master”
 */
public interface MP_ProfileService {
    Map<Object,Object> realProfile(Wxuser wxuser, User user);
    Map<Object,Object> checkExist(User user);
    Map<Object,Object> beAdmin(User user);

}
