---
title: Suse Rabbitmq
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Suse
tags: [linux,suse]
---


#### RabbitMQ安装：
	-- 添加源
	zypper ar -f http://mirrors.163.com/openSUSE/distribution/openSUSE-stable/repo/oss/ oss
	--更新
	zypper refresh
	-- 安装
	zypper in rabbitmq-server
	zypper in rabbitmq-server-plugins

#### 配置防火墙
	1 放行端口
		$ vim /etc/sysconfig/SuSEfirewall2
		--加上端口(多个用逗号分开)
		FW_SERVICES_EXT_TCP=”22,80,8090″
	2. 启动、关闭、重启防火墙：
	    $ rcSuSEfirewall2 start/stop/restart

#### 远程访问：默认账号guest只能本地访问
	//新建用户  
	# rabbitmqctl add_user <用户名> <密码>
	//设定用户administrator角色
	# rabbitmqctl set_user_tags <用户名> administrator
	//赋予用户权限
	# rabbitmqctl set_permissions -p / <用户名> ".*" ".*" ".*"	


	//查看所有账号
	# rabbitmqctl list_users
	//修改密码
	# rabbitmqctl change_password <用户名> <新密码>
	//删除用户
	# rabbitmqctl delete_user <用户名>

#### 浏览器访问：
	1 开启Web管理插件，这样我们就可以通过浏览器来进行管理了
		$ rabbitmq-plugins enable rabbitmq_management
	2 启动
		$ service rabbitmq-server start
		$ rabbitmq-server -detached //后台启动
		$ rabbitmqctl start_app/stop/status  //运行状态
	3 开机自启
		$ chkconfig rabbitmq-server on
		$ systemctl enable rabbitmq-server
	4 地址
		http://ip:15672/

#### 方式二：

官网：https://www.rabbitmq.com/install-rpm.html

#### 先安装Erlang:
    1 add resp 参数-f：自动刷新
    	$ sudo zypper ar -f http://download.opensuse.org/repositories/devel:/languages:/erlang:/Factory/SLE_12_SP2/ erlang
    2 import the signing key and refresh the repository
    	$ sudo zypper --gpg-auto-import-keys refresh
    3 install a recent Erlang version
    	$ sudo zypper in erlang

#### RabbitMQ：
    1:quick install，过程中选：是
    	$ curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
    2：install
    	$ zypper in rabbitmq-server
    3：没有什么能提供 epmd >= 21.3，而它为 rabbitmq-server-3.8.3-1.suse.noarch 所需
        选择第二项：忽略
    4：剩余选择默认
#### 卸载

```shell
//顺序执行
rpm -e rabbitmq-server
rpm -e rabbitmq-server-plugins
```

