---
title: Ubuntu安装RabbitMQ
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---


一 安装
1 .安装Erlang
```
//
# apt-get install erlang
```
2. 执行下面的命令，新增APT仓库到/etc/apt/sources.list.d/rabbitmq.list
```
echo 'deb http://www.rabbitmq.com/debian/ testing main' |
        sudo tee /etc/apt/sources.list.d/rabbitmq.list
```
3. 更新仓库
```
//
# sudo apt-get update
```
4. 安装Rabbit Server，执行命令
```
# sudo apt-get install rabbitmq-server
//如安装失败，添加公钥到信任列表
# wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
```
二 浏览器访问
1 开启Web管理插件，这样我们就可以通过浏览器来进行管理了
```
//
# rabbitmq-plugins enable rabbitmq_management
```
2. 浏览器访问
//默认用户guest 密码guest
http://localhost:15672/

3. 为远程访问添加用户，guest只能本地访问
```
//新建用户  
# rabbitmqctl add_user <用户名> <密码>
//设定用户administrator角色
# rabbitmqctl set_user_tags <用户名> administrator
//赋予用户权限
# rabbitmqctl set_permission -p / <用户名> ".*" ".*" ".*"
```
```
//查看所有账号
# rabbitmqctl list_users
//修改密码
# rabbitmqctl change_password <用户名> <新密码>
//删除用户
# rabbitmqctl delete_user <用户名>
```
4 启动
```
//关机后重启
#  service rabbitmq-server start
//开机自启
# chkconfig rabbitmq-server on
```
5. 代码连接不上的。进web页面更新下权限
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7f6d294e434307d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

三 卸载
1 卸载软件
```
//
# sudo apt-get remove rabbitmq-server
# sudo dpkg -r rabbitmq-server
```
2. 清理配置文件
```
//
# sudo apt-get remove --purge rabbitmq-server
# sudo dpkg -P rabbitmq-server
```
