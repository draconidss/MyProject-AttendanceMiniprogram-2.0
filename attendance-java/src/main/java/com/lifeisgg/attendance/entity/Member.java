package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * (Member)实体类
 *
 * @author makejava
 * @since 2020-06-10 21:19:45
 */
@Data
public class Member implements Serializable {
    
    private Integer rid;
    
    private Integer uid;
    
    private Integer status;
    
    private Integer isAdmin;

    private Date lDate;

    private Integer log;

    private Long duration;

    private Wxuser wxuser;

    private Room room;

    private User user;




}