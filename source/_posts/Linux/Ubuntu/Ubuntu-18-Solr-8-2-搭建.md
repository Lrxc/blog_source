---
title: Ubuntu-18-Solr-8-2-搭建
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
- 集群版：https://www.jianshu.com/p/91e6e4cc111d

## 一. 官方方式(推荐)
1. 下载压缩包，上传并解压
Solr: https://lucene.apache.org/solr/downloads.html
官方安装教程：https://lucene.apache.org/solr/guide/8_1/installing-solr.html
2. 启动
```
// -force 显示进度
bin/solr start -force
``` 
![image.png](https://upload-images.jianshu.io/upload_images/2803682-b99f655da01ee7ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. 创建核心
```
bin/solr create -c <name>
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-aba83c383a8f5e30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1ba0564ae9ca7025.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 一. Solr+Tomcat
1 下载压缩包
tomcat :https://tomcat.apache.org/download-90.cgi
Solr: https://lucene.apache.org/solr/downloads.html
2. 上传至服务器并解压
```
tar zxvf apache-tomcat-9.0.22.tar.gz
tar zxvf solr-8.2.0.tgz
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-199c556af37e6c3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3. tomcat复制到/usr/local目录下
```
cp apache-tomcat-9.0.22 /usr/local/tomcat -r
```
4. 把solr的web项目复制到tomcat的webapps下
```
//进入到solr的web项目下
cd solr-8.2.0/server/solr-webapp
//复制并重命名
cp webapp/ /usr/local/tomcat/webapps/solr -r
```
5. 复制对应jar包到tomcat/webapps/solr/WEB-INF/lib/
- solr-8.2.0/server/lib/ext 下所有jar包
- solr-8.2.0/server/lib 下metrics开头的jar包
```
// * 代表所有
cp *.jar /usr/local/tomcat/webapps/solr/WEB-INF/lib/
cp metrics-*.jar /usr/local/tomcat/webapps/solr/WEB-INF/lib/
```
6. 复制solr-8.2.0/server下的solr文件夹，到tomcat目录下solrhome 
```
cp solr /usr/local/tomcat/solrhome -r
```
7. 编辑tomcat/webapps/solr/WEB-INF/web.xml
这段手动加上
```
  <env-entry>
     <env-entry-name>solr/home</env-entry-name>
     <!--这个路径对应上面的solrhome全路径-->
     <env-entry-value>/usr/local/tomcat/solrhome</env-entry-value>
     <env-entry-type>java.lang.String</env-entry-type>
  </env-entry>
```
这段手动注释掉
```
  <security-constraint>
    <web-resource-collection>
      <web-resource-name>Disable TRACE</web-resource-name>
      <url-pattern>/</url-pattern>
      <http-method>TRACE</http-method>
    </web-resource-collection>
    <auth-constraint/>
  </security-constraint>
  <security-constraint>
    <web-resource-collection>
      <web-resource-name>Enable everything but TRACE</web-resource-name>
      <url-pattern>/</url-pattern>
      <http-method-omission>TRACE</http-method-omission>
    </web-resource-collection>
  </security-constraint>
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d915e35e69944b33.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-11ca1d1575bacb9a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
8. 启动 
```
./tomcat/bin/startup.sh
```
浏览器访问：http://ip:8080/solr/index.html
浏览器界面没相应的，换个浏览器试试
![image.png](https://upload-images.jianshu.io/upload_images/2803682-47e08b9978e2ff65.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
##二. 中文分词
1. 下载jar和文件：https://github.com/magese/ik-analyzer-solr
2. 将jar包放入Solr服务的Jetty或Tomcat的webapp/WEB-INF/lib/目录下；
3. 将resources目录下的5个配置文件放入solr服务的Jetty或Tomcat的webapp/WEB-INF/classes/目录下；
```
- IKAnalyzer.cfg.xml
- ext.dic
- stopword.dic
- ik.conf
- dynamicdic.txt
```
4. 配置solrhome/new_core/conf的managed-schema，添加ik分词器，示例如下；
```
<!-- ik分词器 -->
<fieldType name="text_ik" class="solr.TextField">
  <analyzer type="index">
      <tokenizer class="org.wltea.analyzer.lucene.IKTokenizerFactory" useSmart="false" conf="ik.conf"/>
      <filter class="solr.LowerCaseFilterFactory"/>
  </analyzer>
  <analyzer type="query">
      <tokenizer class="org.wltea.analyzer.lucene.IKTokenizerFactory" useSmart="true" conf="ik.conf"/>
      <filter class="solr.LowerCaseFilterFactory"/>
  </analyzer>
</fieldType>
```
官方安装方式的，修改路径为：solr/server/solr/configsets/_default/conf，然后还需要重新建立collection才行。
5. 重启服务器
![image.png](https://upload-images.jianshu.io/upload_images/2803682-a29a55417c714e29.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##三 问题解决：
1 Can't find resource 'schema.xml' in classpath or '/usr/local/tomcat/solrhome/new_core'
![image.png](https://upload-images.jianshu.io/upload_images/2803682-b5b6edc488bc6af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
解决方法：先复制，然后重启tomcat
```
cp solr-8.2.0/server/solr/configsets/_default/conf /usr/local/tomcat/solrhome/new_core/ -r
```

## Java代码
```
        // solr的core名称(索引库)
	final String collection = "gettingstarted";

	// 添加数据
	@Test
	public void add() throws Exception {
		// 创建客户端
		HttpSolrClient client = new HttpSolrClient.Builder("http://192.168.234.128:8983/solr/").build();

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
		HttpSolrClient client = new HttpSolrClient.Builder("http://192.168.234.128:8983/solr/").build();

		// 查询条件
		final Map<String, String> queryParamMap = new HashMap<String, String>();
		queryParamMap.put("q", "*:*");
		queryParamMap.put("fl", "id, name");
		queryParamMap.put("sort", "id asc");
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
