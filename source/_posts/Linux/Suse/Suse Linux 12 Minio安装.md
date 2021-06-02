---
title: Suse Linux 12 Minio安装
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：
- 系统：SUSE Linux Enterprise Server 12 SP2
- Minio: 

#### 1 下载
	$ wget https://dl.min.io/server/minio/release/linux-amd64/minio
#### 2 赋权
	$ chmod +x minio
#### 3 创建目录并移动
	$ mkdir /use/local/minio
	$ mkdir /use/local/minio/data 
	$ mv minio /use/local/minio
#### 4  启动
	$ cd /use/local/minio
	 -- 启动(data/:数据存放路径)
	$ ./minio server data/
	-- 后台守护启动
	$ nohup ./minio server data/ &
	-- 自定义端口
	$ nohup ./minio server 节点ip:指定端口 data/  &
	-- 开机自启
	$ vim /etc/init.d/after.local
		添加如下
		nohup /usr/local/minio/minio server /usr/local/minio/data/ &
#### 5  防火墙
	1 放行端口
		$ vim /etc/sysconfig/SuSEfirewall2
		--加上端口(多个用逗号分开)
		FW_SERVICES_EXT_TCP=”22,80,8090″
	2. 启动、关闭、重启防火墙：
	    $ rcSuSEfirewall2 start/stop/restart
#### 6 访问：
	http://192.168.116.131:9000/
	AccessKey: minioadmin 
	SecretKey: minioadmin



