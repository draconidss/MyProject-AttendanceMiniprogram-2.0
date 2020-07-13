package com.lifeisgg.attendance.dao;

import com.lifeisgg.attendance.entity.RoomAdmin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (Roomadmin)表数据库访问层
 *
 * @author makejava
 * @since 2020-06-04 21:19:03
 */
@Mapper
@Repository
public interface RoomAdminDao {

    List<RoomAdmin> getAdminList(RoomAdmin roomAdmin);

    int insert(RoomAdmin roomAdmin);

    int update(RoomAdmin roomAdmin);

}