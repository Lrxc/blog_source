---
title: Suse Linux 12 安装Kafka Zookeeper
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,kafka,zookeeper]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：Suse 12.2.2
- Jdk: 1.8
- Zookeeper:  apache-zookeeper-3.7.0
- Kafka:  kafka_2.12-2.6.1
- Kafka 依赖zookeeper 服务,zookeeper依赖jdk

## 一 Zookeeper 配置（推荐使用kafka自带zookeeper）

1. 下载zookeeper

   官网：https://zookeeper.apache.org/releases.html

   ```
   > wget https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz
   > tar -zxvf apache-zookeeper-3.7.0-bin.tar.gz
   > cd apache-zookeeper-3.7.0-bin
   ```

2. 配置zookeeper

   ```
//进入conf路径,复制zoo_sample.cfg重命名为zoo.cfg
   > cp conf/zoo_sample.cfg conf/zoo.cfg
   //zookeeper默认使用jetty，端口占用8080(可选)
   admin.serverPort=8888
   ```

3. 启动服务

   ```
   //启动并指定配置文件
   > bin/zkServer.sh start conf/zoo.cfg
   //查看状态
   > bin/zkServer.sh status
   ```


## 二 kafka 配置

1. 下载kafka

   官网：https://kafka.apache.org/downloads

   ```
   > wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.6.2/kafka_2.12-2.6.2.tgz
   > tar -xzf kafka_2.12-2.6.1.tgz
   > cd kafka_2.12-2.6.1
   ```

2. 外网访问

   配置config/server.properties

   ```
   #打开注释 PLAINTEXT:本机的ip地址:9092
   listeners=PLAINTEXT://192.168.1.100:9092 
   
   # zookeeper地址
   zookeeper.connect=localhost:2181
   ```

2. 启动
   
   先启动zookeeper(若使用上面的zookeeper服务，则不需要再次启动)
   
   ```
   ./bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
   #查看zk服务
   ps -ef|grep zookeeper
   ```
   
   启动kafka
   
   ```
   ./bin/kafka-server-start.sh config/server.properties
   #后台启动
   ./bin/kafka-server-start.sh -daemon config/server.properties
   ```
## 三 发送消息

1. 建立主题

   用一个分区和一个副本创建一个名为“ test”的主题：

   ```
   > bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
   
	# 错误：could not be established. Broker may not be available
   --将 localhost 改为指定 确定的ip
	```
   
   运行list topic命令，则可以看到该主题
   
   ```
   # 所有topic
   > bin/kafka-topics.sh --list --bootstrap-server localhost:9092
   
   # 查看指定topic的详情
   > bin/kafka-topics.sh --describe --bootstrap-server 192.168.50.129:9092 --topic test
   ```


2. 发送消息

   运行生产者，然后在控制台中键入一些消息以发送到服务器

   ```
   > bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test
   This is a message
   This is another message
   ```

3. 接受消息(新建窗口)

   Kafka还有一个命令行使用者，它将消息转储到标准输出

   ```
   > bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
   This is a message
   This is another message
   ```


## 四 kafka manager 可视化界面

1. 浏览器版本

   官网：https://github.com/yahoo/CMAK

   新版本必须java11才支持

   - 配置

     ```
     kafka-manager.zkhosts="kafka-manager-zookeeper:2181"
     #kafka-manager.zkhosts=${?ZK_HOSTS}
     kafka-manager.zkhosts="192.168.50.129:9092"
     cmak.zkhosts="kafka-manager-zookeeper:2181"
     #cmak.zkhosts=${?ZK_HOSTS}
     cmak.zkhosts="192.168.50.129:2181"
     ```

   - 启动

     ```
     ./bin/cmak
     ```

   - 页面

     ```
     1. add cluster
     2. Cluster Zookeeper Hosts(zookeeper地址)
     3. 其他默认
     4. 保存
     
     浏览器访问： ip:9000
     ```

2. 桌面客户端

   kafka tool：https://www.kafkatool.com/download.html

   显示字符串信息
   
   ```
   # 显示topic的信息
   tools--settings--topics--key/value -- 改为string类型
   ```
   
   