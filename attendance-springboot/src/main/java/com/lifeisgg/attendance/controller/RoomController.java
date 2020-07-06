package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.entity.Room;
import com.lifeisgg.attendance.service.RoomService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Room)表控制层
 *
 * @author makejava
 * @since 2020-05-30 15:03:58
 */
@RestController
@RequestMapping("room")
public class RoomController {
    /**
     * 服务对象
     */
    @Resource
    private RoomService roomService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("selectOne")
    public Room selectOne(Integer id) {
        return this.roomService.queryById(id);
    }

}