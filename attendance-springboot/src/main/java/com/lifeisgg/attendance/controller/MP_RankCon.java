package com.lifeisgg.attendance.controller;

import com.lifeisgg.attendance.dao.LogDao;
import com.lifeisgg.attendance.entity.Wxuser;
import com.lifeisgg.attendance.service.MP_LogService;
import com.lifeisgg.attendance.service.MP_PublicService;
import com.lifeisgg.attendance.service.MP_RankService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * @WebName: MP_RankCon
 * @Description: TODO
 * @author: Chen Long
 * @date: 2020/6/13  16:01
 * “Welcome,my master”
 */
/*排行榜Con*/
@RestController
@RequestMapping("MP/rank")
public class MP_RankCon {
    @Resource
    private MP_RankService mP_RankService;

    @Resource
    private LogDao logDao;

    /**/
    @RequestMapping("getRank")
    @ResponseBody
    public Map<Object,Object> getRank(Integer duration) {
        return mP_RankService.getRank(duration);
    }


}