package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.User;
import com.lifeisgg.attendance.entity.Wxuser;

import java.util.List;

/**
 * (User)表服务接口
 *
 * @author makejava
 * @since 2020-05-30 15:40:01
 */
public interface UserService {

    //    实体作为查找条件
    User selectByEntity(User user);

    /**
     * 通过ID查询单条数据
     *
     * @param uid 主键
     * @return 实例对象
     */
    User queryById(Integer uid);

    /**
     * 查询多条数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<User> queryAllByLimit(int offset, int limit);

    /**
     * 新增数据
     *
     * @param user 实例对象
     * @return 实例对象
     */
    User insert(User user);

    /**
     * 修改数据
     *
     * @param user 实例对象
     * @return 实例对象
     */
    User update(User user);

    /**
     * 通过主键删除数据
     *
     * @param uid 主键
     * @return 是否成功
     */
    boolean deleteById(Integer uid);

}