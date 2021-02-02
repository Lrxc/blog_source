---
title: Suse Linux 12 Ftp使用
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：SUSE Linux Enterprise Server 12 SP2
- Ftp: 

#### 一 安装启动
```
//suse 12 自带ftp功能，直接启动即可
service vsftpd start
//没有则安装
zypper install vsftpd
//查看ftp运行状态
service vsftpd status
```

#### 二 使用root连接(不建议)：
```
shell: ftp 192.168.1.1
//Root账号登录失败530
将root从/etc/ftpusers文件里删除或者加上注释,并重启ftp服务 
```

#### 二 添加新的连接用户(建议)
```
//增加用户ftp1，并制定ftpuser用户的主目录为/home/ftpuser
useradd -m -d /home/ftpuser ftpuser
passwd ftpuser //为ftpuser设置密码

//修改文件夹及子文件所属权限
chown -R ftpuser:root /home/ftpuser
//修改文件夹及子文件读写权限
chmod -R 777 /home/ftpuser
```

#### 三 配置文件(上传失败550问题)
```
shell: vim /etc/vsftpd.conf
//启动向服务器写的权限
write_enable=YES  
//允许本地用户登录
local_enable=YES
```
**/home/ftpuser文件夹及其子文件夹必须所属ftpuser用户**

#### 四 重启

```
//每次修改配置文件需要重启服务
service vsftpd restart
```

#### 五 防火墙

```
//每次修改配置文件需要重启服务
service vsftpd restart
```

#### Linux用户语法（附加学习）：

```
//新增
useradd -d /home/ftpUser -s /sbin/nologin -g users -G root ftpUser -m
useradd 选项 用户名
-d 目录 指定用户主目录，如果此目录不存在，则同时使用-m选项，可以创建主目录。
-g 用户组 指定用户所属的用户组。
-G 用户组，用户组 指定用户所属的附加组。
-s Shell文件 指定用户的登录Shell(/bin/sh)。
//修改
usermod -s /sbin/nologin ftp1	//限定用户ftp1不能telnet，只能ftp    
usermod -s /bin/sh ftp1	//用户ftp1恢复正常
usermod -d /ftp1 ftp1	//更改用户ftp1的主目录为/ftp1

//删除
userdel ftu1

文件夹权限
chown -R ftp1 /home/ftp1
chmod -R 777 /home/ftp1
```
