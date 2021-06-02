---
title: Ubuntu ElasticSearch 服务搭建
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />
## 环境

- linux: ubuntu 18.4

- elasticsearch: 6.5.3

- jdk: open jdk 1.8

  ```
  yum install java-11-openjdk -y
  ```
  
  

## 一 服务搭建(压缩包)

1. 下载elastic服务端

   官网下载地址：https://www.elastic.co/cn/downloads/elasticsearch

   ```
   wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.5.3.tar.gz
   tar -xzf elasticsearch-6.5.3.tar.gz
   cd elasticsearch-6.5.3/
   
   # 7.x版本(推荐)
   https://repo.huaweicloud.com/elasticsearch/7.12.0/elasticsearch-7.12.0-linux-x86_64.tar.gz
   ```

2. 配置

   > 需要新建一个非root账号，elastic不支持root账号启动

   ```
   adduser esuser	#新建一个用户(useradd)
   passwd esuser 	#设置密码
   su esuser		#切换用户
   cat /etc/passwd #查看所有用户
   userdel esuser  #删除用户
   
   #赋值es文件夹权限
   chown -R esuser elasticsearch
   ```

   > 外网访问：去掉`network.host`的注释，将它的值改成`0.0.0.0`，然后重新启动 Elastic, 关闭防火墙！！！

   ```
   # vim config/elasticsearch.yml
   network.host: 0.0.0.0
   discovery.type: single-node #单节点模式
   ```

3. 启动服务

   ```
   ./bin/elasticsearch
   ./bin/elasticsearch -d	#后台启动
   ```

4. 测试成功

   ```
   curl localhost:9200
   ```

5. ik分词器

   > 下载后解压到es的plusins路径下，**重启es即可**

   ```
   # 下载
   https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.12.0/elasticsearch-analysis-ik-7.12.0.zip
   # 解压到es的plusins路径下
   unzip elasticsearch-analysis-ik-7.12.0.zip -c plugins/ik
   ```

   ```
   # 重启后，查看es加载的插件
   ./bin/elasticsearch-plugin list
   ```

## 二 服务搭建(Docker)

1. 下载镜像

   ```
   docker pull elasticsearch:6.5.3
   ```

2. 运行容器

   ```
   docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name es elasticsearch:6.5.3
   
   #参数说明
   -d：后台启动
   -p：端口映射
   -e：设置环境变量
   -discovery.type=single-node：单机运行
   --name：要生成的容器名称
   elasticsearch:6.5.3：引用镜像名称和版本
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
   
8. 测试

   ```
   curl localhost:9200
   ```

## 三 可视化界面kibana

1. 下载

   ```
   https://artifacts.elastic.co/downloads/kibana/kibana-7.12.0-linux-x86_64.tar.gz
   ```

2. 配置

   ```
   # vim config/kibana.yml
   server.host: “0.0.0.0”
   ```

3. 汉化（可选）

   ```
   # 中文国际化文件路径
   kibana-7.12.0-linux-x86_64/x-pack/plugins/translations/translations/zh-CN.json
   
   # vim config/kibana.yml
   i18n.locale: "zh-CN"
   ```

4. 启动

   ```
   # 赋值es文件夹权限
   chown -R esuser kibana-7.12.0-linux-x86_64
   # 启动
   ./bin/kibana
   ```

5. 访问

   ```
   localhost:5601
   ```

6. 测试

   > 左侧开发工具中输入，即可验证

   ```
   GET _analyze
   {
    "analyzer": "ik_smart"
    , "text": ["中国人民解放军"]
   }
   
   GET _analyze
   {
    "analyzer": "ik_max_word"
    , "text": ["中国人民解放军"]
   }
   ```

   

## 四 手动增删改查命令(dsl语法)

> dsl: Domain Specific Language 的缩写，中文翻译为领域特定语言

1. sql转dsl

   ```
   POST /_sql/translate
   {
     "query":"select * from complex where name ='张三'"
   }
   ```

2. 信息

   ```
   # 检测集群是否健康。 确保9200端口号可用
   curl 'localhost:9200/_cat/health?v'
   # 获取集群的节点列表
   curl 'localhost:9200/_cat/nodes?v'
   ```

3. 索引

   ```
   # 列出所有索引
   curl 'localhost:9200/_cat/indices?v'
   
   # 创建索引
   curl -XPUT 'localhost:9200/test?pretty'
   # 查看单个索引详情
   curl localhost:9200/test?pretty
   
   #删除索引
   curl -XDELETE 'localhost:9200/test?pretty'
   ```

4. 文档

   ```
   # 新增
   curl -H "Content-Type: application/json" -XPUT 'localhost:9200/test/external/1' -d '{"name": "张三"}'
   # 查询
   curl -XGET 'localhost:9200/test/external/1'
   # 修改
   curl -H "Content-Type: application/json" -XPOST 'localhost:9200/test/external/1/_update' -d '{"doc":{"name":"李四"}}'
   # 删除
   curl -XDELETE 'localhost:9200/test/external/1'
   ```

5. 复杂查询

   ```
   # 插入数据
   curl -H "Content-Type: application/json" -XPUT 'localhost:9200/complex/_doc/1' -d '{"name": "张三1","age":1}'
   curl -H "Content-Type: application/json" -XPUT 'localhost:9200/complex/_doc/2' -d '{"name": "张三2","age":2}'
   curl -H "Content-Type: application/json" -XPUT 'localhost:9200/complex/_doc/3' -d '{"name": "张三3","age":3}'
   
   # 查询全部
   curl -XGET 'localhost:9200/complex/_doc/_search'
   
   # 模糊查询，排序，分页
   GET complex/_doc/_search
   {
    "query":{
      "match":{
        "name":"张三1"
      }
    },
    "sort":{
      "age":{
        "order":"desc"
      }
    },
    "from":0,
    "size":10
   }
   
   # 高亮查询
   GET complex/_doc/_search
   {
     "query":{
       "match":{
         "name":"张三"
       }
     },
     "highlight":{
       "fields":{
         "name":{}
       }
     }
   }
   ```

## 五 常见问题

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

   指定单节点模式即可，解决方案同上

#### 参考：

官方：https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html

http://www.ruanyifeng.com/blog/2017/08/elasticsearch.html

https://www.cnblogs.com/gcgc/p/10297563.html