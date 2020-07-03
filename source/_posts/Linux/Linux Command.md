---
title: Linux Command
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---


查找文件

```java
whereis java
which java
//看看对应软链接
ls -lrt /usr/bin/java
//看看对应软链接
ls -lrt /etc/alternatives/java
```

进程

```
//进程
ps -ef|grep java
//内存占用(进程id)
top -p 8080
//结束进程(进程id)
kill -9 8080
```
硬件
```
//系统版本
lsb_release -a
//linux 版本
-uname -a
-uname -r
//cpu
lscpu
//内存
free -m
//磁盘空间
df -h
```