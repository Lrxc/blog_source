---
title: Suse安装Kafka、Zookeeper
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Suse
tags: [linux,suse]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：Suse 12.2.2
- Zookeeper: 3.5.5
- Kafka: 
- Kafka 需要zookeeper 服务

#### Zookeeper 配置

1 先启动启动zookeeper

解压后进入conf目录,复制一份zoo_sample.cfg重命名为zoo.cfg

```
//可选：zookeeper默认使用jetty，端口占用8080
admin.serverPort=8888
```

启动服务

```
//kafka自动配置启动
bin/zookeeper-server-start.sh config/zookeeper.properties

//进入bin目录下
# ./zkServer.sh start
//查看状态
# ./zkServer.sh status
```

#### kafka

1 下载kafka

```
> tar -xzf kafka_2.12-2.5.0.tgz
> cd kafka_2.12-2.5.0
```

2 启动服务

配置config/server.properties

```
listeners=PLAINTEXT://ip:9092  #本机的ip地址加9092端口
```

启动

```
> bin/kafka-server-start.sh config/server.properties
```

3 建立主题

//让我们用一个分区和一个副本创建一个名为“ test”的主题：

```
> bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
```
运行list topic命令，则可以看到该主题

```
> bin/kafka-topics.sh --list --bootstrap-server localhost:9092
```

4 发送消息

运行生产者，然后在控制台中键入一些消息以发送到服务器

```
> bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test
This is a message
This is another message
```

5 接受消息

Kafka还有一个命令行使用者，它将消息转储到标准输出

```
> bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning
This is a message
This is another message
```