package com.lifeisgg.attendance.util;

import java.util.HashMap;
import java.util.Map;

/**
 * @WebName: returnMsg
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/2  22:11
 * “Welcome,my master”
 */
public class returnMsg {
    private static Map<Object,Object> map;

    //    调用此方法返回code和message
    public static Map<Object,Object> returnMsg(int code,String msg){
        map = new HashMap<>();
        map.put("code",code);
        map.put("msg",msg);
        return map;
    }
}
