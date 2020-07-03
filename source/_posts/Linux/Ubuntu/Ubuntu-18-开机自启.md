---
title: Ubuntu-18-开机自启
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---


ubuntu18.04 不再使用initd管理系统，改用systemd

1. 设置启动参数
vim /lib/systemd/system/rc.local.service 
```
[Unit]
Description=/etc/rc.local Compatibility
Documentation=man:systemd-rc-local-generator(8)
ConditionFileIsExecutable=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes
GuessMainPID=no

#这一段原文件没有，需要自己添加
[Install]
WantedBy=multi-user.target
Alias=rc-local.service
```
2. 添加软链接
```
ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/rc.local.service
```
3. 创建服务
```
touch /etc/rc.local 
```
4. 赋可执行权限
```
chmod 755 /etc/rc.local 
```
5. 编辑自启动服务
vim /etc/rc.local
```
#开机打印hello
echo "hello" > /etc/test.log
# 开机启动zookeeper
/usr/local/zookeeper/bin start
```
