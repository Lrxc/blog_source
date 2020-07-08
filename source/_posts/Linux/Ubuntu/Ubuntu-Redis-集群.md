---
title: Ubuntu-Redis-集群
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Ubuntu
tags: [linux,ubuntu]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：ubuntu 18.04 LTS
- Redis： redis-5.0.5
- 配置说明：六个节点，三主三从

##一 安装Redis
1. 编译命令
```
//gcc编译器 -y默认所有提示选是
# apt install gcc -y
//make 命令
# apt install make
```
2.下载并解压
```
//找个目录存放临时文件
# cd /usr/local/tmp
//下载
# wget http://download.redis.io/releases/redis-5.0.5.tar.gz
//解压
# tar -zxvf redis-5.0.5.tar.gz 
# cd redis-5.0.5
//编译 
# make //若报错Entering directory xxx，使用make MALLOC=libc
//安装  PREFIX后跟安装路径
# make install PREFIX=/usr/local/redis-cluster/redis1
```
3. 启动
```
//进入安装路径的bin下
# cd /usr/local/redis-cluster/redis1/bin
//启动
# ./redis-server $   // $表示后台启动
```
## 二 搭建集群
1. 复制源码目录的redis.conf到安装目录下
```
# cp /usr/local/tmp/redis-5.0.5/redis.conf /usr/local/redis-cluster/redis1
```
2. 编辑redis.conf
```
//外网访问
# bind 127.0.0.1
//更改端口
# port 9001
//开启集群模式
# cluster-enabled yes
//后台启动
# daemonize yes
//关闭保护模式
# protected-mode no 
```
3. 测试单个redis启动
```
//进入安装路径的bin下
# cd /usr/local/redis-cluster/redis1/bin
//启动
# ./redis-server $   // $表示后台启动
```
4. 复制多份redis文件,并修改端口
```
//进入安装目录下
# cd /usr/local/redis-cluster
//开始复制
# cp redis1 redis2
# cp redis1 redis3
# cp redis1 redis4
# cp redis1 redis5
# cp redis1 redis6
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-342c4d1efce6499b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
分别修改bin目录下redis.conf的port为 9001,9002,9003,9004,9005,9006
```
5. 启动、关闭脚本
新建文件 **vim start.sh**
```
#一键开启所有的redis集群
 
cd /usr/local/redis-cluster/redis1/bin
./redis-server ./redis.conf
cd /usr/local/redis-cluster/redis2/bin
./redis-server ./redis.conf
cd /usr/local/redis-cluster/redis3/bin
./redis-server ./redis.conf
cd /usr/local/redis-cluster/redis4/bin
./redis-server ./redis.conf
cd /usr/local/redis-cluster/redis5/bin
./redis-server ./redis.conf
cd /usr/local/redis-cluster/redis6/bin
./redis-server ./redis.conf
```
新建文件 **vim stop.sh**
```
#一键关闭所有redis集群
 
cd /usr/local/redis-cluster/redis1/bin
./redis-cli -h 127.0.0.1 -p 9001 shutdown
cd /usr/local/redis-cluster/redis2/bin
./redis-cli -h 127.0.0.1 -p 9002 shutdown
cd /usr/local/redis-cluster/redis3/bin
./redis-cli -h 127.0.0.1 -p 9003 shutdown
cd /usr/local/redis-cluster/redis4/bin
./redis-cli -h 127.0.0.1 -p 9004 shutdown 
cd /usr/local/redis-cluster/redis5/bin
./redis-cli -h 127.0.0.1 -p 9005 shutdown
cd /usr/local/redis-cluster/redis6/bin
./redis-cli -h 127.0.0.1 -p 9006 shutdown
```
**对文件赋执行权限**
```
# chmod 777 start.sh
# chmod 777 stop.sh
```
6. 启动集群
```
//启动脚本
# sh start.sh
//查看redis进程
# ps -ef|grep redis
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-818952811d8a2fe4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以看到全部启动成功
7. 查看集群状态
```
//任意一个redis的bin目录下,启动客户端
# cd redis1/bin 
//启动客户端 -c 是指集群模式启动
# ./redis-cli -c -p 9001
//集群信息
# cluster info
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-aa2943391618b042.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
可以看到失败了。。。继续
8 关联集群
```
//任意一个redis的bin目录下,启动客户端
# cd redis1/bin
//此处一定要使用真实ip地址，不用使用127.0.0.1:9001  这种
# ./redis-cli --cluster create 192.168.234.128:9001 192.168.234.128:9002 192.168.234.128:9003 192.168.234.128:9004 192.168.234.128:9005 192.168.234.128:9006 --cluster-replicas 1
```
说明：5.0以后/redis-trib.rb方式已经不支持，改用redis-cli
9. 再次查看集群状态
```
# ./redis1/bin/redis-cli -c -p 9001
# cluster info
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ca50048cd32dc6de.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
