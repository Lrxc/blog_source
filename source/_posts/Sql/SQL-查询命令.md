---
title: SQL-查询命令
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---


## 一 数据库基本操作
```
#指定数据库
use wx;

#创建表
create table test(
id int(10) primary key auto_increment,
name varchar(20) comment '姓名',
age int(10)
) charset=utf8 comment '哈哈';

#插入数据
insert into test(id,name) values(1,"战三");
insert into test(id,name) values(2,"两居");

#更新数据
update test 
set name="李四" 
where id = 1;

#删除数据
delete from test where id =1;

#查询
select * from test;

#删除表
drop table test;

#修改表结构--增加列
ALTER TABLE test ADD sex varchar(2) DEFAULT '1' comment '性别';
#修改表结构--修改列
ALTER TABLE test MODIFY sex int(2);
#修改表结构--删除列
ALTER TABLE test DROP COLUMN sex;
```

##  二 高级查询

**1. 新建表结构**
```
create table t_employee(
id int(10) primary key auto_increment,
name varchar(20),
age int(10)
) CHARSET=utf8 comment "员工表";

create table t_salary(
id int(10) primary key auto_increment,
money int(20),
monch int(10)
) CHARSET=utf8 comment "工资表";

insert into t_employee values(1,"张三",18);
insert into t_employee values(2,"李四",28);
insert into t_employee values(3,"王五",38);

insert into t_salary values(1,1000,1);
insert into t_salary values(2,20,2);
insert into t_salary values(3,300,3);
```
**2. 聚合查询**
```
#平局值/和
select avg(money),sum(money) from t_salary;
# WHERE 关键字无法与聚合函数一起使用
select * from t_salary t
having t.avg(money) >1;
```
**3. 多表查询**
```
#多表查询，又称笛卡尔查询，查询结果：列是和 行是积
select * from t_employee,t_salary;
# 加上筛选条件，可以避免笛卡尔现象
select * from t_employee e,t_salary s where e.age>20 and s.monch>2;
```
**4. 连接查询**
```
#交叉查询(多表查询，又称笛卡尔查询，查询结果：列是和 行是积)
select * from t_employee cross join t_salary;
select * from t_employee,t_salary;

#内连接(就是交叉查询多了查询条件)
select * from t_employee e inner join t_salary s on e.age>20 and s.monch>2;
select * from t_employee e,t_salary s where e.age>20 and s.monch>2;

#外连接(outer 可以省略)
select * from t_employee e left outer join t_salary s on e.age>20 and s.monch>2;
select * from t_employee e right outer join t_salary s on e.age>20 and s.monch>2;
select * from t_employee e full outer join t_salary s on e.age>20 and s.monch>2;
```

关于INNER JOIN、 LEFT JOIN、 RIGHT JOIN、 FULL JOIN区别，借用雪峰大神的图：
![image.png](https://upload-images.jianshu.io/upload_images/2803682-46c49b18edb86a6e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5. 
```
# 联合查询(两个表的数据加到一起，必须有相同的查询列)
select * from t_employee union select * from t_salary;
# union all 会显示重复
select * from t_employee union all select * from t_salary;
```


参考附录：
廖雪峰文章：[https://www.liaoxuefeng.com/wiki/1177760294764384/1179610888796448](https://www.liaoxuefeng.com/wiki/1177760294764384/1179610888796448)

