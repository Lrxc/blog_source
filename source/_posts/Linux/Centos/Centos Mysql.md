---
title: Centos Mysql
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Centos
tags: [linux,centos]
---

<meta name="referrer" content="no-referrer" />


#### 1 添加MySQL SLES存储库

1. 添加Mysql5.7仓库
```
sudo rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
```
2. 确认Mysql仓库成功添加
```
sudo yum repolist all | grep mysql | grep enabled
```
#### 2  使用Zypper安装MySQL
```
sudo yum -y install mysql-community-server
```
#### 3 启动MySQL服务器

使用以下命令启动MySQL服务器：
```
sudo service mysqld start
sudo systemctl start mysqld
```
您可以使用以下命令检查MySQL服务器的状态：	
```
sudo service mysql status
sudo systemctl status mysqld
```
首次启动服务器时，将初始化服务器。'root'@'localhost' 创建 一个超级用户帐户。设置超级用户的密码并将其存储在错误日志文件中。要显示它，请使用以下命令：
```
sudo grep 'temporary password' /var/log/mysqld.log
cat /var/log/mysqld.log | grep -i 'temporary password'
```
通过使用生成的临时密码登录并尽快为超级用户帐户设置自定义密码，以更改root密码：
```
 //登录mysql
shell> mysql -uroot -p
//设置新密码
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```

#### 4  防火墙
1 放行端口
```
$ vim /etc/sysconfig/SuSEfirewall2
//加上端口(多个用逗号分开)
FW_SERVICES_EXT_TCP=”22,80,8090″
```
2. 启动、关闭、重启防火墙
```
$ rcSuSEfirewall2 start/stop/restart
```
#### 5 访问：
1. 授权用户远程访问
```
//进入mysql命令行(root:root)
shell> mysql> grant all on *.* to root@'%' identified by 'root';
flush privileges;
```
2. 重启
```
shell> sudo service mysqld restart
```
3. 配置文件位于
```
vim /etc/my.cnf
```
4.自启动
```
systemctl enable mysqld
```
