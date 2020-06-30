package com.lifeisgg.attendance.entity;

import lombok.Data;

import java.util.Date;
import java.io.Serializable;

/**
 * (Log)实体类
 *
 * @author makejava
 * @since 2020-05-30 15:07:10
 */
@Data
public class Log implements Serializable {
    
    private Integer lid;
    
    private Integer uid;
    
    private Integer rid;
    
    private Integer status;
    
    private Date lDate;
    
    private Long during;

    /*用于数据路查询limit*/
    private Integer limit;



}