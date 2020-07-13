package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Room)实体类
 *
 * @author makejava
 * @since 2020-05-30 15:03:58
 */
@Data
public class Room implements Serializable {

    private Integer rid;
    
    private String rname;
    
    private String address;
    
    private Integer del;



}