---
title: IDEA-优化指南
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


常用快捷键

```
折叠代码块 Collapse All  
展开代码块 Expand All
转到声明   Go to declaration
提示       Show Intention Actions
类补全     Class Name Completion
格式化代码 Reformat Code
```

配置 JVM 

```
-Xms1024m
-Xmx2048m
-XX:ReservedCodeCacheSize=840m
-XX:+UseConcMarkSweepGC
-XX:SoftRefLRUPolicyMSPerMB=50
```

Mavne settings.xml

```
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  
  <pluginGroups>
  </pluginGroups>

  <proxies>
  </proxies>
  
  <servers>
  </servers>

  <mirrors>  
	 <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
  </mirrors>

  <profiles>    
  </profiles>
</settings>
```

tomcat 控制台乱码

```
打开到tomcat安装目录下的conf/文件夹 修改logging.properties文件，
找到 java.util.logging.ConsoleHandler.encoding = utf-8
更改为 java.util.logging.ConsoleHandler.encoding = GBK
```

