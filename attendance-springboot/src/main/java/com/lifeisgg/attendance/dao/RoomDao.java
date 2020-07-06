package com.lifeisgg.attendance.dao;

import com.lifeisgg.attendance.entity.Room;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (Room)表数据库访问层
 *
 * @author makejava
 * @since 2020-05-30 15:03:58
 */
@Mapper
@Repository
public interface RoomDao {

    List<Room> getRoomList();

    Room getRoom(Room room);


    /**
     * 通过ID查询单条数据
     *
     * @param rid 主键
     * @return 实例对象
     */

    Room queryById(Integer rid);

    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Room> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);


    /**
     * 通过实体作为筛选条件查询
     *
     * @param room 实例对象
     * @return 对象列表
     */
    List<Room> queryAll(Room room);

    /**
     * 新增数据
     *
     * @param room 实例对象
     * @return 影响行数
     */
    int insert(Room room);

    /**
     * 修改数据
     *
     * @param room 实例对象
     * @return 影响行数
     */
    int update(Room room);

    /**
     * 通过主键删除数据
     *
     * @param rid 主键
     * @return 影响行数
     */
    int deleteById(Integer rid);

}