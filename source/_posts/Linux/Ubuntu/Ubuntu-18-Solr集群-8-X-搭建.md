---
title: Ubuntu-18-Solr集群-8-X-搭建
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


##安装环境及版本：
- 系统：ubuntu 18.04 LTS
- jdk:  1.8.0
- Tomcat: 9.0.22
- Solr： 8.2.0
- 单机版：https://www.jianshu.com/p/59a3b9d3ba6d

## 一. 官方方式(简单，推荐)
1. 下载压缩包，上传并解压
Solr: https://lucene.apache.org/solr/downloads.html
官方安装教程：https://lucene.apache.org/solr/guide/8_1/solr-tutorial.html
2. 启动(交互式启动)
```
// -force 显示进度
 ./bin/solr -e cloud -force
``` 
这将启动一个交互式会话，引导您完成设置带有嵌入式ZooKeeper的简单SolrCloud集群的步骤。
该脚本首先询问您要在本地群集中运行多少个Solr节点，默认值为2。
```
Welcome to the SolrCloud example!

This interactive session will help you launch a SolrCloud cluster on your local workstation.
To begin, how many Solr nodes would you like to run in your local cluster? (specify 1-4 nodes) [2]
```
该脚本支持最多启动4个节点，但我们建议在启动时使用默认值2。这些节点将分别存在于一台计算机上，但将使用不同的端口来模拟不同服务器上的操作。
接下来，该脚本将提示您将端口绑定到每个Solr节点，例如：
```
Please enter the port for node1 [8983]
```
为每个节点选择任何可用端口; 第一个节点的默认值为8983，第二个节点的默认值为7574。该脚本将按顺序启动每个节点，并显示它用于启动服务器的命令，例如：
```
solr start -cloud -s example/cloud/node1/solr -p 8983
```
第一个节点还将启动绑定到端口9983的嵌入式ZooKeeper服务器。第一个节点的Solr主目录example/cloud/node1/solr位于-s选项所指示的位置。

启动集群中的所有节点后，脚本会提示您输入要创建的集合的名称：
```
Please provide a name for your new collection: [gettingstarted]
```
建议的默认值是“gettingstarted”，但您可能希望选择更适合您的特定搜索应用程序的名称。

接下来，脚本会提示您输入要分配集合的分片数。[分片](https://lucene.apache.org/solr/guide/8_1/shards-and-indexing-data-in-solrcloud.html#shards-and-indexing-data-in-solrcloud)进行更详细的覆盖以后，所以如果您不确定，我们建议使用2默认，这样你可以看到一个集合在SolrCloud集群跨多个节点分布。

接下来，该脚本将提示您为每个分片创建的副本数。 本指南稍后将详细介绍[复制](https://lucene.apache.org/solr/guide/8_1/shards-and-indexing-data-in-solrcloud.html#shards-and-indexing-data-in-solrcloud)，因此如果您不确定，请使用默认值2，以便您可以在SolrCloud中查看复制的处理方式。

最后，该脚本将提示您输入集合的配置目录的名称。您可以选择**_default**或**sample_techproducts_configs**。拉出配置目录，`server/solr/configsets/`以便您可以预先查看它们。当您仍在为文档设计架构时，**_default**配置非常有用，并且在您尝试使用Solr时需要一些灵活性，因为它具有无架构功能。但是，在创建集合之后，可以禁用无模式功能以锁定模式（以便在执行此操作后索引的文档不会更改模式）或自行配置模式。这可以按如下方式完成（假设您的集合名称是`mycollection`）：

3. 常用命令
```
// 删除此集合
bin/solr delete -c techproducts
// 然后创建一个新的集合
bin/solr create -c <yourCollection> -s 2 -rf 2
// 要停止我们启动的两个Solr节点，请发出以下命令
bin/solr stop -all

//重新启动Solr
./bin/solr start -c -p 8983 -s example/cloud/node1/solr -force
//完成后启动第二个节点，并告诉它如何连接到ZooKeeper
./bin/solr start -c -p 7574 -s example/cloud/node2/solr -z localhost:9983 -force
```

## 二. 自定义方式(Zookeeper+Tomcat+Solr)
#### 1. zookeeper集群
1. 上传zookeeper到服务器，解压复制
```
//解压
tar zxvf apache-zookeeper-3.5.5-bin
//复制到自己的路径
cp apache-zookeeper-3.5.5-bin /usr/local/zookeeper/zk1 -r
cp apache-zookeeper-3.5.5-bin /usr/local/zookeeper/zk2 -r
cp apache-zookeeper-3.5.5-bin /usr/local/zookeeper/zk3 -r
```
2 把zookeeper/zk1/conf/zoo_sample.cfg复制一份改为zoo.cfg,并修改
```
 cp zoo_sample.cfg zoo.cfg
 vim zoo.cfg
```
```
//修改data路径
dataDir=/usr/local/zookeeper/zk1/data
//修改端口
clientPort=2181
//可选：zookeeper默认使用jetty，端口占用8080
admin.serverPort=8888
//增加集群配置
server.1=192.168.234.129:2881:3881
server.2=192.168.234.129:2882:3882
server.3=192.168.234.129:2883:3883
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-81ac755c47cc86b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3.在zookeeper/zk1 目录下新建data文件夹，并新建文件myid，内容分别对应为zookeeper的编号(1,2,3)
```
cd data/
echo 1 >> myid
```
4. 分别启动即可
![image.png](https://upload-images.jianshu.io/upload_images/2803682-0e7d1f7a0dc63534.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2. solr集群
1. 首先搭建单机版，并测试通过
https://www.jianshu.com/p/59a3b9d3ba6d
2. 复制四份solr的tomcat，每个tomcat都是单机版的solr
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6793cc73ffaa817e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
**以下修改，四个solr的tomcat文件都要同步修改**
3. 修改tomcat/binserver.xml的端口，分别为60** ,70** ,80** ,90**
```
//第一处
<Server port="8005" shutdown="SHUTDOWN">
//第二处
<Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
//第三处
<Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
```
4. 修改tomcat*/webapps/solr/WEB-INF/web.xml的 标签<env-entry>
```
 # 这个路径对应上面的solrhome全路径(tomcat1,tomcat2,tomcat3,tomcat4)
<env-entry-value>/usr/local/solr-cloud/tomcat1/solrhome</env-entry-value>
```
5. 修改solrhorm下的solr.xml
```
//分别对应步骤3的端口(6080,7080,8080,9080)
<int name="hostPort">${jetty.port:9080}</int>
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d645614c6c043b87.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
6. 修改每一台solr的tomcat 的 bin目录下catalina.sh文件中加入DzkHost指定zookeeper服务器地址：
```
JAVA_OPTS="-DzkHost=192.168.234.129:2181,192.168.234.129:2182,192.168.234.129:2183"
```
7. 启动四个tomat
浏览器访问：http://ip:8080/solr/index.html
![image.png](https://upload-images.jianshu.io/upload_images/2803682-8e10db404571ddee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 3 新建collections/core核心
1. 新建索引，会报错
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2281941aafea8eb9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 打开solr原始目录（solr安装包解压后的目录），找到 /server/scripts/cloud-scripts/zkcli.sh，使用这个脚本来上传core配置到zookeeper，命令如下：
```
//-zkhost：后面是zookeeper的地址， -cmd upconfig：上传命令
// -confdir：上传文件的路径 -confname myconf：上传后的名称
./zkcli.sh -zkhost 192.168.234.129:2181,192.168.234.129:2182,192.168.234.129:2183 -cmd upconfig -confdir /home/lrxc/solr-8.2.0/server/solr/configsets/_default/conf -confname myconf
```
3. 再次创建即可
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c714a638593c06dd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Java连接代码
```
	// solr的core名称(索引库)
	final String collection = "gettingstarted";
        // 添加数据
	@Test
	public void add() throws Exception {
		// 创建客户端
		List<String> solrUrls = new ArrayList<String>();
		solrUrls.add("http://192.168.234.128:8983/solr");
		solrUrls.add("http://192.168.234.128:8983/solr");
		CloudSolrClient client = new CloudSolrClient.Builder(solrUrls).withConnectionTimeout(10000)
				.withSocketTimeout(60000).build();

		// 添加数据
		final SolrInputDocument doc = new SolrInputDocument();
		doc.addField("id", UUID.randomUUID().toString());
		doc.addField("name", "我是测试数据");

		// 保存并提交
		client.add(collection, doc);
		client.commit(collection);
	}

	// 查询数据
	@Test
	public void query() throws Exception {
		// 创建客户端
		List<String> solrUrls = new ArrayList<String>();
		solrUrls.add("http://192.168.234.128:8983/solr");
		solrUrls.add("http://192.168.234.128:7574/solr/");
		CloudSolrClient client = new CloudSolrClient.Builder(solrUrls).build();

		// 查询条件
		final Map<String, String> queryParamMap = new HashMap<String, String>();
		queryParamMap.put("q", "*:*");
//		queryParamMap.put("fl", "id, name");
//		queryParamMap.put("sort", "id asc");
		MapSolrParams queryParams = new MapSolrParams(queryParamMap);

		// 获取结果
		final QueryResponse response = client.query(collection, queryParams);
		final SolrDocumentList documents = response.getResults();

		for (SolrDocument document : documents) {
			System.out.println(document.getFirstValue("id"));
			System.out.println(document.getFirstValue("name"));
		}
	}
```

附录：
参考文章：https://oumuv.github.io/2018/11/28/solr-2/
