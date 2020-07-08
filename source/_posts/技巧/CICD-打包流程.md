---
title: CICD-打包流程
date: 2017-07-01 16:01:33
categories: 技巧
tags: 技巧
---

<meta name="referrer" content="no-referrer" />


一 上报源码至215内网(开发人员提供)  
![image.png](https://upload-images.jianshu.io/upload_images/2803682-93171cdc611072d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
二 登录廋客户机下载上传的源码  
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ea6a203440dfc004.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
三 解压并替换git路径下文件，然后提交
1选中除了.git之外所有文件并删除，
![image.png](https://upload-images.jianshu.io/upload_images/2803682-fac5a7f6f21ce2a7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 所以解压的源码，全部复制到git目录下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-ceca50289cceafde.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 提交git代码
![image.png](https://upload-images.jianshu.io/upload_images/2803682-be2dcd2b8e889315.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4 点击commit，
![image.png](https://upload-images.jianshu.io/upload_images/2803682-041688a20b9e5088.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
出现success 代表提交成功
![image.png](https://upload-images.jianshu.io/upload_images/2803682-467207e875ffb14c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
5 推送至服务器
再次点击push，出现上图类似的success就成功了

四 登录cicd网站，开始构建
1 登录成功如下
![image.png](https://upload-images.jianshu.io/upload_images/2803682-821af009ca49458b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-4daf0b415385c9cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-6f045497b9393a88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7c11ee5ea0a85700.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](https://upload-images.jianshu.io/upload_images/2803682-109b64caafb554da.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

五 构建成功后下载解压
