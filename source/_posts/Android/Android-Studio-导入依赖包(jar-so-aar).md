---
title: Android-Studio-导入依赖包(jar-so-aar)
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


一.  Jar
直接放到lib目录，选中右键 add as library  即可

二.  so
在src/main中添加 jniLibs(与java目录同级)文件夹 ，把.so复制进去
build.gradle
```
sourceSets {
    main {
        jniLibs.srcDirs = ['libs']
    }
}
```

三.  aar
复制外部aar包FmMobile.so到libs目录下
build.gradle 配置文件
```
repositories{//添加aar依赖包
    flatDir{
        dirs 'libs'
    }
}

...
//添加依赖 
compile(name:'FmMobile',ext:'aar')//FmMobile对应aar名字
```
