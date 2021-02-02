---
title: Ubuntu-Redis-配置
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


一  安装
1 直接命令安装
```
# sudo apt-get update
# sudo apt-get install redis-server
//后台启动，手动指定配置文件
redis-server /etc/redis/edis.conf
```
二  启动
```
//成功后会有界面
# redis-server
后台启动使用默认配置
# redis-server &
//后台启动，手动指定配置文件
redis-server /etc/redis/edis.conf

//附加命令：
# /etc/init.d/redis-server stop
# /etc/init.d/redis-server start
# /etc/init.d/redis-server restart
```
三  连接
```
# redis-cli
//以上命令将打开以下终端：
redis 127.0.0.1:6379>
//127.0.0.1 是本机 IP ，6379 是 redis 服务端口。现在我们输入 PING 命令。
redis 127.0.0.1:6379>ping
PONG
//显示PONG表示成功

//附加端口查看方式
# pgrep redis
# ps -ef |grep redis
```

四  外网访问
打开配置文件：/etc/redis/redis.conf

```
//打开把bind一行 注释掉
# bind 127.0.0.1
//开启后台运行
# daemonize no
//关闭保护模式
# protected-mode no 

//关闭防火墙
# sudo  ufw enable|disable
//关闭redis 防火墙
# sudo ufw allow 6379
```

五 卸载
```
//卸载软件
# apt-get remove redis
# apt-get purge --auto-remove redis-server
//清除配置
#apt-get remove --purge redis
//删除残留文件,先查找出来文件,再进行删除
# find / -name redis
//全部删除即可
#rm -rf var/lib/redis/
```
