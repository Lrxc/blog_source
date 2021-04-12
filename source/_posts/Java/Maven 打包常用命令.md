---
title: Maven 打包常用命令
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


## maven command

1. 打包

```
mvn clean package
```

2. 打包跳过测试

```
mvn clean package -Dspring.test.spip=true
```

3. 打包指定环境

```
# 默认使用配置
spring:
  profiles:
    active:  ${spring.profiles.active}
```

maven 打包

```
mvn clean package -Pdev
```

启动jar指定环境

```
java -jar my.jar --spring.profiles.active=dev
```

