---
title: Android-组件化简单使用
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


一 创建Module 
1. 主Module app   地图Module map   相机Module camera，基础Module commonlib
![image.png](https://upload-images.jianshu.io/upload_images/2803682-44405c4adec4b9ac.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

二. 添加全局控制文件
![image.png](https://upload-images.jianshu.io/upload_images/2803682-4d6986f2f998a68e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
ext {
    isAlone = false;//false:作为Lib组件存在，true:作为application存在
}
```
build.gradle 添加饮用
![image.png](https://upload-images.jianshu.io/upload_images/2803682-058cfb378c2e2859.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

三. 配置Module 的gradle文件
1. 是否是组建形式
```
//控制组件模式和集成模式
if (rootProject.ext.isAlone) {
    apply plugin: 'com.android.application'
} else {
    apply plugin: 'com.android.library'
}
```
```
 if (rootProject.ext.isAlone) {
            //组件模式下设置applicationId
            applicationId "com.example.camera"
        }
```
//是否设置独立module模块
```
    sourceSets {
        main {
            if (rootProject.ext.isAlone) {
                manifest.srcFile 'src/main/module/AndroidManifest.xml'
                java.srcDirs = ['src/main/java', 'src/main/module/java']
                res.srcDirs = ['src/main/res', 'src/main/module/res']
            } else {
                manifest.srcFile 'src/main/AndroidManifest.xml'
            }
//            jniLibs.srcDirs = ['libs']
        }
    }
```

最后应用commonlib
```
    implementation project(':commonlib')
```
四. 集成关系
1. camera，map 都需要继承 commonlib
2. app
```
    implementation project(':commonlib')
    if (!rootProject.ext.isAlone) {
        implementation project(':camera')
        implementation project(':map')
    }
```

说明：
1.commonlib中 不要使用implementation ,要用compile，具体区别百度下
```
 //这个失败
 implementation 'com.android.support:design:26.1.0'
//这个可以
 compile 'com.android.support:design:26.1.0'
```
2. multiDexEnabled 一定要放在app module模块下，不能放在commonlib中
3. 遇到莫名其妙问题可以尝试打开或关闭instant run 

详细的可以下载demo跑一下 很简单 https://git.coding.net/Lrxc/LrxcModularization.git
大神文章:https://mp.weixin.qq.com/s/4dc38cpZKCfxWxxRdUQfTQ






