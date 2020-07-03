---
title: MysqlDump
date: 2017-07-01 16:01:33
categories: Sql
tags: sql
---


## 导出
**1. 导出所有数据库**

	mysqldump -uroot -proot --all-databases >/tmp/all.sql

**2.  导出db1、db2两个数据库的所有数据**

	mysqldump -uroot -proot --databases db1 db2 >/tmp/db1_and_db2.sql
	简写：
	mysqldump -uroot　-p　数据库名　>xxx.sql　

**3. 导出db1中的a1、a2表**

	mysqldump -uroot -proot --databases db1 --tables a1 a2 >/tmp/db1.sql
	简写：
	mysqldump -uroot　-p　数据库名 表名1 表名2　>xxx.sql　

**4. 条件导出，导出db1表a1中id=1的数据**

	mysqldump -uroot -proot --databases db1 --tables a1 --where='id=1' >/tmp/a1.sql

**5. 生成新的binlog文件,-F**

有时候会希望导出数据之后生成一个新的binlog文件,只需要加上-F参数即可

	mysqldump -uroot -proot --databases db1 -F >/tmp/db1.sql

**6. 只导出表结构不导出数据，--no-data**

	mysqldump -uroot -proot --no-data --databases db1 >/tmp/db1.sql

**7.  跨服务器导出导入数据**

将h1服务器中的db1数据库的所有数据导入到h2中的db2数据库中，db2的数据库必须存在否则会报错

```undefined
mysqldump --host=h1 -uroot -proot --databases db1 |mysql --host=h2 -uroot -proot db2
```

加上-C参数可以启用压缩传递。

```bash
mysqldump --host=192.168.80.137 -uroot -proot -C --databases test |mysql --host=192.168.80.133 -uroot -proot test 
```

**8. 导出结构不导出数据**

```css
mysqldump --opt -d db1 -uroot -p > db1.sql
//说明：
mysqldump　--opt　-d　数据库名　-u　root　-p　>　xxx.sql　
```

**9. 导出数据不导出结构**

```css
mysqldump -t db1 -uroot -p > db1.sql
//说明：
mysqldump　-t　数据库名　-uroot　-p　>　xxx.sql　
```

## 导入

**1.mysql 命令导入**

适用于整个数据库迁移

```mysql
#语法格式
mysql -u用户名 -p密码 < 要导入的数据库数据(runoob.sql)
#实例：
mysql -uroot -p123456 < runoob.sql
```

**1. source 命令导入**

source 命令导入数据库需要先登录到数库终端：

```bash
mysql> create database abc character set utf8 collate utf8_general_ci;
mysql> create database abc;      # 创建数据库
mysql> use abc;                  # 使用已创建的数据库 
mysql> set names utf8;           # 设置编码
mysql> source /home/abc/abc.sql  # 导入备份数据库
```