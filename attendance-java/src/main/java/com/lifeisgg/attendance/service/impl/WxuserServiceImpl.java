package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.dao.WxuserDao;
import com.lifeisgg.attendance.service.WxuserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Wxuser)表服务实现类
 *
 * @author makejava
 * @since 2020-05-30 22:16:53
 */
@Service("wxuserService")
public class WxuserServiceImpl implements WxuserService {
    @Resource
    private WxuserDao wxuserDao;

    //    实体作为查找条件
    @Override
    public Wxuser selectByEntity(Wxuser wxuser) {
        return this.wxuserDao.getByEntity(wxuser);
    }


    /**
     * 通过ID查询单条数据
     *
     * @param openid 主键
     * @return 实例对象
     */
    @Override
    public Wxuser queryById(String openid) {
        return this.wxuserDao.queryById(openid);
    }

    /**
     * 查询多条数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    @Override
    public List<Wxuser> queryAllByLimit(int offset, int limit) {
        return this.wxuserDao.queryAllByLimit(offset, limit);
    }

    /**
     * 新增数据
     *
     * @param wxuser 实例对象
     * @return 实例对象
     */
    @Override
    public Wxuser insert(Wxuser wxuser) {
        this.wxuserDao.insert(wxuser);
        return wxuser;
    }

    /**
     * 修改数据
     *
     * @param wxuser 实例对象
     * @return 实例对象
     */
    @Override
    public Wxuser update(Wxuser wxuser) {
        this.wxuserDao.update(wxuser);
        return this.queryById(wxuser.getOpenid());
    }

    /**
     * 通过主键删除数据
     *
     * @param openid 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(String openid) {
        return this.wxuserDao.deleteById(openid) > 0;
    }
}