package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.util.Date;

/**
 * @WebName: LogDuring
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/4  13:27
 * “Welcome,my master”
 */
@Data
public class LogDuring {
    /*计算哪一天，为空则全部*/
    private Date lDate;

    private Integer uid;
    /*计算总时长用*/
    private Long allDuration;

    private String openid;

    private String nickName;

    private String avatarUrl;

    private String realName;

    private Integer rid;

    private String rname;

    private String address;

    private Integer del;


}
