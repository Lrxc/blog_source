---
title: Android 在线热更新_TinkerPatch
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


说明：TinkerPatch和Tinker并不是一个东西。TinkerPatch支持在线更新
想看Tinker的点这个http://www.jianshu.com/p/ad7deea62a07

一 ，注册平台账号
官网：http://www.tinkerpatch.com/ 
新建app，名字与本地项目名字保持一致
![image.png](http://upload-images.jianshu.io/upload_images/2803682-cf373bbd5ba1b5da.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

二 ：项目配置
1.  项目build.gradle配置
```
dependencies {
        ...
        // TinkerPatch 插件
        classpath "com.tinkerpatch.sdk:tinkerpatch-gradle-plugin:1.2.2"
    }
```
2 app build.gradle中
```
    implementation "com.android.support:multidex:1.0.2"
    //若使用annotation需要单独引用,对于tinker的其他库都无需再引用
    annotationProcessor("com.tinkerpatch.tinker:tinker-android-anno:1.9.2") { changing = true }
    compileOnly("com.tinkerpatch.tinker:tinker-android-anno:1.9.2") { changing = true }
    implementation("com.tinkerpatch.sdk:tinkerpatch-android-sdk:1.2.2") { changing = true }
```
```
    defaultConfig {
         ...
        multiDexEnabled true
    }
```

3. app目录新建下新建tinkerpatch.gradle
https://github.com/TinkerPatch/tinkerpatch-sample/blob/master/app/tinkerpatch.gradle
全部复制进去
app build.gradle添加依赖
```
apply from: 'tinkerpatch.gradle'
```
![image.png](http://upload-images.jianshu.io/upload_images/2803682-27720cb6e20eca64.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 初始化Application
新建SampleApplicationLike全部复制
https://github.com/TinkerPatch/tinkerpatch-sample/blob/master/app/src/main/java/tinker/sample/android/app/SampleApplicationLike.java

![image.png](http://upload-images.jianshu.io/upload_images/2803682-a027ae132d72b3a4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
名字要改成这汇总

打开manifest，名字与上图保持一致，开始报错，build下就好了
![image.png](http://upload-images.jianshu.io/upload_images/2803682-816097a2c6d27f0d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5. 配置key，版本
打开tinkerpatch.gradle
![image.png](http://upload-images.jianshu.io/upload_images/2803682-1ac75ad810633b70.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
key是刚才申请的
6. 界面
一个显示信息，一个按钮关闭进程
![image.png](http://upload-images.jianshu.io/upload_images/2803682-631431d5fc42ae92.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-20f9b5244072e5fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

三. 编译
1. 构建基础包
![image.png](http://upload-images.jianshu.io/upload_images/2803682-c0b71c37be9a3ef7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
成功后 安装即可
![image.png](http://upload-images.jianshu.io/upload_images/2803682-de8c1a07d48adba5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
界面如下
![image.png](http://upload-images.jianshu.io/upload_images/2803682-9e21956a6cdb3f64.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2 构建补丁包
1. 这句注释打开
![image.png](http://upload-images.jianshu.io/upload_images/2803682-9f2b1ab454dcc741.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2. 修改基础包名称
![image.png](http://upload-images.jianshu.io/upload_images/2803682-d2718b3a837d3f7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-30b4af5a1a1aa508.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3. 开始构建
![image.png](http://upload-images.jianshu.io/upload_images/2803682-f02b8047d79dfffa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-f116d60b00c6d42d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

4. 上传
![image.png](http://upload-images.jianshu.io/upload_images/2803682-d186b64e0e08b237.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-1b6db60cf7b09a28.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](http://upload-images.jianshu.io/upload_images/2803682-8d966dad202102e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
提交即可

5.启动app下载补丁(失败的看末尾处说明)
![image.png](http://upload-images.jianshu.io/upload_images/2803682-05c3fa8a4e4d12ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
看log有请求记录,重启app
![image.png](http://upload-images.jianshu.io/upload_images/2803682-f00178a7833438fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

说明 ：重要
![image.png](http://upload-images.jianshu.io/upload_images/2803682-99ac2f9edb9e2e73.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
SampleApplicationLike中默认配置3个小时才会检查一次，所以刚才启动一次，再启动是不会检查的。。。
方法：app清除数据或者卸载重装即可











