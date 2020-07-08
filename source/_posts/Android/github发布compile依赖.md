---
title: github发布compile依赖
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


1. 本地新建Android Studio项目
2. 新建Module，选择Android library(我的名字是dialog)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-a8928b8a63a273f2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 删除项目下的app Module，只留Android library
![image.png](http://upload-images.jianshu.io/upload_images/2803682-1332d96acd94e979.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. 编写内容 项目中 无需 无需 无需 做任何特殊处理  例如这种
```
  classpath 'com.github.dcendents:android-maven-gradle-plugin:1.5'
   apply plugin: 'com.github.dcendents.android-maven'  
   group='com.github.你的guihub的账户名字'
```
5. 使用git上传到github
6. 选择发布
![image.png](http://upload-images.jianshu.io/upload_images/2803682-3b8c5ad8b82794ee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
7. 发布内容
![image.png](http://upload-images.jianshu.io/upload_images/2803682-e2858992cd6935d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
8. 打开https://jitpack.io/ 
![image.png](http://upload-images.jianshu.io/upload_images/2803682-cee89e06d7a4374d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
9. 集成进项目
![image.png](http://upload-images.jianshu.io/upload_images/2803682-3ac50e5ed4d1e739.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


我的测试项目
![GIF.gif](http://upload-images.jianshu.io/upload_images/2803682-e5b60c6a49471862.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

https://github.com/Lrxc/lrxcdialog
添加依赖 参考步骤9
```
maven { url 'https://jitpack.io' }
compile 'com.github.Lrxc:lrxcdialog:1.2'
```



