package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.util.Date;
import java.io.Serializable;

/**
 * (Roomadmin)实体类
 *
 * @author makejava
 * @since 2020-06-04 17:32:33
 */
@Data
public class RoomAdmin {

    private Integer aid;

    private Integer rid;
    
    private Integer uid;
    
    private String notice;
    
    private Date ndate;

    private Integer del;

    private User user;

    private Wxuser wxuser;




}