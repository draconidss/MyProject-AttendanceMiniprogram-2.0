package com.lifeisgg.attendance.dao;

import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.entity.LogDetail;
import com.lifeisgg.attendance.entity.LogDuring;
import com.lifeisgg.attendance.entity.User;
import javafx.beans.binding.ObjectExpression;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * (Log)表数据库访问层
 *
 * @author makejava
 * @since 2020-05-30 15:07:10
 */
@Mapper
@Repository
public interface LogDao {


    /*通过实体进行多表查询日志,返回为列表*/
    List<LogDetail> getLogListDetail(Log log);

    /*通过实体进行多表查询日志,返回为实体对象*/
    LogDetail getLogDetail(Log log);

    /*通过实体进行多表查询每个人总时长*/
    List<LogDuring> getDurationList(Log log);

   /* 获取去过的房间以及在这个房间的总时长*/
    List<Map> getRoomDurationList(Log log);

    /*获取本周活跃度*/
    List<LogDuring> getWeekDurationList(Log log);

    /*获取本月活跃度*/
    List<LogDuring> getMonthDurationList(Log log);


    /**
     * 通过ID查询单条数据
     *
     * @param lid 主键
     * @return 实例对象
     */
    Log queryById(Integer lid);

    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Log> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);


    /**
     * 通过实体作为筛选条件查询
     *
     * @param log 实例对象
     * @return 对象列表
     */
    List<Log> queryAll(Log log);

    /**
     * 新增数据
     *
     * @param log 实例对象
     * @return 影响行数
     */
    int insert(Log log);

    /**
     * 修改数据
     *
     * @param log 实例对象
     * @return 影响行数
     */
    int update(Log log);

    /**
     * 通过主键删除数据
     *
     * @param lid 主键
     * @return 影响行数
     */
    int deleteById(Integer lid);

}