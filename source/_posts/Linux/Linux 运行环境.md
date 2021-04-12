---
title: Linux 运行环境
date: 2018-07-01 16:01:33
categories: 
- Linux 
- Linux
tags: [linux,linux]
---

<meta name="referrer" content="no-referrer" />


####  Java Jdk
修改 /etc/profile 文件
```shell
#PATH 环境变量：作用是指定命令搜索路径
#CLASSPATH 环境变量：作用是指定类搜索路径
#JAVA_HOME 环境变量：它指向 jdk 的安装目录
export JAVA_HOME=/usr/local/jdk1.8.0_14
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

#### Adb