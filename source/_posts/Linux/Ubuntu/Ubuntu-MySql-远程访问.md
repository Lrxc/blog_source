---
title: Ubuntu-MySql-远程访问
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---


## 一 安装

1. 安装命令
```
# sudo apt install mysql-server
```
2 .查看是否安装成功
```
# sudo netstat -tap | grep mysql
```
3 . 进入数据库
```
# sudo mysql -uroot -proot
```
4.查看数据库（必须分号）
```
# show databases;
```

## 二 修改配置（可选）
1 修改密码

```
# sudo vim /etc/mysql/debian.cnf
```
2 重启
```
# sudo service mysql restart/start/stop
```

## 三 外网访问

1  开放3306端口 
```
//其中bind-address = 127.0.0.1注释了
# sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
```
2. 授权用户远程访问
```
//进入mysql命令行(root:root)
mysql> grant all on *.* to root@'%' identified by 'root';
flush privileges;
```
3 重启
```
service mysql restart
```
4 获取ip
```
# ifconfig
```

## 四、完全删除

1  删除mysql
```
# sudo apt-get remove --purge mysql-\*
```
2 查找剩余文件
```
# sudo find  / -name mysql -print
```
3 手动删除残留
```
# sudo    rm   -rf     /ect/init.d/mysql
```
