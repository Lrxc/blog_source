---
title: Android-Emulator-模拟器-Root和文件互传
date: 2016-07-01 16:01:33
categories: Android
tags: android
---

<meta name="referrer" content="no-referrer" />


##一 文件互传、共享
#### 1. 快接安装app或者复制文件到模拟器
![image.png](https://upload-images.jianshu.io/upload_images/2803682-2ba99f6e924f412a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 2. 文件导出
![image.png](https://upload-images.jianshu.io/upload_images/2803682-419dbc39248eddff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##一 Emulator 模拟器 获取 Root
#### 一. 需要SuperSu.apk 和Recovery Flashable.zip
官网：http://www.supersu.com/download
https://supersuroot.org/downloads/?MA
百度云：https://pan.baidu.com/s/1F28p9XkIpFEGpnlFObyXmg 提取码:32iq
#### 二 获取Root
1. 使用Android Studio 创建模拟器
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1a86ecde6233808e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
2. 启动模拟器
```
// cmd终端进入到android sdk的tools目录下
// 查看有几个虚拟机
./emulator -list-avds
// 启动模拟器(avd_name 是创建的虚拟机的名称)
./emulator -avd avd_name -writable-system
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-c602161068331b4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
3.  安装SuperSu.apk
上面启动模拟器的终端不要关，新开一个
```
//apkpath SuperSu.apk路径
adb install apkpath
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-8a4b33298623a71a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
4. 获取Root
```
.\adb root
.\adb shell setenforce 0
.\adb remount
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-7e08f9aa7861058e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
5. Flashable.zip解压，把x86下的su.pie文件分别push到模拟器的system/bin和system/xbin目录下
```
//su.pie的路径不要有中文、空格等
.\adb push .\x86\su.pie /system/bin/su
.\adb push .\x86\su.pie /system/xbin/su
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-1e9a4d83b0486b30.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
6. 修改权限，安装su
```
.\adb shell chmod 0755 /system/bin/su
.\adb shell chmod 0755 /system/xbin/su
.\adb shell su --install
.\adb shell "su --daemon&"
```
![image.png](https://upload-images.jianshu.io/upload_images/2803682-d4a41f0b8bf2ee1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
7. 打开SuperSu。选择CANCEL 取消就行了
![image.png](https://upload-images.jianshu.io/upload_images/2803682-9d9de76685a970e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

8. 重启后root失效，重新执行
```
.\adb root
.\adb shell setenforce 0
.\adb remount
.\adb push .\x86\su.pie /system/bin/su
.\adb push .\x86\su.pie /system/xbin/su
.\adb shell chmod 0755 /system/bin/su
.\adb shell chmod 0755 /system/xbin/su
.\adb shell su --install
.\adb shell "su --daemon&"
```

参考：https://juejin.im/post/5cd2839de51d453a6c23b080
