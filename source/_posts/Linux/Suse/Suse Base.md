---
title: Suse Base
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Suse
tags: [linux,suse]
---


#### 常用命令：
```shell
搜索软件
zypper search/se package

安装软件
zypper install/in package/zypper in package

安装某个版本的软件包
zypper install package=version

安装以某个单词名字开头的所有软件包
zypper install package*

卸载某个软件包
zypper remove package

升级某个软件包
zypper update package

获取所有可用新包的列表
zypper list-updates

检验软件包的依赖关系的完整性
zypper verify package

执行系统升级
zypper dist-upgrade

执行源代码软件安装和其依赖
zypper source-install package.tgz
```

#### 源：

	-- 查看源
	zypper repos/lr 
	-- 查看源配置
	zypper repos --details
	-- 添加源(URL就是软件源的地址,alias就是你起的一个名字)
	zypper addrepo/ar URL alias    
	-- 删除源
	zypper remove/rr 
	-- 禁用原来无效的源
	zypper modifyrepo/mr -d alias
	-- 源仓库配置位于,编辑文件后刷新
	/etc/zypp/repos.d/
	
	-- suse官方源
	zypper ar https://ftp5.gwdg.de/pub/opensuse/discontinued/distribution/12.2/repo/oss/ oss
	zypper ar https://ftp5.gwdg.de/pub/opensuse/discontinued/distribution/12.2/repo/non-oss/ nonoss
	zypper ar http://download.opensuse.org/update/12.2/ update
	
	-- 阿里云：
	zypper ar -f http://mirrors.aliyun.com/opensuse/distribution/openSUSE-stable/repo/oss/ oss
	-- 网易开源镜像
	zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
	
	-- 添加好以后需要先刷新：
	zypper refresh

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
    1. SuSE Linux防火墙配置文件路径：/etc/sysconfig/SuSEfirewall2;
    	开放多个端口则为 FW_SERVICES_EXT_TCP=”22,80,8090″
    2. 启动、重启、关闭、状态：
       rcSuSEfirewall2 start/restart/stop/status
       service SuSEfirewall2 start
       service SuSEfirewall2_init start

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

