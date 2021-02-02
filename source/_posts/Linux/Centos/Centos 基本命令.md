---
title: Centos 基本命令
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


#### 常用命令：
	搜索软件
	yum search package
	安装软件
	yum install package
	安装某个版本的软件包
	yum install package=version
	卸载某个软件包
	yum remove package
	升级某个软件包
	yum update package

#### 源：

	-- 查看源
	yum repolist
	-- 禁用原来无效的源
	yum --disable repoid
	-- 查询是否安装了 某个yum源
	rpm -qa |grep repo-name  
	-- 删除该yum源
	rpm -e repo-name
	yum remove repo-name
	
	--1 首先备份
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	
	--2 阿里源
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
	
	--2 网易开源镜像
	wget https://mirrors.163.com/.help/CentOS7-Base-163.repo
	mv CentOS7-Base-163.repo CentOS-Base.repo
	
	--2 fedora的epel仓库(非官方源)
	yum install epel-release
	
	--3 添加好以后需要先刷新：
	yum clean all
	yum makecache

[参考官网](https://zh.opensuse.org/%E8%BD%AF%E4%BB%B6%E6%BA%90%E9%95%9C%E5%83%8F%E7%AB%99%E7%82%B9#.E5.AE.98.E6.96.B9.E9.95.9C.E5.83.8F.E7.AB.99.E7.82.B9.E5.88.97.E8.A1.A8)

#### SSH：

	$ vim /etc/ssh/sshd_config
	-- 做如下修改：
	PermitRootLogin yes  //权限root登录
	PasswordAuthentication yes  //密码验证
	
	防火墙端口：
	$ vim /etc/sysconfig/SuSEfirewall2
	-- 做如下修改
	FW_SERVICES_EXT_UDP="22"
	FW_SERVICES_EXT_TCP="22"
	
	--SSH自启动：
	$ systemctl enable sshd.service
	--SSH状态/重启
	$ systemctl status/restart sshd.service


#### 防火墙：
    --启动防火墙
    systemctl start firewalld 
    systemctl stop firewalld
    --自启
    systemctl enable firewalld
    sytemctl disable firewalld

#### 自启动：
	1 vim /etc/init.d/after.local
		--添加如下
		/usr/local/run.sh
	2 新建脚本 vim /usr/local/run.sh
		--添加如下
		echo "this is " > /usr/local/1.txt
	3 脚本赋值	权限
		chmod +x run.sh
	4 重启看/usr/local/1.txt
		reboot
[参考](https://blog.csdn.net/rokii/article/details/6316443)

