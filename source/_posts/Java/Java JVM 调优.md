---
title: Java JVM 调优
date: 2019-07-01 16:01:33
categories: Java
tags: java
---

<meta name="referrer" content="no-referrer" />


## 一 SpringBoot调优

关于修改配置文件`application.properties`。

```
server.tomcat.max-connections=0 # Maximum number of connections that the server accepts and processes at any given time.
server.tomcat.max-http-header-size=0 # Maximum size, in bytes, of the HTTP message header.
server.tomcat.max-http-post-size=0 # Maximum size, in bytes, of the HTTP post content.
server.tomcat.max-threads=0 # Maximum number of worker threads.
server.tomcat.min-spare-threads=0 # Minimum number of worker threads.
```

```
jps -l -v
top -p 进程id  #按E键可以切换显示单位

RES：resident memory usage 常驻内存
VIRT：virtual memory usage	#进程“需要的”虚拟内存大小，包括进程使用的库、代码、数据等
```

## 二 Jvm调优

**启动参数**

```sh
# idea启动
-XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -Xms1024m -Xmx1024m -Xmn256m -Xss256k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC

# java jar启动
java -jar -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -Xms1024m -Xmx1024m -Xmn256m -Xss256k -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC newframe-1.0.0.jar

# 参数说明
-XX:MetaspaceSize=128m （元空间默认大小）
-XX:MaxMetaspaceSize=128m （元空间最大大小）
-Xms1024m （堆最大大小）
-Xmx1024m （堆默认大小）
-Xmn256m （新生代大小）
-Xss256k （棧最大深度大小）
-XX:SurvivorRatio=8 （新生代分区比例 8:2）
-XX:+UseConcMarkSweepGC （指定使用的垃圾收集器，这里使用CMS收集器）
-XX:+PrintGCDetails （打印详细的GC日志）
```

**jar附加参数**

```sh
java -jar xxx.jar

# 指定依赖包所在的仓库位置，如果仓库中没有需要的依赖，启动jar包时还会自动连接远程仓库进行下载
-Dthin.root=/root/repository 
#预加载程序，执行“试运行”,它只解析和下载依赖项，而不运行任何用户代码:
-Dthin.dryrun=true			 
```



## 三 监控命令

**1. jps**

显示当前所有java进程pid的命令，我们可以通过这个命令来查看到底启动了几个java进程

```java
jps    //显示当前所有java进程pid的命令
jps -l //jps -l 输出应用程序main.class的完整package名或者应用程序jar文件完整路径名
jps -v //输出传递给JVM的参数
```

**2. top**

```shell
ps -ef|grep java
top -p 进程id		#进入后按E键切换显示单位

RES：resident memory usage	#常驻内存
VIRT：virtual memory usage	#进程“需要的”虚拟内存大小，包括进程使用的库、代码、数据等
```

**3. jstat**

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

## 四 可视化工具

1. Jvisualvm 

   **linux使用以下命令启动，windows JMX 端口连接**

   ```
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

2. jconsole

   启动java/bin路径下jconsole.exe