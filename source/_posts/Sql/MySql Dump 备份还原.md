---
title: MySql Dump 备份还原
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---

<meta name="referrer" content="no-referrer" />


## 导出
**格式：mysqldump -u用戶名 -p密码 -d 数据库名 表名 > 脚本名;**

**1. 导出所有数据库**

	mysqldump -uroot -proot --all-databases >/tmp/all.sql

**2.  导出db1、db2两个数据库的所有数据**

	mysqldump -uroot -proot --databases db1 db2 >/tmp/db1_and_db2.sql
	简写：
	mysqldump -uroot　-p　db1 db2 >xxx.sql　

**3. 导出db1中的a1、a2表**

	mysqldump -uroot -proot --databases db1 --tables a1 a2 >/tmp/db1.sql
	简写：
	mysqldump -uroot　-p　db1 a1 a2　>xxx.sql　

**4. 条件导出，导出db1表a1中id=1的数据**

	mysqldump -uroot -proot --databases db1 --tables a1 --where="id='abc1000'" >/tmp/a1.sql
	简写：
	mysqldump -uroot　-p　db1 a1 'id=1' >xxx.sql 

**5. 导出结构不导出数据(-d)**

```
mysqldump -uroot -p --opt -d db1 >db1.sql
//说明：
mysqldump -uroot -p --opt -d 数据库名 >xxx.sql　
```

**6. 导出数据不导出结构(-t)**

```
mysqldump -uroot -p -t db1 >db1.sql
//说明：
mysqldump -uroot -p -t 数据库名 >xxx.sql　
```

## 导入

**1.mysql 命令导入**

适用于整个数据库迁移

```mysql
#语法格式
mysql -u用户名 -p密码 < 要导入的数据库数据(test.sql)
#实例：
mysql -uroot -p123456 < /tmp/test.sql
```

**2. source 命令导入**

**source 命令导入数据库需要先登录到数库终端**

```bash
mysql> create database abc character set utf8 collate utf8_general_ci;
mysql> create database abc;      # 创建数据库
mysql> use abc;                  # 使用已创建的数据库 
mysql> set names utf8;           # 设置编码
mysql> source /tmp/test.sql  # 导入备份数据库
```

## 其他命令

```shell
mysql> show processlist		#当前mysql任务列表，比如导入数据卡住查看
```

**mysqldump -u用戶名 -p密码 -d 数据库名 表名 > 脚本名;**

```
//导出整个数据库结构和数据
mysqldump -h localhost -uroot -p123456 database > dump.sql
//导出单个数据表结构和数据
mysqldump -h localhost -uroot -p123456 database table > dump.sql
//导出整个数据库结构（不包含数据）
mysqldump -h localhost -uroot -p123456 -d database > dump.sql
//导出单个数据表结构（不包含数据）
mysqldump -h localhost -uroot -p123456 -d database table > dump.sql
```

