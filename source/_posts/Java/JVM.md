---
title: JVM
date: 2019-07-01 16:01:33
categories: Java
tags: java
---


## 常用命令
1. **jps**

显示当前所有java进程pid的命令，我们可以通过这个命令来查看到底启动了几个java进程

```java
jps    //显示当前所有java进程pid的命令
jps -l //jps -l 输出应用程序main.class的完整package名或者应用程序jar文件完整路径名
jps -v //输出传递给JVM的参数
```

2. **jstat**

对java应用程序的资源和性能进行实时的命令行监控，包括了对heap size和垃圾回收状况的监控

格式：

```java
jstat -<option> [-t] [-h<lines>] <vmid> [<interval> [<count>]]
option：我们经常使用的选项有gc、gcutil
vmid：java进程id
interval：间隔时间，单位为毫秒
count：打印次数
```

打印结果：

```
S0C:年轻代第一个survivor的容量（字节）
S1C：年轻代第二个survivor的容量（字节）
S0U：年轻代第一个survivor已使用的容量（字节）
S1U：年轻代第二个survivor已使用的容量（字节）
EC：年轻代中Eden的空间（字节）
EU：年代代中Eden已使用的空间（字节）
OC：老年代的容量（字节）
OU:老年代中已使用的空间（字节）
PC：永久代的容量
PU：永久代已使用的容量
YGC：从应用程序启动到采样时年轻代中GC的次数
YGCT:从应用程序启动到采样时年轻代中GC所使用的时间（单位：S）
FGC：从应用程序启动到采样时老年代中GC（FULL GC）的次数
FGCT：从应用程序启动到采样时老年代中GC所使用的时间（单位：S）
```

示例：

```
jstat -gc 10010 1000 3  //对进程10010的每个1分钟打印一次，共3次
```

3 Jvisualvm 可视化工具

**linux使用以下命令启动，windows JMX 端口连接**

```java
/**
* 这是一整条命令
* hostname:linux的ip
* port windows连接用的端口
**/
java -Djava.rmi.server.hostname=192.168.32.129 
-Djava.security.policy=jstatd.all.policy 
-Dcom.sun.management.jmxremote.authenticate=false 
-Dcom.sun.management.jmxremote.ssl=false 
-Dcom.sun.management.jmxremote.port=8888 
-Xms1g -Xmx1g -jar pure-1.0-SNAPSHOT.jar
```

