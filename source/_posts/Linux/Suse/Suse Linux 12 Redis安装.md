---
title: Suse Linux 12 Redis安装
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：
- 系统：SUSE Linux Enterprise Server 12 SP2
- Redis: Redis

#### 配置源

	-- 添加源
	zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
	--更新
	zypper refresh
	-- 安装
	zypper in redis

#### 启动：
	//成功后会有界面
	# redis-server
	//后台启动使用默认配置
	redis-server &
	//后台启动，手动指定配置文件(见后面远程访问)
	redis-server ./redis.conf
	//开机自启
	$ vim /etc/init.d/after.local
		添加如下
		redis-server /etc/redis/redis.conf

#### 防火墙：
	1 放行端口
		$ vim /etc/sysconfig/SuSEfirewall2
		--加上端口(多个用空格分开)
		FW_SERVICES_EXT_TCP=”22 80 8090″
	2. 启动、关闭、重启防火墙：
	    $ rcSuSEfirewall2 start/stop/restart

#### 测试连接(新建窗口)
	# redis-cli
	//以上命令将打开以下终端：
	redis 127.0.0.1:6379>
	//输入 PING 命令。
	redis 127.0.0.1:6379>ping
	PONG
	//显示PONG表示成功

#### 远程访问：

进入/etc/redis/,复制default.conf.example并重命名为redis.conf,然后修改如下

    //打开把bind一行 注释掉
    # bind 127.0.0.1
    //开启后台运行
    # daemonize yes
    //关闭保护模式
    # protected-mode no 
    4 地址：ttp://ip:6379/