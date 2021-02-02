---
title: Kafka Connector Mysql 数据同步
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 环境及版本

- linux： ubuntu 18.0.4 lsb

- Jdk: 1.8

- Mysql: 5.7

- Zookeeper:  apache-zookeeper-3.5.8

- Kafka:  kafka_2.12-2.5.0

- Kafka 依赖zookeeper 服务,zookeeper依赖jdk

  

##　一 Kafka基础环境

1. 下载安装

   先配置启动zookeeper

   ```
   > wget https://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.5.8/apache-zookeeper-3.5.8-bin.tar.gz
   > tar -zxf apache-zookeeper-3.5.8-bin.tar.gz
   > cd apache-zookeeper-3.5.8-bin
   > cp conf/zoo_sample.cfg conf/zoo.cfg
   > bin/zkServer.sh start conf/zoo.cfg
   ```

   配置启动kafka

   ```
   > wget https://mirror.bit.edu.cn/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
   > tar -xzf kafka_2.12-2.5.0.tgz
   > cd kafka_2.12-2.5.0
   > bin/kafka-server-start.sh config/server.properties
   ```

   创建查看主题

   ```
   > bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
   > bin/kafka-topics.sh --list --bootstrap-server localhost:9092
   ```

## 二 Kafka Connect

1. 下载依赖包

   下载mysql-connector-java和kafka-connect-jdbc，复制到kafka/libs 路径下

   ```
   wget https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/5.1.0/kafka-connect-jdbc-5.1.0.jar
   // mysql-connector-java 需要和数据库版本匹配(5.x或 8.x) 
   wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.13/mysql-connector-java-8.0.13.jar
   wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.46/mysql-connector-java-5.1.46.jar
   ```

2. 准备数据库

   - 创建 test1 数据库源表t_user_old

     ```
     create table t_user_old(
     uid int(10) primary key auto_increment,
     username varchar(20),
     password varchar(20)
     ) comment '旧用户表';
     ```
     
   - 创建 test2 数据库目标表t_user_new

     ```
     create table t_user_new(
     uid int(10) primary key auto_increment,
     username varchar(20),
     password varchar(20)
     ) comment '新用户表';
     ```

3. 编写配置文件

   - 进入kafka/conf,新建如下两个配置文件：

   - quickstart-mysql.properties（source）

     ```
     name=mysql-a-source-user
     connector.class=io.confluent.connect.jdbc.JdbcSourceConnector
     tasks.max=1
     connection.url=jdbc:mysql://localhost:3306/test1?user=root&password=root
     # incrementing  自增
     mode=incrementing
     # 自增字段 uid
     incrementing.column.name=uid
     # 白名单表 t_user_old
     table.whitelist=t_user_old
     # topic前缀 mysql-kafka-
     topic.prefix=mysql-kafka-
     ```

   - quickstart-mysql-sink.properties（sink）

     ```
     name=mysql-a-sink-user
     connector.class=io.confluent.connect.jdbc.JdbcSinkConnector
     tasks.max=1
     #kafka的topic名称
     topics=mysql-kafka-t_user_old
     # 配置JDBC链接
     connection.url=jdbc:mysql://localhost:3306/test2?user=root&password=root&useSSL=false
     # 不自动创建表，如果为true，会自动创建表，表名为topic名称
     auto.create=false
     # upsert model更新和插入
     insert.mode=upsert
     # 下面两个参数配置了以uid为主键更新
     pk.mode = record_value
     pk.fields = uid
     #表名为 t_user_new
     table.name.format=t_user_new
     ```

4. 启动kafka connect

   - 创建topic主题

     ```
     bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic mysql-kafka-person
     ```

   - 启动 Kafka Connect

     ```
     ./bin/connect-standalone.sh config/connect-standalone.properties config/quickstart-mysql.properties config/quickstart-mysql-sink.properties
     ```

3. 同步数据 

   往a表插入一条数据，b表也会同步更新



参考：

https://www.jianshu.com/p/46b6fa53cae4

https://docs.confluent.io/kafka-connect-jdbc/current/source-connector/source_config_options.html