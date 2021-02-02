---
title: PLSQL免安装Oracle客户端及问题
date: 2020-07-01 16:01:33
categories: Config
tags: config
---

<meta name="referrer" content="no-referrer" />


1. PLSQL 官网下载
https://www.allroundautomations.com/plsqldev.html
![image.png](https://upload-images.jianshu.io/upload_images/2803682-11234706e2971fe1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.Oracle InstantClient 下载
http://www.oracle.com/technetwork/database/database-technologies/instant-client/downloads/index.html

3. 安装PLSQL，然后解压instantclient-basic压缩包
打开Configure--Preferences,设置如下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-42612feaefc700e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4.切记，这个运行库一定要加，否则各种问题。。。
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7159ce7f52190360.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5.问题总结
 问题一： make sure you have the 64 bits Oracle Client installed
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2f0433b5e4ec9820.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
解决方法:上面第四条的运行库！！！

问题二：Initialization error
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7cc7ad2d95dee7e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
解决方法：上面第三条的打开Configure--Preferences配置



