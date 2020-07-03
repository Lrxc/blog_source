---
title: MacOS-环境变量配置
date: 2017-07-01 16:01:33
categories: MacOS
tags: macos
---


一  配置bash_profile文件
macos 环境配置就是配置bash_profile文件 
1 终端输入
```
sudo vim ~/.bash_profile
或
open -e .bash_profile
```
2 配置环境内容
```
$ 具体环境内容
```
3  保存后，更新文件
```
source ~/.bash_profile
```

二 bash_profile 内容
1 Java环境配置
```
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home
PATH=$PATH:$JAVA_HOME/bin
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JAVA_HOME PATH CLASSPATH
```

2 Gradle环境配置
```
GRADLE_HOME=/Users/lrxc/.gradle/gradle-4.6 (Gradle的本机路径)
export GRADLE_HOME
export PATH=$PATH:$GRADLE_HOME/bin
```

3 Android adb环境配置
```
export PATH=/Users/lrxc/Library/Android/sdk/platform-tools/:$PATH
```

![image.png](https://upload-images.jianshu.io/upload_images/2803682-880b629481ecd6ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

三 基本命令失效
```
command not found
解决：
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin"
```
