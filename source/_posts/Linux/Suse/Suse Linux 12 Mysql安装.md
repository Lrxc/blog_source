---
title: Suse Linux 12 Mysql安装
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：
- 系统：SUSE Linux Enterprise Server 12 SP2
- Mysql:  5.7 or 8
- Repository 教程官网：https://dev.mysql.com/doc/mysql-sles-repo-quick-guide/en/
- RPM 教程官网：https://dev.mysql.com/doc/refman/5.7/en/linux-installation-rpm.html

## 一 使用Repository 方式安装

#### 1 添加MySQL SLES存储库

1. 转到https://dev.mysql.com/downloads/repo/suse/上的MySQL SLES存储库下载页面 。
```
wget https://repo.mysql.com//mysql80-community-release-sles12-3.noarch.rpm
```
2. 选择并下载适用于您的SLES版本的发行包。
3. 使用以下命令安装下载的发行包，并替换 *`package-name`*为下载的包的名称
```
shell> sudo rpm -Uvh package-name.rpm
```
#### 2 导入MySQL GnuPG密钥
	shell> sudo rpm --import /etc/RPM-GPG-KEY-mysql
#### 3 选择发行系列

1. 查看MySQL SLES存储库中的所有子存储库，并查看启用或禁用了哪些子存储库
```
shell> zypper repos | grep mysql.*community
```
1. 默认启用的MySQL 8.0子存储库
```
shell> sudo zypper modifyrepo -d mysql80-community
```
2. 要为MySQL 5.7启用子存储库
```
shell> sudo zypper modifyrepo -e mysql57-community
```
3. 刷新
```
shell> sudo zypper refresh
```
#### 4  使用Zypper安装MySQL
```
shell> sudo zypper install mysql-community-server
```
#### 5 启动MySQL服务器

使用以下命令启动MySQL服务器：
```
shell> sudo service mysql start
//MySQL运行状态
shell> sudo service mysql status
```
查看root默认密码
```
shell> grep 'temporary password' /var/log/mysqld.log
```
登录并修改默认密码
```
shell> mysql -uroot -p
//设置新密码 方式1
shell> mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
//设置新密码 方式2
shell> mysqladmin -u用户名 -p旧密码 password 新密码 
```

#### 6 远程访问：
1. 开放3306端口
```
//其中bind-address = 127.0.0.1注释了
shell> vim /etc/mysql/mysql.conf.d/mysqld.cnf
shell> vim /etc/my.cnf
```
2. 授权用户远程访问
```
//进入mysql命令行(root:root)
shell> mysql> grant all on *.* to root@'%' identified by 'MyNewPass4!';
shell> mysql> flush privileges;
```
3. 重启
```
shell> service mysql restart
```

#### 7 重置密码：

```
#编辑 /etc/my.cnf，添加
[mysqld]
	skip-grant-tables
	
#重启后连接mysql，直接回车即可，不需要输入密码
shell> mysql -u root -p

#更新root用户密码(下面两句执行两遍，第一遍可能报错)
shell> mysql> set password for root@localhost = password('123456');
shell> mysql> flush privileges;

//退出后注释skip-grant-tables，并重启
```



## 二 使用RPM方式安装
1 下载安装包
官网：https://downloads.mysql.com/archives/community/

```
wget https://cdn.mysql.com/archives/mysql-5.7/mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar
```
2 解压
```
mkdir pack
tar -xvf mysql-5.7.28-1.sles12.x86_64.rpm-bundle.tar -C pack
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d0bc999331258ede.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 依次安装(有依赖关系，必须顺序安装)
```
rpm -ivh mysql-community-common-5.7.28-1.sles12.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.28-1.sles12.x86_64.rpm
rpm -ivh mysql-community-client-5.7.28-1.sles12.x86_64.rpm
rpm -ivh mysql-community-server-5.7.28-1.sles12.x86_64.rpm
```
4. 启动

```
service mysql start
# 查看初始root密码
grep 'temporary password' /var/log/mysql/mysqld.log
# 这种方式安装好像没有默认root密码，使用上面的 7.重置密码 吧
```

   