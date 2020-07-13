package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (User)实体类
 *
 * @author makejava
 * @since 2020-05-30 15:40:01
 */
@Data
public class User implements Serializable {

    
    private Integer uid;

    private String phone;

    private String email;

    private String realName;

    private String password;

    private Integer level;

    private Wxuser wxuser;


}