---
title: Ubuntu ElactisSearch 服务搭建
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


## 环境

- linux: ubuntu 18.4

- elactissearch: 6.5.3

- jdk: open jdk 1.8

  

## 一 服务搭建(压缩包)

1. 下载elastic服务端

   官网下载地址：https://www.elastic.co/cn/downloads/elasticsearch

   ```
   wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.5.3.tar.gz
   tar -xzf elasticsearch-6.5.3.tar.gz
   cd elasticsearch-6.5.3/
   ```

2. 启动服务

   需要新建一个非root账号，elastic不支持root账号启动(参照后面常见问题2)

   ```
   ./bin/elasticsearch
   ./bin/elasticsearch -d	#后台启动
   ```

3. 测试成功

   ```
   curl localhost:9200
   ```

   ![image-20201208160806130.png](https://upload-images.jianshu.io/upload_images/2803682-22bd43d5658897fc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 二 服务搭建(Docker)

1. 下载镜像

   ```
   docker pull elasticsearch:6.5.3
   ```

2. 运行容器

   ```
   docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name elasticsearch-6.5.3 elasticsearch:6.5.3
   ```

3. 进入容器

   ```
   docker exec -it elasticsearch-6.5.3 /bin/bash
   ```

4. 安装ik分词器

   ```
   ./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v6.5.3/elasticsearch-analysis-ik-6.5.3.zip
   ```

5. 修改es配置文件：vim ./config/elasticsearch.yml

   ```
   cluster.name: "docker-cluster"
   network.host: 0.0.0.0
   
   # minimum_master_nodes need to be explicitly set when bound on a public IP
   # set to 1 to allow single node clusters
   # Details: https://github.com/elastic/elasticsearch/pull/17288
   discovery.zen.minimum_master_nodes: 1
   
   # just for elasticsearch-head plugin
   http.cors.enabled: true
   http.cors.allow-origin: "*"
   ```

6. 退出容器

   ```
   exit
   ```

7. 重启容器

   ```
   #先停止
   docker stop elasticsearch-6.5.3
   docker start elasticsearch-6.5.3
   ```

## 三 手动增删改查命令

1. 检测集群是否健康。 确保9200端口号可用

   ```
   curl 'localhost:9200/_cat/health?v'
   ```

2. 获取集群的节点列表

   ```
   curl 'localhost:9200/_cat/nodes?v'
   ```

3. 列出所有索引

   ```
   curl 'localhost:9200/_cat/indices?v'
   ```

4. 创建索引

   ```
   curl -XPUT 'localhost:9200/test?pretty'
   #查看索引详情
   curl localhost:9200/test?pretty
   ```

5. 插入和获取

   ```
   # 插入数据指定id为1
   curl -H "Content-Type: application/json" -XPUT 'localhost:9200/test/external/1?pretty' -d '{"name": "hello world"}'
   # 获取customer索引下类型为external，id为1的数据
   curl -XGET 'localhost:9200/test/external/1?pretty'
   ```

6. 删除索引 DELETE

   ```
   curl -XDELETE 'localhost:9200/test?pretty'
   curl 'localhost:9200/_cat/indices?v'
   ```

## 四 常见问题

1. 默认情况下，Elastic 只允许本机访问，如果需要远程访问，可以修改 Elastic 安装目录的`config/elasticsearch.yml`文件，去掉`network.host`的注释，将它的值改成`0.0.0.0`，然后重新启动 Elastic

   ```
   network.host: 0.0.0.0
   discovery.type: single-node
   ```

   关闭防火墙！！！

2. 不允许root启动

   ```
   useradd esuser	#新建一个用户
   passwd esuser 	#设置密码
   su esuser		#切换用户
   
   #赋值es文件夹权限
   chown -R esuser elasticsearch-6.5.3
   ```

3. Native controller process has stopped - no new native processes can be started

   - 压缩包形式

     ```
     vim ./config/elasticsearch.yml
     # 指定单节点模式
     discovery.type: single-node
     ```

   - docker形式

     ```
     运行时添加 -e "discovery.type=single-node"
     docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name elasticsearch-6.5.3 elasticsearch:6.5.3
     ```

4. max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

   指定单节点模式即可，解决方案同上3

#### 参考：

官方：https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html

http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html

https://www.cnblogs.com/gcgc/p/10297563.html