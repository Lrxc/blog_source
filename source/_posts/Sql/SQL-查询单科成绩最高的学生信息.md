---
title: SQL-查询单科成绩最高的学生信息
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


##一 表结构如下
```
create table class(
	id int auto_increment primary key,
	name varchar(10),
	score varchar(10),
	subject varchar(10)
)

insert into class values(default,'张三',60,'数学');
insert into class values(default,'张三',70,'英语');
insert into class values(default,'李四',90,'数学');
insert into class values(default,'李四',20,'英语');
insert into class values(default,'王五',70,'数学');
insert into class values(default,'王五',90,'英语');
```

##二 数据查询
```
select * from class;
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ea18c6e345f81752.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##三. 查询单科成绩最高的学生信息
1. -- 首先查询 单科最高分
```
select subject,MAX(score) from class group by subject; 
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-e73526c1a4ed5e5e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.-- **单科最高分信息(错误)**
```
select subject,max(score),name from class group by subject;
```
可以看到下图，查询结果并不对
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1b7dca96752ccb98.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3.-- 单科最高分信息(方式一)
```
select subject,score,name from class where (subject,score) in 
(select subject,MAX(score) from class group by subject);
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c3170a0ef9fdadde.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4.-- 单科最高分信息(方式二)
```
select c.* from  
(select subject,MAX(score) score from class group by subject) d,class c
where d.subject=c.subject and  d.score=c.score 
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-29e84235344f180f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



参考：
https://www.cnblogs.com/geaozhang/p/6839297.html
https://blog.csdn.net/u010827070/article/details/79712303
