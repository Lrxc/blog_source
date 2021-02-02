---
title: Suse Linux 12 安装Kafka Zookeeper
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 安装环境及版本：

- 系统：Suse 12.2.2
- Jdk: 1.8
- Zookeeper:  apache-zookeeper-3.5.8
- Kafka:  kafka_2.12-2.5.0
- Kafka 依赖zookeeper 服务,zookeeper依赖jdk

## 一 Zookeeper 配置

1. 下载zookeeper

   官网：https://zookeeper.apache.org/releases.html

   ```
   > wget https://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.5.8/apache-zookeeper-3.5.8-bin.tar.gz
   > tar -zxvf apache-zookeeper-3.5.8-bin.tar.gz
   > cd apache-zookeeper-3.5.8-bin
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

4. 使用kafka 配置启动zookeeper(可选)

   ```
   //复制zookeeper到kafka路径下，并重命名为zk
   > cp apache-zookeeper-3.5.8-bin/ kafka_2.12-2.5.0/zk -r
   //使用kafka的配置启动
   > cd kafka_2.12-2.5.0
   > bin/zookeeper-server-start.sh config/zookeeper.properties
   ```

## 二 kafka 配置

1. 下载kafka

   官网：https://kafka.apache.org/downloads

   ```
   > wget https://mirror.bit.edu.cn/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
   > tar -xzf kafka_2.12-2.5.0.tgz
   > cd kafka_2.12-2.5.0
   ```

2. 配置

   配置config/server.properties

   ```
   #打开注释 PLAINTEXT:本机的ip地址:9092
   listeners=PLAINTEXT://192.168.1.100:9092 
   ```

2. 启动
   
```
   > bin/kafka-server-start.sh config/server.properties
```

## 三 发送消息

1. 建立主题

   用一个分区和一个副本创建一个名为“ test”的主题：

   ```
   > bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
   ```

   运行list topic命令，则可以看到该主题

   ```
   > bin/kafka-topics.sh --list --bootstrap-server localhost:9092
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

   