package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.util.Date;
import java.io.Serializable;

/**
 * (Wxuser)实体类
 *
 * @author makejava
 * @since 2020-05-30 22:16:53
 */
@Data
public class Wxuser implements Serializable {
    
    private Integer uid;
    
    private String openid;
    
    private String nickName;
    
    private String avatarUrl;
    
    private Date regDate;
    
    private Date lastLoginDate;

    private User user;



}