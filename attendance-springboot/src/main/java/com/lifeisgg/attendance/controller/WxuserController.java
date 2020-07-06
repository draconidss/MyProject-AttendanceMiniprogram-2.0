package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.WxuserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Wxuser)表控制层
 *
 * @author makejava
 * @since 2020-05-30 22:16:53
 */
@RestController
@RequestMapping("wxuser")
public class WxuserController {
    /**
     * 服务对象
     */
    @Resource
    private WxuserService wxuserService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("selectOne")
    public Wxuser selectOne(String id) {
        return this.wxuserService.queryById(id);
    }

}