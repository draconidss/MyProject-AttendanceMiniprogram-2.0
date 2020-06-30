package com.lifeisgg.attendance.service.impl;

import com.lifeisgg.attendance.entity.Log;
import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.service.LogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Log)表服务实现类
 *
 * @author makejava
 * @since 2020-05-30 15:07:10
 */
@Service("logService")
public class LogServiceImpl implements LogService {
    @Resource
    private LogDao logDao;

    /**
     * 通过ID查询单条数据
     *
     * @param lid 主键
     * @return 实例对象
     */
    @Override
    public Log queryById(Integer lid) {
        return this.logDao.queryById(lid);
    }

    /**
     * 查询多条数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    @Override
    public List<Log> queryAllByLimit(int offset, int limit) {
        return this.logDao.queryAllByLimit(offset, limit);
    }

    /**
     * 新增数据
     *
     * @param log 实例对象
     * @return 实例对象
     */
    @Override
    public Log insert(Log log) {
        this.logDao.insert(log);
        return log;
    }

    /**
     * 修改数据
     *
     * @param log 实例对象
     * @return 实例对象
     */
    @Override
    public Log update(Log log) {
        this.logDao.update(log);
        return this.queryById(log.getLid());
    }

    /**
     * 通过主键删除数据
     *
     * @param lid 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer lid) {
        return this.logDao.deleteById(lid) > 0;
    }
}