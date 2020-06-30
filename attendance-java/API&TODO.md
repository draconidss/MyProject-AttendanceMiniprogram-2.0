# TODO





# 1.Public(MP_PublicCon)

## 1.1检测初次登陆和实名信息

http://localhost:8888/MP/public/login

```json
table:wxuser,user
data:{
  wxuser:{
    openid,
  	nickName,
  	avatarUrl
  },
  //判断是否是点击登录
  isLogin
}
```

> - openid==不存在==此记录，就插入
>
>   ```json
>   {
>    code:200,
>    msg:"新用户插入成功",
>    wxuserInfo(wxuser),
>    userInfo(null)
>   }
>   ```
>
>   
>
> - openid==存在==,则更新nickname，avatarUrl和last_login
>
>   > - 如果uid为空，返回需要实名
>   >
>   >   ```json
>   >   {
>   >    code:201,
>   >    msg:"uid为空，未实名",
>   >    wxuserInfo(wxuser),
>   >    userInfo(null)
>   >   }
>   >   ```
>   >
>   > - 如果uid不为空，返回实名信息
>   >
>   >   ```json
>   >   {
>   >    code:202,
>   >    msg:"uid不为空，已实名",
>   >    wxuserInfo(wxuser),
>   >    userInfo(user)
>   >   }
>   >   ```



# 2.Profile(MP_ProfileCon)

## 2.1注册时查看电话号码或邮箱是否已经注册

http://localhost:8888/MP/profile/checkExist

```json
table:user
data:{
	phone,
  email
}
```

> - 电话号码存在
>
>   ```json
>   {
>    phone:null
>    msg:"警告，电话号码已存在"  
>   }
>   ```
>
> - 电话号码不存在
>
>   ```json
>   {
>    phone:phone
>    msg:"恭喜，电话号码不存在可以使用"  
>   }
>   ```
>
> - 邮箱同上



## 2.2实名注册

http://localhost:8887/MP/profile/realProfile

```json
table:wxuser,user
data:{
  openid,
  phone,
  realName,
  password
}
```

> - 如果phone或email已存在
>
>   ```json
>   {
>    code:400
>    msg:"电话号码或email已存在"
>   }
>   ```
>
> - 都不存在则更新wxuser表和插入user表
>
>   ```json
>   {
>    code:200
>    msg:"实名成功",
>    wxuserInfo,
>    userInfo
>   }
>   ```



# 3.Log(MP_LogCon)

## 3.1查找某个人日志或某个人在某间教室的日志

http://localhost:8887/MP/log/getLog

```json
table:log,room,wxuser
data:{
	uid,
  rid
}
都是逆序输出，输出最新的日志
```

> - 当uid不为空，rid**为空**时就是寻找某个人所有日志
>
>   ```json
>   {
>    code:200
>    msg:"查找用户xxx全部日志成功，共x条记录",
>    logDetailList[多表联合查询所组成]
>   }
>   ```
>
> - 当uid不为空，rid**不为空**时就是寻找某个人在某间教室所有日志
>
>   ```json
>   {
>    code:200
>    msg:"查找在xxx全部日志成功，共x条记录",
>    logDetailList[多表联合查询所组成]
>   }
>   ```
>   
> - 当uid为空，rid为空时，查找所有日志(管理员用)
>
>   ```json
>   {
>    code:200
>    msg:"查找全部日志成功，共x条记录",
>    logDetailList[多表联合查询所组成]
>   }
>   ```
>
> - 当uid为空，rid不为空时，查找某间房间所有日志
>
>   ```json
>   {
>    code:200
>    msg:"查找xxx教室全部日志成功，共x条记录",
>    logDetailList[多表联合查询所组成]
>   }
>   ```



# 4.Rank(MP_LogCon)

## 4.1获取总时长

http://localhost:8888/MP/log/getDuration

```json
table:log,wxuser
data:{
	uid,
  rid
}
逆序输出，从during最大开始
```

> - 当uid和rid**都为空时**，即查找每个人总时长以及在每间教室的时长
>
>   ```json
>   {
>     code:200,
>     msg:"获取每个人的总时长",
>     uid,
>     nickName,
>     avatarUrl,
>     allDuring，
>     List<roomDuringList>
>   }
>   ```
>
> - 当uid**为空**时，rid**不为空**时，即查找某个教室每个人总时长
>
>   ```json
>   {
>     code:200,
>     msg:"获取xxx教室每个人的总时长",
>     uid,
>     rid,
>     rname,
>     address,
>     del,
>     nickName,
>     avatarUrl,
>     allDuring
>   }
>   ```
>
> - 当uid**不为空**，rid**为空**，即查找某个人总时长
>
>   ```json
>   {
>     code:200,
>     msg:"获取xxx的总时长",
>     uid,
>     nickName,
>     avatarUrl,
>     allDuring,
>      List<roomDuringList>
>   }
>   ```
>
> - 当uid**不为空**，rid**不为空**，即查找某个人在某间教室总时长
>
>   ```json
>   {
>     code:200,
>     msg:"获取某个人xxx教室的总时长",
>     uid,
>     rid,
>     rname,
>     address,
>     del,
>     nickName,
>     avatarUrl,
>     allDuring
>   }
>   ```
>



# 5.Home(MP_HomeCon)

## 5.1获取某个人现在在那间房间或者不在房间

http://localhost:8888/MP/home/getStatus

```json
table:log,room,wxuser,roomadmin
data:{
	uid
}
```

> - 如果获取到的最新日志的status为0，说明不在教室
>
>   ```json
>   {
>    code:200
>    msg:"不在教室",
>    logDetailList(null)
>   }
>   ```
>
> - 如果获取到的最新日志的status为1，说明在教室,就返回这间教室的日志，公告管理员
>
>   ```json
>   {
>    code:201
>    msg:"在教室xxx",
>    roomLogInfo[],
>    adminInfo[]
>   }
>   ```



## 5.2进入某个房间后

http://localhost:8887/MP/home/inRoom

```json
table:log,room,wxuser,roomadmin
data:{
	uid,
  rid
}
```

先判断是否在教室

> - 如果已经在某个教室就提醒必须要先退出之前的教室
>
>   ```json
>   {
>    code:202
>    msg:"请先打卡退出教室"
>   }
>   ```
>
> - 如果不在教室就插入一条进入教室日志，并返回这间教室的日志，公告管理员
>
>   ```json
>   {
>    code:201
>    msg:"在教室xxx",
>    roomLogInfo[],
>    adminInfo[]
>   }
>   ```





## 5.3离开某个房间后

http://localhost:8887/MP/home/outRoom

```json
table:log,room,wxuser,roomadmin
data:{
	uid,
  rid
}
```

先判断是否在教室

> - 如果没有进入教室
>
>   ```json
>   {
>    code:202
>    msg:"请先打卡进入教室"
>   }
>   ```
>
> - 如果在教室，就插入离开教室的日志，并返回离开教室的日志
>
>   ```json
>   {
>    code:200
>    msg:"退出教室成功",
>    outLog
>   }
>   ```



# 6.Admin(MP_AdminCon)

## 6.1用户管理

分配超级管理员

## 6.2房间管理

增删查改房间

增删查管理员

## 6.3日志管理

查看所有日志

## 6.4房间管理员管理

查某间房间管理员

某个用户管理的房间

增删查改公告

