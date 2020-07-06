package com.lifeisgg.attendance.dao;

import com.lifeisgg.attendance.entity.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * (Member)表数据库访问层
 *
 * @author makejava
 * @since 2020-06-10 21:19:45
 */
@Mapper
@Repository
public interface MemberDao {

    /*通过实体进行多表查询member*/
    List<Member> getMemberList(Member member);

    /*通过实体进行多表查询member,返回为实体对象*/
    Member getMember(Member member);



    /**
     * 查询指定行数据
     *
     * @param offset 查询起始位置
     * @param limit 查询条数
     * @return 对象列表
     */
    List<Member> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);


    /**
     * 通过实体作为筛选条件查询
     *
     * @param member 实例对象
     * @return 对象列表
     */
    List<Member> queryAll(Member member);

    /**
     * 新增数据
     *
     * @param member 实例对象
     * @return 影响行数
     */
    int insert(Member member);

    /**
     * 修改数据
     *
     * @param member 实例对象
     * @return 影响行数
     */
    int update(Member member);




}