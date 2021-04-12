---
title: Ubuntu-MySql-远程访问
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />
## 环境及版本

- linux： ubuntu 18.0.4 lsb
- mysql:   5.7.x || 8.x



## 一 安装5.7.x(默认源)

1. 安装命令

   ```
   # 更新源
   sudo apt update
   # 安装
   sudo apt install mysql-server
   # 查看是否安装成功
   sudo service mysql status
   ```

2. 修改用户密码（可选）

   ```
   #修改配置文件
   sudo vim /etc/mysql/debian.cnf
   #修改后重启
   sudo service mysql restart
   ```

3. 外网访问

   - 开放远程访问端口

     ```
     #其中bind-address = 127.0.0.1注释掉
     sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
     ```

   - 授权用户远程访问

     ```
     #进入mysql命令行，密码随便输一个就能进入(root:root)
     sudo mysql -uroot -proot
     #授权远程用户 root 和密码 root
     mysql> grant all on *.* to root@'%' identified by 'root';
     mysql> flush privileges;
     ```

   - 重启服务

     ```
     sudo service mysql restart
     ```
## 二 安装8.x

1. 下载源配置文件

   ```
   wget -c https://repo.mysql.com//mysql-apt-config_0.8.16-1_all.deb
   wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb 
   ```

2. 安装源

   ```
   sudo dpkg -i mysql-apt-config_0.8.16-1_all.deb
   sudo apt update
   ```

3. 安装软件

   ```
   sudo apt-get install mysql-server
   ```

4. 修改密码

   ```
   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '你的密码';  
   ```

5. 远程访问

      ```
      USE mysql;
      CREATE USER 'user'@'localhost' IDENTIFIED BY 'Password';
      GRANT ALL ON *.* TO 'user'@'localhost';
      FLUSH PRIVILEGES;
      ```

## 三 Docker 安装

1. 镜像地址

   https://hub.docker.com/_/mysql?tab=tags&page=1&ordering=last_updated

2. 拉取镜像

   ```
   docker pull mysql:5.7
   docker pull mysql:8.0
   ```

3. 运行容器

   ```
   //默认密码123456
   docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7
   ```

4. 进入mysql

   ```
   mysql -uroot -p
   ```

## 四 完全删除

1  删除mysql
```
# sudo apt-get remove --purge mysql-\*
```
2 查找剩余文件
```
# sudo find  / -name mysql -print
```
3 手动删除残留
```
# sudo    rm   -rf     /ect/init.d/mysql
```
