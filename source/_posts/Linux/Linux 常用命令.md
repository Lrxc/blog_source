---
title: Linux 常用命令
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 一. 查找文件

```shell
whereis java
which java
#看看对应软链接
ls -lrt /usr/bin/java
#看看对应软链接
ls -lrt /etc/alternatives/java
```

## 二. 进程查看

```shell
#进程
ps -ef|grep java
#内存占用(进程id)(按E切换内存单位)
top -p 8080
#结束进程(进程id)
kill -9 8080
```
## 三. 硬件信息
```shell
#linux 内核版本
uname -a
cat /proc/version
#系统发行版本
lsb_release -a
cat /etc/os-release
cat /etc/issue
#cpu
lscpu
#内存
free -h
#磁盘空间
df -h
```

## 四. 用户管理

**用户信息存放文件**

```shell
# 使用cat命令查看
用户名和 UID 被保存在/etc/passwd文件中，文件权限 (-rw-r--r--)
组和GID 被保存在 /etc/group文件中，文件权限(-r--------)
用户口令(密码)被保存在 /etc/shadow文件中 ，文件权限(-rw-r--r-- )
组口令被保存在 /etc/gshadow文件中 ，文件权限 (-r--------)
```

**用户相关的命令**

```shell
who i am	#显示当前用户的名称
w/who		#显示登录用户及相关信息
id			#显示用户当前的uid、gid和用户所属的组列表
groups		#显示指定用户所属的组列表
```

**用户管理**

```shell
#新增用户
useradd -m -d /home/ftpuser ftpuser
passwd ftpuser	#为ftpuser设置密码

#新增参数说明
useradd -m -d /home/ftpUser -s /sbin/nologin -g users -G root ftpUser
useradd 选项 用户名
-d 目录 指定用户主目录，如果此目录不存在，则同时使用-m选项，可以创建主目录。
-g 用户组 指定用户所属的用户组。
-G 用户组，用户组 指定用户所属的附加组。
-s Shell文件 指定用户的登录Shell(/bin/sh)。

usermod -g root ftpuser	#设置为root用户组
userdel ftpuser			#删除用户
```
**用户组管理**

```shell
groupadd 用户组	#新建
groupmod 用户组	#修改
groupdel 用户组	#删除
```

**口令管理**

用户管理的一项重要内容是用户口令的管理。用户账号刚创建时没有口令，但是被系统锁定，无法使用，必须为其指定口令后才可以使用，比如设置密码

```shell
passwd <用户账号名>		#设置用户口令
passwd -l <用户账号名>	#禁用用户账户口令
passwd -S <用户账号名>	#查看用户账户口令状态
passwd -u <用户账号名>	#恢复用户账户口令
passwd -d <用户账号名>	#清除用户账户口令
```

## 六. 权限管理

**基础命令**

```shell
#改变文件或目录的属主（所有者）（-R : 处理指定目录以及其子目录下的所有文件）
chown -R ftp1 /home/ftp1
chown -R ftp1:root /home/ftp1
chmod -R 777 /home/ftp1	#改变文件或目录的权限
chgrp					#改变文件或目录所属的组
umask					#设置文件的缺省生成掩码
```

**赋予新建用户root权限 **

**方法1:**

```shell
#修改/etc/sudoers文件，放开注释
%wheel ALL=(ALL) NOPASSWD: ALL
#将用户加入root组
usermod -g root test
```

**方法2:**

```shell
#修改/etc/sudoers文件,root ALL=(ALL) ALL 下面加一行
test ALL=(ALL) ALL
```

**方法3（靠谱）：**

```shell
#修改/etc/passwd文件,找到test用户那一行，并把用户ID修改为0（用户ID为x后面的那个数字）
test:x:1002:100::/home/test:/bin/bash (1002 改成0)
```

**以上方法都需要重新登录test才行。**

## 中文文件乱码

修改当前用户

```
#vim ~user/.profile
#放开注释
export LANG=es_ES.UTF-8
#或则如下
export LANG=zh_CN.UTF-8
```

linux 文件乱码

```
#转换文件编码
convmv -f gbk -t utf-8 -r --notest /home/file.zip 
```

## 定时任务

Linux Crontab

```
格式：[分] [时] [日] [月] [周] [要运行的命令]
1 * * * * /usr/run.sh	#每分钟执行一次
```

SpringBoot Scheduled

```
[秒] [分] [时] [日] [月] [周] [年]
注：[年]不是必须的域，可以省略[年]
1 * * * * *		#每秒执行一次
1 * * * * * *	#每秒执行一次
```

