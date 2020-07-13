-- drop database if exists attendance2;
-- create database attendance2 character set utf8;
-- use attendance2;


/*用户表,权限level,1为超管,2为普通用户*/
create table user(
uid int auto_increment primary key ,
phone varchar(30) unique,
email varchar(50) ,
realName varchar(20),
password varchar(15),
level int DEFAULT 2
);

-- 微信用户表
create table wxuser(
uid int DEFAULT Null unique,
openid varchar(40) primary key,
nickName varchar(30) not null,
avatarUrl text not null,
regDate datetime not null,
lastLoginDate datetime not null
);

-- 实验室成员表
create table member(
rid int,
uid int,
status int,
isAdmin int default 0
);


/*-- 教室表*/
create table room(
	rid int AUTO_INCREMENT primary key,
	rname varchar(20) not null,
	address varchar(50) not null,
	del int DEFAULT 1
);

/*-- 教室管理员表*/
create table roomAdmin(
	aid int AUTO_INCREMENT primary key,
	rid int,
	uid int,
	notice text,
	nDate datetime,/*消息发布时间*/
	del int default 1
);


/*-- 日志表*/
create table log(
	lid int AUTO_INCREMENT primary key,
	uid int not null,
	rid int not null,
	-- status,1为进，0为出
	status int not null,	
	lDate datetime DEFAULT CURRENT_TIMESTAMP,
	/*状态为进时为time空，否则计算当前时间和进入时间之差，单位为时间戳*/
	during bigint
);


/*alter table roomAdmin add constraint fk1 foreign key(rId) REFERENCES room(rId);
alter table roomAdmin add constraint fk2 foreign key(uId) REFERENCES wxuser(uId);
alter table log add constraint fk3 foreign key(uId) REFERENCES wxuser(uId);*/

/*--插入一个用户*/
INSERT into user(phone,email,realName,password,level)
VALUE ("15322533185","1138312802@qq.com","陈龙","0.00.0","1");
INSERT into user(phone,email,realName,password,level)
VALUE ("18933573671","3481723658@qq.com","李华","0.00.0","2");
INSERT into user(phone,email,realName,password,level)
VALUE ("18028405303","66666@qq.com","简自豪","0.00.0","2");

/*--插入一个微信用户*/
INSERT into wxuser(uid,openid,nickName,avatarUrl,regDate,lastLoginDate)
VALUE ("1","od6Es5NOTRaVHRvEZNnow2WLqN7Q","Morty","https://wx.qlogo.cn/mmopen/vi_32/gzMS93L5HxDu7YgEUXqmrrXw6xBq8DnGKibtddgIBibpCHh6a9DGqtl40CswSNUnd3EGKwpnNictibRkKfh9pVH3yA/132","2020-01-01 08:00:00","2020-01-03 08:00:00");
INSERT into wxuser(uid,openid,nickName,avatarUrl,regDate,lastLoginDate)
VALUE ("2","od6Es5L1Q6HvorEiUsa5N6eHlo5o","+T","https://wx.qlogo.cn/mmopen/vi_32/U74glmWRaf6DibbSrPjy7OGr9MibkjvqX8YvRzcEPbMQRaJxjvuCqCoZqtwaMc5TAc91axBhtTLmCdtMdraRwZTg/132","2020-02-03 08:00:00","2020-01-02 08:00:00");
INSERT into wxuser(uid,openid,nickName,avatarUrl,regDate,lastLoginDate)
VALUE ("3","od6Es5GYjg2bN0BjRo7tuXT5FFLs","阿龙","https://wx.qlogo.cn/mmopen/vi_32/1Nu9LYj4CuRScCG2rovEYIQqG0DWiazuib7o4xAoaoO0ImW6icMUKs3pOy5TzTa79FaVv7JMPEnmcZ5naytxiaAyBA/132","2020-02-03 08:00:00","2020-01-02 08:00:00");

/*--插入到成员表*/
INSERT into member(rid,uid,status,isAdmin)
VALUE ("1","1","0","1");
INSERT into member(rid,uid,status,isAdmin)
VALUE ("1","2","1","0");
INSERT into member(rid,uid,status,isAdmin)
VALUE ("2","2","0","1");
INSERT into member(rid,uid,status,isAdmin)
VALUE ("3","2","0","0");

/*--room插入一个房间*/
INSERT into room(rname,address,del) VALUE ("综B902","综合楼B911","1");
INSERT into room(rname,address,del) VALUE ("综B913","综合楼B913","1");
INSERT into room(rname,address,del) VALUE ("综B901","综合楼B901","1");
INSERT into room(rname,address,del) VALUE ("教三104","教三104","1");
INSERT into room(rname,address,del) VALUE ("教三105","教三105","1");
INSERT into room(rname,address,del) VALUE ("教三106","教三106","1");
INSERT into room(rname,address,del) VALUE ("教三107","教三107","1");
INSERT into room(rname,address,del) VALUE ("教三108","教三108","0");
INSERT into room(rname,address,del) VALUE ("教三109","教三109","0");
INSERT into room(rname,address,del) VALUE ("教三110","教三110","0");

/*--roomAdmin房间管理员*/
INSERT into roomAdmin(rid,uid,notice,nDate,del) VALUE ("1","1","公告：uid为1,rId为1，公告示例","2020-01-05 08:00:00","1");
INSERT into roomAdmin(rid,uid,notice,nDate,del) VALUE ("2","2","公告：uid为2,rId为2，公告示例","2020-01-05 09:00:00","1");

/*--插入一条日志记录*/
INSERT into log(uid,rid,status,during) VALUE ("1","1","1",null);
INSERT into log(uid,rid,status,during) VALUE ("1","1","0","3600");
INSERT into log(uid,rid,status,during) VALUE ("1","2","1",null);
INSERT into log(uid,rid,status,during) VALUE ("1","2","0","3600");




