---
title: Ubuntu安装Zookeeper
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---


##安装环境及版本：
- 系统：Ubuntu 18.0.4
- Zookeeper: 3.5.5
##一 安装
1 下载zookeeper，选择带bin的这个 
官网：http://apache.mirrors.ionfish.org/zookeeper/zookeeper-3.5.5/
![image.png](https://upload-images.jianshu.io/upload_images/2803682-a6d314691be883ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 上传至Ubuntu
3 配置
```
//解压后进入conf目录,复制一份zoo_sample.cfg重命名为zoo.cfg,编辑
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/usr/local/zookeeper/data
clientPort=2181
//可选：zookeeper默认使用jetty，端口占用8080
admin.serverPort=8888
```
##二  启动
```
//进入bin目录下
# ./zkServer.sh start

//查看状态
# ./zkServer.sh status
//停止
# ./zkServer.sh stop
```
出现started.代表成功
![image.png](https://upload-images.jianshu.io/upload_images/2803682-442f2691e917daf6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##三 开机自启(可选)
配置如下：https://www.jianshu.com/p/c59cdf58726a

##四 外网访问
1. 下载可视化工具[zooinspector](https://issues.apache.org/jira/secure/attachment/12436620/ZooInspector.zip)
2. 解压进入到ZooInspector\build 目录,cmd命令运行
```
java -jar zookeeper-dev-ZooInspector.jar
```
3. 连接zookeeper
![image.png](https://upload-images.jianshu.io/upload_images/2803682-06edc2697b05568c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
连接成功
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c911df45b179afbf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
