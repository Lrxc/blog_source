---
title: Ubuntu Mysql 数据差异对比
date: 2018-07-01 16:01:33
categories: 
- Linux 
- mysql
tags: [linux,mysql]
---

<meta name="referrer" content="no-referrer" />
## 环境及版本

- linux： ubuntu 18.0.4 lsb
- mysql:   5.7.x || 8.x



##　一 mysqldiff

1. 安装

   ```
   # wget https://cdn.mysql.com/archives/mysql-utilities/mysql-utilities-1.6.5.tar.gz
   # tar xf mysql-utilities-1.6.5.tar.gz
   # cd mysql-utilities-1.6.5
   # python setup.py build
   # python setup.py install
   # mysqldiff --version　
   ```

2. 命令

   - 语法

     ```
     mysqldiff 
     --server1=user:pass@host:port:socket 
     --server2=user:pass@host:port:socket  
     db1.object1:db2.object1  
     db3:db4
     
     # 这个语法有两个用法：
     db1.object1:db2.object1：如果指定了具体表对象，那么就会详细对比两个表的差异，包括表名、字段名、备注、索引、大小写等所有的表相关的对象。
     db3:db4：如果只指定数据库，那么就将两个数据库中互相缺少的对象显示出来，不比较对象里面的差异。这里的对象包括表、存储过程、函数、触发器等。
     ```

   - 参数说明
     
     
     ```
     # --server1 配置server1的连接
     # --server2 配置server2的连接
     # db1:db2 要对比的数据库
     # --changes-for 修改对象。例如--changes-for=server2，那么对比以sever1为主，生成的差异的修改也是针对server2的对象的修改
     # --difftype  差异的信息显示的方式，有[unified|context|differ|sql]，默认是unified。如果使用sql，那么就直接生成差异的SQL
     # -vv：便于调试，输出许多信息
     # --force：完成所有的比较，不会在遇到一个差异之后退出
     ```
     
   - 示例
   
     ```
     # 测试
     mysqldiff --server1=root:root@localhost --server2=root:root@localhost --changes-for=server2 --difftype=sql --force study.test1:study.test2
     
     # 保存差异sql
     mysqldiff --server1=root:root@localhost --server2=root:root@localhost --changes-for=server2 --difftype=sql --force study:study >output.sql
     ```
   

## 二  mysqldbcompare

1. 安装

   同上 mysqldiff

2. 命令

   - 语法
   
     ```
     mysqldbcompare 
     --server1=user:pass@host:port:socket 
     --server2=user:pass@host:port:socket 
     db1:db2
     ```
   
   - 参数说明
   
     ```
     # --server1 配置server1的连接
     # --server2 配置server2的连接
     # db1:db2 要对比的数据库
     # --changes-for 修改对象。例如--changes-for=server2，那么对比以sever1为主，生成的差异的修改也是针对server2的对象的修改
     # --difftype  差异的信息显示的方式，有[unified|context|differ|sql]，默认是unified。如果使用sql，那么就直接生成差异的SQL
     # -t,--run-all-tests 运行完整比较，遇到第一次差异时不停止
     ```
   
   - 示例
   
     ```
     # 本地数据库
     mysqldbcompare --server1=root:root@localhost --server2=root:root@localhost --changes-for=server1 --difftype=sql --run-all-tests ys_asset:ys_asset2
     
     # 远程数据库，并且保存差异sql文件
     mysqldbcompare --server1=root:root@localhost --server2=root:'123qwe'@10.95.138.105:3306 --changes-for=server1 --difftype=sql --run-all-tests ys_asset:ys_asset >results.log
     ```

