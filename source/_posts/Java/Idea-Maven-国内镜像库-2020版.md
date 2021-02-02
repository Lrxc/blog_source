---
title: Idea-Maven-国内镜像库-2020版
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


#### 使用

- ./conf/settings.xml，在<mirrors>标签中添加 mirror 子节点
- 目前网上多为使用阿里云的教程，导致阿里的速度越来越慢，最好测试下自己区域哪个速度快。测试速度比较推荐华为云

#### 阿里云

```
<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```
#### 华为云

```
<mirror>
    <id>huaweicloud</id>
    <mirrorOf>*</mirrorOf>
    <url>https://mirrors.huaweicloud.com/repository/maven/</url>
</mirror>
```
#### 网易云

```
<mirror>
    <id>nexus-163</id>
    <mirrorOf>*</mirrorOf>
    <name>Nexus 163</name>
    <url>http://mirrors.163.com/maven/repository/maven-public/</url>
</mirror>
```
#### 腾讯云

```
<mirror>
    <id>nexus-tencentyun</id>
    <mirrorOf>*</mirrorOf>
    <name>Nexus tencentyun</name>
    <url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
</mirror> 
```



#### 完整配置如下

```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <mirrors>  
    <mirror>
        <id>huaweicloud</id>
        <mirrorOf>*</mirrorOf>
        <url>https://mirrors.huaweicloud.com/repository/maven/</url>
    </mirror>
  </mirrors>
</settings>
```

