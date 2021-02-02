---
title: Ubuntu-Tomcat-War部署
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


一: 环境搭建
1. 安装本地VM 虚拟机
2. 安装Ubuntu 18.0.4
3. 安装JDK 8
```
//命令行直接输入java，根据提示安装即可，建议jdk8
# sudo apt install openjdk-8-jre-headless
```
```
CentOS jdk 安装方法：
//看yum中管理的可用的JDK软件包列表
# yum search java | grep -i --color JDK
//选择要安装的版本
# yum install java-1.8.0-openjdk-devel.x86_64
```

4 配置Tomcat 9:
官网：https://tomcat.apache.org/download-90.cgi
```
//解压
# tar -xf apache-tomcat-8.5.15.tar.gz
//移动tomcat文件到/mnt/tomcat目录下
# sudo mv apache-tomcat-8.5.15 /mnt/tomcat
```

二. 打War包
1. IDEA编写Demo
2. 点击工具栏的project structure（或File->project structure）
3. 左侧选择Artifacts,创建Web Application :Archive ,选择“for 工程名:war exploded”,填写Name和output路径，双击下面两个。保存
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7c03ae9cf4fa8481.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 点击菜单栏build,选择build artifacts,选择该Artifact完成


三. 部署到Ubuntu
1. War包传到Ubuntu
War包放到webapps目录下，不用解压
2. 配置tomcat下的/conf/server.xml(好像不加也可以，自测)
```
//在Host配置段中添加,docBase参数标识的是war包的名称
<Context path="/" docBase="webapp.war" debug="0" privileged="true" reloadable="true"/> 
```
3. 进入tomcat/bin  
```
# ./startup.sh
//启动失败等问题 加下权限
#  chmod 777 *.sh 
```
4. 浏览器浏览
```
//webapp 是war包名称
http://localhost:8080/webapp/index.jsp
```
5. 外部电脑调用
```
//ubuntu查勘ip
# ifconfig
//外部电脑调用地址
http://ip:8080/webapp/index.jsp
```

四，JDK卸载
1 OpenJDK 卸载
```
//可是都试一遍
# sudo apt-get purge openjdk*
# sudo apt-get remove openjdk*
# sudo apt-get autoremove default-jdk
```
