---
title: SQL-索引
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


# 一 普通索引
## 1.  3种创建方式
```
#创建索引方式一(上面创建表时直接指定)
CREATE TABLE test(
id int(10) PRIMARY KEY AUTO_INCREMENT,
name varchar(20) comment '姓名',
index i_name1 (name,age)
)
```
```
#创建索引方式二(创建)
CREATE INDEX i_name2 ON test(name); 
```
```
#创建索引方式三(修改表)
ALTER TABLE test ADD INDEX i_name3(name);
```
## 2. 删除索引
```
#显示索引
SHOW INDEX FROM test;
#删除索引
DROP INDEX i_name1 ON test; 
```
# 二 唯一索引
它与前面的普通索引类似，不同的就是：索引列的值必须唯一，但允许有空值。如果是组合索引，则列值的组合必须唯一。
创建方式同上，需要在 关键字 INDEX 前加上 UNIQUE
```
#创建索引方式二(创建)
CREATE UNIQUE INDEX i_name2 ON test(name); 
```

# 三 组合索引
## 1 创建
和普通索引一样，只不过列名会多几个(username,password)
```
CREATE INDEX i_name ON t_user(name,pwd); 
```
## 2 原则
最左优先原则：
index key on tablename（a,b,c）

select * from tablename where a=1 and ...有效
select * from tablename where b=1 and ...无效
select * from tablename where c=1 and ...无效

也就是说 索引顺序的第一个(a)必须和WHERE后的第一个查询条件(a=1)顺序一样，否则会失效

## 3 测试速度

mysql：

```
-- EXPLAIN ...
EXPLAIN SELECT * from t_employee m WHERE m.address in ('28.88261343248432','697.6149638161202','688.7925497151842','718.4714942411255','237.98116598090266','330.40502605066166');
```

使用EXPLAIN 关键字查询，返回值有个type属性，若是**ALL**则没使用索引，若是其它**（eg: range）**则成功使用

oracle：

```
--创建索引
create index index_sno on student('name');
select * from all_indexes where table_name='student';

--查看执行计划（看索引是否被执行）
explain plan for select * from bank where bankseq='1';
select * From Table(dbms_xplan.display());
```

