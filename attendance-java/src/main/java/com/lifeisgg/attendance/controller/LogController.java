package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.service.LogService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Log)表控制层
 *
 * @author makejava
 * @since 2020-05-30 15:07:10
 */
@RestController
@RequestMapping("log")
public class LogController {
 /*   *//**
     * 服务对象
     *//*
    @Resource
    private LogService logService;

    *//**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     *//*
    @GetMapping("selectOne")
    public Log selectOne(Integer id) {
        return this.logService.queryById(id);
    }*/

}