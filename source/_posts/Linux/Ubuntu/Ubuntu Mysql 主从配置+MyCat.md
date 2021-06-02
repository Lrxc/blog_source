---
title: Ubuntu Mysql 主从配置+MyCat
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：ubuntu 18.04 LTS
- mysql:  5.7

##一 MySql主从配置
#####1 安装mysql
1  安装
```
sudo apt-get install mysql-server
```
2. 开启外网访问
```
# sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
其中bind-address = 127.0.0.1注释了
```
3. 授权用户远程访问
```
//进入mysql命令行(root:root)
mysql>  grant all on *.* to root@'%' identified by 'root';
flush privileges;
```
4. 虚拟机克隆一份

#####2 修改主服务器配置
1. 修复mysqld.cnf配置并重启
vim /etc/mysql/mysql.conf.d/mysqld.cnf
```
[mysqld]
# 下面两行的注释放开
server-id               = 1      #主数据库端ID号
log_bin                 = /var/log/mysql/mysql-bin.log      #开启二进制日志 
```
重启
```
# /etc/init.d/mysql restart
```
2. 创建从服务器访问的权限账号
```
#创建slave账号you，密码123456
mysql>grant replication slave on *.* to 'you'@'192.168.234.130' identified by '123456';
#更新数据库权限
mysql>flush privileges;
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6c75ea35df049786.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 查看主服务器状态
```
show master status;
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-430c95ee6ad417b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#####3 修改从服务器配置
1. 修复mysqld.cnf配置并重启
vim /etc/mysql/mysql.conf.d/mysqld.cnf
```
[mysqld]
# 下面两行的注释放开
server-id               = 2      #主数据库端ID号,和从数据不能重复
log_bin                 = /var/log/mysql/mysql-bin.log      #开启二进制日志 
```
2. 执行同步命令
```
#设置主服务器ip，账号密码，同步位置(同上图标记)
mysql>change master to master_host='192.168.234.129',
master_user='you',
master_password='123456',
master_log_file='mysql-bin.000001',
master_log_pos=602;
#开启同步功能
mysql>start slave;
```
3. 查看 slave 从库
```
mysql> show slave status\G;
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-36641201cbd9c3b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##二 MyCat配置
1. 配置安装
官网下载：http://dl.mycat.io

文件说名：
- server.xml MyCat 的配置文件，设置账号、参数等
- schema.xml MyCat 对应的物理数据库和数据库表的配置
- rule.xml MyCat 分片（分库分表）规则
2. 配置schema.xml，多余的可以删除
```
schema name="ego":  要操作的数据库逻辑名
table name="test":  要操作的表的逻辑名
writeHost:  mysql的连接信息
readHost: mysql的连接信息
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-4df8c35035ef80ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 配置 server.xml，连接macat的信息
```
<user name="root" defaultAccount="true">
                <property name="password">123456</property>
                # 要操作的数据库逻辑名，对应上面的配置
                <property name="schemas">ego</property>
</user>
```
4. 启动
```
./bin/mycat start
```
5. 测试mycat与测试mysql完全一致，mysql怎么连接，mycat就怎么连接。
```
//mycat 默认端口8806
mysql -uroot -p123456 -P8066 -h127.0.0.1
```
