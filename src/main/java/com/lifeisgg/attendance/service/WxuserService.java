package com.lifeisgg.attendance.service;

import com.lifeisgg.attendance.entity.Wxuser;
import java.util.List;

/**
 * (Wxuser)表服务接口
 *
 * @author makejava
 * @since 2020-05-30 22:16:53
 */
public interface WxuserService {

//    实体作为查找条件
   Wxuser selectByEntity(Wxuser wxuser);

    /**
     * 通过ID查询单条数据
     *
     * @param openid 主键
     * @return 实例对象
     */
    Wxuser queryById(String openid);

    /**
     * 查询多条数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Wxuser> queryAllByLimit(int offset, int limit);

    /**
     * 新增数据
     *
     * @param wxuser 实例对象
     * @return 实例对象
     */
    Wxuser insert(Wxuser wxuser);

    /**
     * 修改数据
     *
     * @param wxuser 实例对象
     * @return 实例对象
     */
    Wxuser update(Wxuser wxuser);

    /**
     * 通过主键删除数据
     *
     * @param openid 主键
     * @return 是否成功
     */
    boolean deleteById(String openid);

}