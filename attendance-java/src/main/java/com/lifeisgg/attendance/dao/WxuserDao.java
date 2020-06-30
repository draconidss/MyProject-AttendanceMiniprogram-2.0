package com.lifeisgg.attendance.dao;

import com.lifeisgg.attendance.entity.Wxuser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (Wxuser)表数据库访问层
 *
 * @author makejava
 * @since 2020-05-30 22:16:53
 */
@Mapper
@Repository
public interface WxuserDao {


   List<Wxuser> getAllUser();

    /**
     * 通过实体作为筛选条件查询
     *
     * @param wxuser 实例对象
     * @return 对象列表
     */
    Wxuser getByEntity(Wxuser wxuser);

    /**
     * 通过ID查询单条数据
     *
     * @param openid 主键
     * @return 实例对象
     */
    Wxuser queryById(String openid);

    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Wxuser> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);




    /**
     * 新增数据
     *
     * @param wxuser 实例对象
     * @return 影响行数
     */
    int insert(Wxuser wxuser);

    /**
     * 修改数据
     *
     * @param wxuser 实例对象
     * @return 影响行数
     */
    int update(Wxuser wxuser);

    /**
     * 通过主键删除数据
     *
     * @param openid 主键
     * @return 影响行数
     */
    int deleteById(String openid);

}