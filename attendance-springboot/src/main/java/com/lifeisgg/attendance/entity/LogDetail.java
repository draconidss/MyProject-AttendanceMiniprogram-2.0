package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.util.Date;

/**
 * @WebName: LogDetail
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/3  19:12
 * “Welcome,my master”
 */
@Data
public class LogDetail {
    private Integer lid;

    private Integer uid;

    private Integer rid;

    private Integer status;

    private Date lDate;

    private Long during;

    private User user;

    private Room room;

    private Wxuser wxuser;
}
