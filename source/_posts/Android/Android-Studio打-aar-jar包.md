---
title: Android-Studio打-aar-jar包
date: 2016-07-01 16:01:33
categories: Android
tags: android
---


aar 打包：
1  新建Module 选择Android Libray 
![image.png](https://upload-images.jianshu.io/upload_images/2803682-67bc81c4aef20afc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2 gradle直接生成
![image.png](https://upload-images.jianshu.io/upload_images/2803682-88b02cf95fb67c4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3 生成目录
![image.png](https://upload-images.jianshu.io/upload_images/2803682-14a38b7ee663005b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


jar 打包：
1  新建Module 选择Android Libray 
在library工程的build.gradle文件中添加如下代码
```
task makeJar(type: Copy) {
    delete 'build/outputs/libs/mysdk.jar'//删除存在的
    from('build/intermediates/bundles/release/')//这行表示要打包的文件的路径
    into('build/outputs/libs/')//生成jar包后的文件目录
    include('classes.jar')//设置过滤
    rename ('classes.jar', 'mysdk.jar')//重命名
}
```
2 终端运行
gradlew makeJar


